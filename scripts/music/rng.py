"""Randomly add songs to the MPD queue based on a rating/bias system."""

import fcntl
import json
import os
import statistics
import subprocess
import sys
import termios
import threading
from dataclasses import dataclass
from random import random as randfloat
from typing import Literal, Optional

# https://python-mpd2.readthedocs.io/en/latest/
from mpd import MPDClient

# Read the playbias from the commandline if it exists as a pipe-seperated array
# of floats.
# -1 as the first value means all unrated songs will be added
#   - sorted by artist
#   - then by album name
#   - then by track number
# immediately to the end of the queue, regardless of `MAX_QUEUE_SIZE`
# e.g.,
# DEFAULT_PLAY_BIAS = "100000|0|0|0|0|0.3|0.7|1|0.8|0.6|0.4"
DEFAULT_PLAY_BIAS = "-1|0|0|0|0|0.1|0.3|0.8|1|0.9|0.6"
bias_str = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_PLAY_BIAS
PLAY_BIAS: dict[Optional[float], float] = {
    (None if i == 0 else i): bias
    for i, bias in enumerate(map(float, bias_str.split("|")))
}

# Songs present in the queue will not be added to the queue
MAX_QUEUE_SIZE = int(sys.argv[2]) if len(sys.argv) > 2 else 400


def cmd(command: str) -> str | None:
    by = subprocess.Popen(
        command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE
    ).stdout
    if by is None:
        return None
    s = by.read().decode().strip()
    if s == "":
        return None
    return s


class SongNotFoundError(Exception):
    """Song was not found in the MPD database."""


def format_duration(duration):
    """Format a duration as hh:mm:ss"""
    hours = int(duration / 3600)
    minutes = int((duration % 3600) / 60)
    seconds = int(duration % 60)
    return f"{hours:02}:{minutes:02}:{seconds:02}"


@dataclass
class SongLink:
    """A link to a song."""

    to: str
    priority: Literal["low", "medium", "high"]


@dataclass
class SongData:
    """General information about a song."""

    file: str

    bias: float
    rating: Optional[float]
    base_bias: float
    play_count: int
    avg_play_count_at_add: int | None

    link: Optional[SongLink]

    artist: Optional[str]
    album: Optional[str]
    title: Optional[str]
    disc: Optional[int]
    track: Optional[int]
    duration: float


