from kitty.tab_bar import as_rgb, draw_title, TabBarData, ExtraData, DrawData
from kitty.utils import color_as_int
from kitty.fast_data_types import Screen, Color
from .colors import colors


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    orig_fg = screen.cursor.fg
    left_sep, right_sep = (" ", "")
    tab_bg = screen.cursor.bg
    slant_fg = as_rgb(color_as_int(draw_data.default_bg))

    def draw_sep(which: str) -> None:
        screen.cursor.bg = slant_fg
        screen.cursor.fg = tab_bg
        screen.draw(which)
        screen.cursor.bg = tab_bg
        screen.cursor.fg = orig_fg

    max_tab_length += 1
    if max_tab_length <= 1:
        screen.draw("…")
    elif max_tab_length == 2:
        screen.draw("…|")
    elif max_tab_length < 6:
        draw_sep(left_sep)
        screen.draw(
            (" " if max_tab_length == 5 else "")
            + "…"
            + (" " if max_tab_length >= 4 else "")
        )
        draw_sep(right_sep)
    else:
        draw_sep(left_sep)
        screen.draw(" ")

        _, *tab_rest_data = tab
        tab_with_custom_name = TabBarData(custom_title(tab, draw_data), *tab_rest_data)
        draw_title(draw_data, screen, tab_with_custom_name, index, max_tab_length)
        extra = screen.cursor.x - before - max_tab_length
        if extra >= 0:
            screen.cursor.x -= extra + 3
            screen.draw("…")
        elif extra == -1:
            screen.cursor.x -= 2
            screen.draw("…")
        screen.draw(" ")
        draw_sep(right_sep)

    return screen.cursor.x


def custom_title(tab: TabBarData, draw: DrawData):
    def icon(col: str, icon: str):
        default = (
            (tab.active_fg or draw.active_fg)
            if tab.is_active
            else (tab.inactive_fg or draw.inactive_fg)
        )
        return f"{term_color(col)}{icon}{term_color(default)}"

    if tab.title.startswith("rmpc"):
        return icon("orange", "󰎆 ")

    if tab.title.startswith("mrng"):
        return icon("yellow", "󰇌 ")

    if tab.title.startswith("Yazi: "):
        dir = tab.title.split(" ", 1)[1]
        return f"{icon("yellow", "󰇥 ")} {dir}"

    if tab.title.startswith("e ") or tab.title.startswith("nvim "):
        dir = tab.title.split(" ", 1)[1]
        final_dir = dir.split("/")[-1]
        return f"{icon("lime", " ")} {final_dir}"

    if tab.title.startswith("ni "):
        return icon("dark-blue", " ")

    return tab.title


def term_color(col: str | int | Color):
    if col is None:
        debug("term color called with none")
        return ""

    if isinstance(col, int):
        r = col >> 16
        g = col >> 8 & 0xFF
        b = col & 0xFF
        return f"\033[38;2;{r};{g};{b}m"
    if isinstance(col, Color):
        return term_color(col.rgb)
    elif not col.startswith("#"):
        col = colors[col]
    col = col.replace("#", "").strip().lower()
    return term_color(int(col, base=16))


def debug(content: str):
    with open("debug.txt", "a") as f:
        f.write(content + "\n")
