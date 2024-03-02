#!/usr/bin/env python3

import colorsys
import math
import json
from typing import List, Tuple
from PIL import UnidentifiedImageError
from colorthief import ColorThief
import utils
import overrides


def to_hex(col: Tuple[int, int, int]):
    """Converts a color tuple to a hex string."""
    return f"#{min(col[0],255):02x}{min(col[1],255):02x}{min(col[2],255):02x}"


def brighten_color(color: Tuple[int, int, int]) -> Tuple[int, int, int]:
    """Brightens up a color."""
    bgcol = colorsys.rgb_to_hls(color[0] / 255, color[1] / 255, color[2] / 255)
    # increase the brightness and saturation
    bgcol = colorsys.hls_to_rgb(
        bgcol[0],
        (1 / 3) + (2 / 3) * math.exp(bgcol[1] - 1),
        (2 / 3) * math.exp(bgcol[2] - 1),
    )
    return (
        math.floor(bgcol[0] * 255),
        math.floor(bgcol[1] * 255),
        math.floor(bgcol[2] * 255),
    )


def hue_shift(color: Tuple[int, int, int]) -> Tuple[int, int, int]:
    """Shift a hue by 20 degrees."""
    hls = colorsys.rgb_to_hls(color[0] / 255, color[1] / 255, color[2] / 255)
    hls = colorsys.hls_to_rgb((hls[0] + 20 / 360) % 1, hls[1], hls[2])
    return (
        math.floor(hls[0] * 255),
        math.floor(hls[1] * 255),
        math.floor(hls[2] * 255),
    )


def get_colors(filename: str):
    """Generates a list of colors from an image.

    Args:
        filename (str): The file name or URL of the image to generate colors from.

    Returns:
        None | (str, str): The first color is the foreground color,
            the second is the background color. None if an error occured
    """
    try:
        color_thief = ColorThief(filename)
    except FileNotFoundError:
        return None
    except UnidentifiedImageError:
        return None

    palette: List[Tuple[int, int, int]] = color_thief.get_palette(color_count=10)
    max_threshold_lightness = 0.9
    min_threshold_lightness = 0.2
    max_threshold_saturation = 1
    min_threshold_saturation = 0.1
    found_cols = []
    for color in palette:
        hls = colorsys.rgb_to_hls(color[0] / 255, color[1] / 255, color[2] / 255)
        if (
            min_threshold_lightness <= hls[1] <= max_threshold_lightness
            and min_threshold_saturation <= hls[2] <= max_threshold_saturation
        ):
            found_cols.append(color)
            if len(found_cols) == 2:
                break

    if len(found_cols) == 2:
        return (to_hex(found_cols[0]), to_hex(found_cols[1]))
    elif len(found_cols) == 1:
        return (to_hex(found_cols[0]), to_hex(hue_shift(found_cols[0])))
    else:
        # Just try get *some* colors
        return (
            to_hex(palette[0]),
            to_hex((palette[0][0] + 60, palette[0][1] + 60, palette[0][2] + 60)),
        )


# |> get if color in title or album
#     |> YES: get if album art exists
#         |> YES: return title/album colors and album art
#         |> NO: check if local album art exists
#             |> YES: return title/album colors and local album art
#             |> NO: return title/album colors and default album art
#     |> NO: get if album art exists
#         |> YES: get album art colors
#             |> YES: return album art colors and album art
#             |> NO: return default album art colors and album art
#         |> NO: check if local album art exists
#             |> YES: get album art colors
#                 |> YES: return album art colors and local album art
#                 |> NO: return default album art colors and local album art
#             |> NO: return default album art colors and default album art


def main():
    colors = ["#CDB1F8", "#A2BBF6"]
    has_custom_colors = False

    album_name = utils.get_album()
    song_name = utils.get_title()

    custom_color = overrides.get_color_override(album_name, song_name)
    if custom_color is not None:
        colors = custom_color
        has_custom_colors = True
    # if song_name is not None:
    #     song_color = utils.is_color(song_name)
    #     if song_color is not None:
    #         has_custom_colors = True
    #         colors = [f"#{song_color}", f"#{song_color}"]

    # if album_name is not None and not has_custom_colors:
    #     album_color = utils.is_color(album_name)
    #     if album_color is not None:
    #         has_custom_colors = True
    #         colors = [f"#{album_color}", f"#{album_color}"]

    album_art = utils.get_art_url()
    print(album_art)
    if album_art is None:
        album_art = utils.get_local_art()

    if album_art is None:
        print(json.dumps({"cols": colors, "file": "", "error": "No art URL"}))
        return

    if not has_custom_colors:
        got_colors = get_colors(album_art)
        if got_colors is not None:
            colors = got_colors

    print(
        json.dumps(
            {
                "cols": colors,
                "file": album_art,
            }
        )
    )


if __name__ == "__main__":
    main()