class BiasedRandomRating:
    """Randomly add songs to the MPD queue based on a rating/bias system."""

    # { "song_uri": SongData }
    songs: dict[str, SongData]
    client: MPDClient
    total_bias: float

    last_playing_song: Optional[str]
    """The file of the last song that was playing. `None` if no previous song."""

    def __init__(self, client):
        self.client = client
        self.last_playing_song = None
        self.update_songs()

    def update_songs(self):
        """Update the local song listing and their ratings and biases."""
        self.songs = {}

        for song in self.client.listallinfo(""):
            if "directory" in song:
                continue

            if "file" not in song:
                print("wtf no file???", song)
                continue
            file = song["file"]

            if "duration" not in song:
                print("wtf no duration???", song)
                continue
            duration = float(song["duration"])

            artist = song.get("artist")
            album = song.get("album")
            title = song.get("title")
            disc = song.get("disc")
            disc = int(disc) if disc is not None else None
            track = song.get("track")
            track = int(track) if track is not None else None

            self.songs[file] = SongData(
                file,
                1,
                None,
                1,
                0,
                None,
                None,
                artist,
                album,
                title,
                disc,
                track,
                duration,
            )

        for result in self.client.sticker_find("song", "", "rating"):
            if result["file"] not in self.songs:
                raise SongNotFoundError(
                    f"Sticker for non-existent song: {result['file']}"
                )

            rating = float(result["sticker"].split("=")[1])
            self.songs[result["file"]].rating = rating

        for result in self.client.sticker_find("song", "", "base_bias"):
            if result["file"] not in self.songs:
                raise SongNotFoundError(
                    f"Sticker for non-existent song: {result['file']}"
                )

            bias = float(result["sticker"].split("=")[1])
            self.songs[result["file"]].base_bias = bias

        for result in self.client.sticker_find("song", "", "play_count"):
            if result["file"] not in self.songs:
                raise SongNotFoundError(
                    f"Sticker for non-existent song: {result['file']}"
                )

            play_count = int(result["sticker"].split("=")[1])
            self.songs[result["file"]].play_count = play_count

        for result in self.client.sticker_find("song", "", "avg_play_count_at_add"):
            if result["file"] not in self.songs:
                raise SongNotFoundError(
                    f"Sticker for non-existent song: {result['file']}"
                )

            avg_play_count_at_add = int(float(result["sticker"].split("=")[1]))
            self.songs[result["file"]].avg_play_count_at_add = avg_play_count_at_add

        for result in self.client.sticker_find("song", "", "link"):
            if result["file"] not in self.songs:
                raise SongNotFoundError(
                    f"Sticker for non-existent song: {result['file']}"
                )

            value = result["sticker"].split("=")[1]
            # json parse the value
            jsoned = json.loads(value)
            link = SongLink(jsoned["to"], jsoned["priority"])
            self.songs[result["file"]].link = link

        self.try_add_unrated_songs()
        self.update_biases()

    def try_add_unrated_songs(self):
        """
        If any unrated songs exist and `PLAY_BIAS[None]` is -1,
        this will add all the unrated songs to the queue in-order.

        It ignores the value of `MAX_QUEUE_SIZE`
        """
        if PLAY_BIAS.get(None) == -1:
            unrated_songs = list(
                filter(lambda s: s.rating is None, self.songs.values())
            )
            unrated_songs.sort(key=lambda s: s.track or 0, reverse=False)
            unrated_songs.sort(key=lambda s: s.disc or 0, reverse=False)
            unrated_songs.sort(key=lambda s: s.album or "", reverse=False)
            # unrated_songs.sort(key=lambda s: s.artist or "", reverse=False)

            # make sure not to add any songs already in queue
            songs_in_queue = list(map(lambda s: s["file"], self.client.playlistinfo()))
            for song in unrated_songs:
                if song.file not in songs_in_queue:
                    self.client.add(song.file)

    def update_biases(self):
        """Update the bias of each song and the total bias."""
        self.total_bias = 0

        # Calculate the median playcount by basebias of each rating
        playcounts: dict[float | None, list[float]] = {}
        for song in self.songs.values():
            if not song.rating in playcounts:
                playcounts[song.rating] = []
            if song.avg_play_count_at_add is not None:
                playcounts[song.rating].append(
                    (song.avg_play_count_at_add + song.play_count) * song.base_bias
                )

        median_playcounts: dict[float | None, float] = {}
        for rating, playcounts_for_rating in playcounts.items():
            try:
                median_playcounts[rating] = statistics.median(playcounts_for_rating)
            except statistics.StatisticsError:
                median_playcounts[rating] = 0

        # Now calculate how likely a given song is to play based
        # on how far it is from its median playcount
        for song in self.songs.values():
            # Set average play count at the time of song mount if not already set
            # (i.e., the song was just mounted)
            median_for_rating = median_playcounts[song.rating]
            if song.avg_play_count_at_add is None and song.rating is not None:
                self.client.sticker_set(
                    "song",
                    song.file,
                    "avg_play_count_at_add",
                    int(median_for_rating),
                )
                song.avg_play_count_at_add = int(median_for_rating)

            # Calculate how often this song has played, with respect to
            # its base bias
            # `or 1` prevents division by 0, it gets multiplied by 0 anyways below
            playcount = (song.play_count / (song.base_bias or 1)) + (
                song.avg_play_count_at_add or median_for_rating
            )
            diff_from_median = median_for_rating - playcount

            song.bias = 1.3**diff_from_median * song.base_bias * PLAY_BIAS[song.rating]
            self.total_bias += song.bias
        print("Updated biases")

    def get_random_song(self) -> str:
        """Get a random song based on the bias."""
        random = self.total_bias * randfloat()

        for song, data in self.songs.items():
            random -= data.bias

            if random <= 0:
                return song

        raise SongNotFoundError("No random song found")

    def get_random_song_not_in_queue(self) -> Optional[str]:
        """Get a random song that is not in the current MPD queue."""
        songs_in_queue = list(map(lambda s: s["file"], self.client.playlistinfo()))

        max_iter = 1000
        i = 0
        while True:
            i += 1
            song = self.get_random_song()

            if song not in songs_in_queue:
                return song
            if i > max_iter:
                print("Max iterations reached attempting to find song not in queue.")
                return None

    def get_link_song(self, song: str) -> Optional[str]:
        """Get a song that is linked to the given song."""
        previous_song_data = self.songs[song]
        if previous_song_data.link is None:
            return

        # Check the linked song actually exists
        if previous_song_data.link.to not in self.songs:
            return

        chance = 0
        if previous_song_data.link.priority == "low":
            # 30% chance
            chance = 0.3
        elif previous_song_data.link.priority == "medium":
            # 60% chance
            chance = 0.6
        elif previous_song_data.link.priority == "high":
            # 100% chance
            chance = 1

        if randfloat() < chance:
            return previous_song_data.link.to
        return

    def add_songs_to_queue(self):
        """Add a random song to the queue if needed."""
        current_queue = list(map(lambda song: song["file"], self.client.playlistinfo()))
        current_size = len(current_queue)
        if current_size >= MAX_QUEUE_SIZE:
            return

        for _ in range(MAX_QUEUE_SIZE - current_size):
            # Get the previous song, see if it has a link, and try add it if so
            if len(current_queue) > 0:
                previous_song = current_queue[-1]
                result = self.get_link_song(previous_song)
                if result is not None:
                    self.client.add(result)
                    current_queue.append(result)
                    continue

            song = self.get_random_song_not_in_queue()
            if song is None:
                break

            self.client.add(song)
            current_queue.append(song)

    def update_play_count(self):
        """Updates the sticker counting the number of times a song has been played."""
        current_song = self.client.currentsong()["file"]
        if self.last_playing_song is None:
            self.last_playing_song = current_song
            return

        # User probably pressed pause or something to cause the `player` event
        # to fire. Just ignore it.
        if self.last_playing_song == current_song:
            return

        # A little extra: double-check the previous song was given a rating,
        # and go back to it if not.
        previous_song = self.songs[self.last_playing_song]
        if previous_song is None:
            print("COULD NOT FIND SONG: ", self.last_playing_song)
            return
        if previous_song.rating is None:
            self.client.previous()
            self.client.pause()
            return

        self.last_playing_song = current_song
        current_song_info = self.songs[current_song]
        if current_song_info is None:
            print("COULD NOT FIND SONG: ", current_song)
            return
        current_song_info.play_count += 1
        self.client.sticker_set(
            "song", current_song, "play_count", current_song_info.play_count
        )

    def listen(self):
        """
        Listen for MPD events and add songs to the queue or
        update the database.
        """
        while True:
            event = self.client.idle("sticker", "database", "playlist", "player")
            if "sticker" in event or "database" in event:
                # print("Database changed")
                self.update_songs()
                # print("Database change finished")
            if "playlist" in event:
                # print("Playlist changed")
                self.add_songs_to_queue()
            if "player" in event:
                self.update_play_count()


