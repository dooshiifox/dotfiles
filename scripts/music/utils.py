#!/usr/bin/env python3

import os
import subprocess
import re
import requests


def get_cover(file: str) -> str | None:
    if file.startswith("file://"):
        # Check the file actually exists
        if not os.path.exists(file[7:]):
            return None
        return file[7:]
    elif file.startswith("https://"):
        url = file
        file = os.path.expanduser("~/.cache/music/covers/current")
        # Recursively create the directory
        os.makedirs(os.path.dirname(file), exist_ok=True)
        # Fetch the file and save it locally somewhere
        resp = requests.get(url, stream=True, timeout=5)
        with open(file, "wb") as fileobj:
            for chunk in resp:
                fileobj.write(chunk)
        return file
    return file


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


def get_art_url() -> str | None:
    url = cmd("playerctl metadata mpris:artUrl")
    if url is None:
        return None
    return get_cover(url)


def get_local_art() -> str | None:
    title = get_title()
    album = get_album()
    artist = get_artist()
    if title is None or album is None or artist is None:
        return None

    def escape(s: str) -> str:
        return s.replace("\\", "\\\\").replace('"', '\\"').replace("'", "\\'")

    uri = cmd(
        f"mpc find \"((artist == '{escape(artist)}') AND (album == '{escape(album)}') AND (title == '{escape(title)}'))\""
    )
    if uri is None or uri == "":
        return None

    file = os.path.expanduser("~/.cache/music/covers/current")
    # Recursively create the directory
    os.makedirs(os.path.dirname(file), exist_ok=True)
    readpic = cmd(f'mpc readpicture "{uri}" > {file}')
    if readpic is None:
        return None
    return file


def get_title() -> str | None:
    return cmd("playerctl metadata xesam:title")


def get_album() -> str | None:
    return cmd("playerctl metadata xesam:album")


def get_artist() -> str | None:
    return cmd("playerctl metadata xesam:artist")


def is_color(s: str) -> str | None:
    # Returns true if `str` matches a hex color
    match = re.match(r"^#?((?:[0-9a-fA-F]{3}){1,2}|(?:[0-9a-fA-F]{4}){1,2})$", s)
    if match is None:
        return None
    return match.group(1)