def read_single_keypress():
    """Waits for a single keypress on stdin.

    This is a silly function to call if you need to do it a lot because it has
    to store stdin's current setup, setup stdin for reading single keystrokes
    then read the single keystroke then revert stdin back after reading the
    keystroke.

    Returns a tuple of characters of the key that was pressed - on Linux,
    pressing keys like up arrow results in a sequence of characters. Returns
    ('\x03',) on KeyboardInterrupt which can happen when a signal gets
    handled.
    """

    fd = sys.stdin.fileno()
    # save old state
    flags_save = fcntl.fcntl(fd, fcntl.F_GETFL)
    attrs_save = termios.tcgetattr(fd)
    # make raw - the way to do this comes from the termios(3) man page.
    attrs = list(attrs_save)  # copy the stored version to update
    # iflag
    attrs[0] &= ~(
        termios.IGNBRK
        | termios.BRKINT
        | termios.PARMRK
        | termios.ISTRIP
        | termios.INLCR
        | termios.IGNCR
        | termios.ICRNL
        | termios.IXON
    )
    # oflag
    attrs[1] &= ~termios.OPOST
    # cflag
    attrs[2] &= ~(termios.CSIZE | termios.PARENB)
    attrs[2] |= termios.CS8
    # lflag
    attrs[3] &= ~(
        termios.ECHONL | termios.ECHO | termios.ICANON | termios.ISIG | termios.IEXTEN
    )
    termios.tcsetattr(fd, termios.TCSANOW, attrs)
    # turn off non-blocking
    fcntl.fcntl(fd, fcntl.F_SETFL, flags_save & ~os.O_NONBLOCK)
    # read a single keystroke
    ret = []
    ret.append(sys.stdin.read(1))  # returns a single character
    fcntl.fcntl(fd, fcntl.F_SETFL, flags_save | os.O_NONBLOCK)
    stdin_char = sys.stdin.read(1)  # returns a single character
    while len(stdin_char) > 0:
        ret.append(stdin_char)
        stdin_char = sys.stdin.read(1)
    # restore old state
    termios.tcsetattr(fd, termios.TCSAFLUSH, attrs_save)
    fcntl.fcntl(fd, fcntl.F_SETFL, flags_save)
    return tuple(ret)


class InfoPrinter:
    """Prints information on keypress."""

    def __init__(self, brr: BiasedRandomRating):
        self.brr = brr

    def print_info(self):
        """Prints the current percentage of songs that are rated, unrated, and
        the duration of each.
        """
        rated = list(filter(lambda s: s.rating is not None, self.brr.songs.values()))
        unrated = list(filter(lambda s: s.rating is None, self.brr.songs.values()))

        r_count = len(rated)
        u_count = len(unrated)

        rated_dur = sum(map(lambda s: s.duration, rated))
        unrated_dur = sum(map(lambda s: s.duration, unrated))

        rated_percent = r_count / (r_count + u_count) * 100
        unrated_percent = u_count / (r_count + u_count) * 100
        rated_dur_percent = rated_dur / (rated_dur + unrated_dur) * 100

        print()
        rated_str = f"Rated: {r_count} ({rated_percent:.4f}%)"
        unrated_str = f"Unrated: {u_count} ({unrated_percent:.4f}%)"
        print(f"{rated_str} | {unrated_str}")

        rated_dur_str = format_duration(rated_dur)
        total_dur_str = format_duration(unrated_dur + rated_dur)
        print(f"{rated_dur_str}/{total_dur_str} ({rated_dur_percent:.4f}%)")

    def set_song_rating(self):
        """Sets the rating of a song."""
        song = cmd("mpc current -f '%file%'")
        if song is None:
            print("No song playing")
            return
        existing_rating = self.brr.songs[song]
        print(
            f"Current song rating: {int(existing_rating.rating or 0)} | {existing_rating.base_bias}"
        )

        inputted = input("Rating | bias: ")
        rb = inputted.split("|")
        rating = rb[0].strip()
        bias = rb[1].strip() if len(rb) > 1 else ""
        if len(rating) > 0:
            rating = float(rating)
            if not rating.is_integer() or rating < 1 or rating > 10:
                print("rating is not valid")
                return
            cmd(f"mpc sticker \"{song}\" set 'rating' {int(rating)}")
        if len(bias) > 0:
            bias = float(bias)
            if bias < 0 or bias > 5:
                print("bias is not valid")
                return
            if bias.is_integer():
                bias = int(bias)
            cmd(f"mpc sticker \"{song}\" set 'base_bias' {bias}")

    def print_rating_stats(self):
        """Prints the number of songs rated in each category."""
        ratings = {key: 0 for key in PLAY_BIAS.keys()}
        for song in self.brr.songs.values():
            ratings[song.rating] += 1

        print()
        for rating, count in ratings.items():
            print(f"{rating}: {count}")

    def print_listenable_length(self):
        """Prints the total length of all songs that can be played."""
        total_length = 0
        for song in self.brr.songs.values():
            if song.bias > 0:
                total_length += song.duration

        print()
        print(f"Listenable length: {format_duration(total_length)}")

    def print_longest_artists(self):
        """Prints the artists that contribute the longest playtime."""
        artist_totals = {}
        for song in self.brr.songs.values():
            artist = song.artist or "Unknown"
            totals = artist_totals.get(song.artist, {"all": 0, "playable": 0})

            totals["all"] += song.duration
            if song.bias > 0:
                totals["playable"] += song.duration

            artist_totals[artist] = totals

        print()
        for artist, total in sorted(
            artist_totals.items(), key=lambda item: item[1]["all"], reverse=True
        ):
            print(
                f"{artist}: {format_duration(total['playable']).rjust(10)} | {format_duration(total['all'])}"
            )

    def print_unliked_songs_by_artist(self, artist: str):
        """Prints the names of songs that aren't playable (not including base bias) by a specific artist."""
        print()
        for song in self.brr.songs.values():
            if song.artist == artist and PLAY_BIAS[song.rating] == 0:
                print(f"{song.title} - {song.album}")

    def average_album_ratings(self, album: str):
        """Prints the average rating of songs in an album."""
        songs = list(filter(lambda s: s.album == album, self.brr.songs.values()))
        ratings = list(map(lambda s: s.rating, songs))
        ratings = list(filter(lambda r: r is not None, ratings))
        if len(ratings) == 0:
            print("nothin")
            return

        # get the highest rated song(s)
        highest_rating = max(ratings)
        highest_rated_songs = list(filter(lambda s: s.rating == highest_rating, songs))
        highest_rated_songs = list(map(lambda s: s.title, highest_rated_songs))
        print(f"highest rated song(s) @ {highest_rating} / 10")
        for song in highest_rated_songs:
            print(f"  {song}")
        return print(f"average for album: {sum(ratings) / len(ratings)}")

    def average_albums_ratings(self):
        """Prints the average of all songs in all albums, sorted."""
        albums = {}
        for song in self.brr.songs.values():
            if song.album not in albums:
                albums[song.album] = []
            if song.rating is not None:
                albums[song.album].append(song.rating)

        album_ratings = {}
        for album, ratings in albums.items():
            if len(ratings) > 2:
                album_ratings[album] = sum(ratings) / len(ratings)

        for album, rating in sorted(album_ratings.items(), key=lambda item: item[1]):
            print(f"{album}: {rating}")

    def ratings_from_album(self, album: str):
        """Prints all ratings of songs in an album."""
        songs = list(filter(lambda s: s.album == album, self.brr.songs.values()))
        songs.sort(key=lambda s: s.track or 0, reverse=False)
        for song in songs:
            print(f"{int(song.rating or 0)} {song.title}")

    def print_help(self):
        """
        Prints the available commands and their descriptions.
        """
        print(
            """
    h: Print this help
    c: Print info
    r: Sets the rating/bias of the currently playing song
    s: Print rating stats
    l: Print listenable length
    a: Print longest artists
    m: Print unliked songs by artist
    i: Inputtable commands
        longest: Print the longest songs
        longestname: Print the longest songs
        averagealbum: Print the average rating of songs in an album
        averageall: Print the average rating of all songs in all albums
        songsalbum: Print all ratings of songs in an album
    """
        )

    def print_inputable(self):
        """Miscelannouskjdna commands"""
        cmd = input("Command?: ")
        if cmd == "longest":
            sorted_songs = sorted(
                self.brr.songs.values(), key=lambda s: s.duration, reverse=True
            )
            for i in range(50, -1, -1):
                song = sorted_songs[i]
                print(
                    f"{song.artist} - {song.album} - {song.title} ({format_duration(song.duration)})"
                )
        elif cmd == "longestname":
            sorted_songs = sorted(
                self.brr.songs.values(), key=lambda s: len(s.title or ""), reverse=True
            )
            for i in range(50, -1, -1):
                song = sorted_songs[i]
                print(
                    f"{song.artist} - {song.album} - {song.title} ({len(song.title or '')})"
                )
        elif cmd == "averagealbum":
            album = input("Album?: ")
            self.average_album_ratings(album)
        elif cmd == "averageall":
            self.average_albums_ratings()
        elif cmd == "songsalbum":
            album = input("Album?: ")
            self.ratings_from_album(album)

    def run(self):
        """Run the info printer."""
        while True:
            key = read_single_keypress()
            if key == ("c",):
                self.print_info()
            if key == ("h",):
                self.print_help()
            elif key == ("r",):
                self.set_song_rating()
            elif key == ("s",):
                self.print_rating_stats()
            elif key == ("l",):
                self.print_listenable_length()
            elif key == ("a",):
                self.print_longest_artists()
            elif key == ("m",):
                artist = input("Artist?: ")
                self.print_unliked_songs_by_artist(artist)
            elif key == ("i",):
                self.print_inputable()
            elif key == ("\x03",):
                # Ctrl-C, self-terminate
                raise KeyboardInterrupt()


def main():
    """Creates an MPD client that stars the BiasedRandomRating system."""

    client = MPDClient()
    client.connect("/tmp/mpd_socket")
    brr = BiasedRandomRating(client)
    brr.add_songs_to_queue()

    try:
        # brr.listen()
        rng_thread = threading.Thread(target=brr.listen)
        rng_thread.daemon = True
        rng_thread.start()

        info_printer = InfoPrinter(brr)
        info_printer.run()
    except KeyboardInterrupt:
        print()
        print("Exiting...")


if __name__ == "__main__":
    main()
