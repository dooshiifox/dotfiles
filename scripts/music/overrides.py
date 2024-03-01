"""Returns overridden colors for a song or album."""


def get_color_override(album: str | None, song: str | None):
    """Returns overridden colors for a song or album."""
    if album is None or song is None:
        return None

    # Search for exact album and song
    col = OVERRIDE_MAP.get((album, song), None)
    if col is not None:
        return col

    # Search for exact album
    col = OVERRIDE_MAP.get(album, None)
    if col is not None:
        return col

    # If your searching for exact song, why?

    return None

OVERRIDE_MAP: dict[tuple[str, str] | str, tuple[str, str]] = {
    "0x10c": ("#000000", "#000000"),
    "2012 Singles": ("#ccd2e7", "#738E32"),
    "2020 Collections": ("#955E95", "#7A6CA7"),
    "A Hat in Time OST": ("#E889AB", "#A3CFFC"),
    "A Short Hike (Original Soundtrack)": ("#f3c443", "#b4d822"),
    "Celeste Spring Collab, Vol. A": ("#EFE19D", "#FA65B3"),
    "Chicory: A Colorful Tale (Original Soundtrack)": ("#e5f0fa", "#5959db"),
    "Chipped of the NecroDancer": ("#c44781", "#402263"),
    "CraftedMusic": ("#B2DCF5", "#e2f5ef"),
    "DELTARUNE Chapter 2 OST": ("#bd2c2c", "#411919"),
    "Dicey Dungeons Original Soundtrack": ("#E33241", "#e7ab98"),
    "Exile": ("#8f8c7d", "#1E1E20"),
    "Happy Halloween 2017": ("#4e3030", "#D72D20"),
    "Hyrule Warriors: Age of Calamity Complete Soundtrack": ("#f09731", "#cc1d2c"),
    "Little Spoon": ("#E0EEF9", "#FFFFFF"),
    "Mario Kart 8 Deluxe Original Sound Version": ("#d43744", "#55b6ee"),
    "Moonglow Bay (Original Soundtrack)": ("#557d9c", "#1e3470"),
    "music for bugs": ("#dacb9b", "#d6d46b"),
    "Paragon": ("#A5A5A5", "#070707"),
    "Parallel Processing": ("#8f1d54", "#1f2b31"),
    "Pokémon Scarlet & Pokémon Violet: The Definitive Soundtrack": ("#D65355", "#9950A9"),
    "Rise of the Obsidian Interstellar": ("#D0AF67", "#622D52"),
    "strawberry jams vol. 1": ("#6ba2d6", "#A55262"),
    "strawberry jams vol. 2": ("#e6265f", "#A55262"),
    "strawberry jams vol. 3": ("#ebbe44", "#A55262"),
    "strawberry jams vol. 4": ("#eb8744", "#A55262"),
    "strawberry jams vol. 5": ("#b46ad6", "#A55262"),
    "Super Mario Odyssey Original Sound Track": ("#cc777c", "#E4192A"),
    "SYM": ("#F5F5F5", "#000000"),
    "The Glory Days": ("#FC0908", "#320A18"),
    "TUNIC (Original Game Soundtrack)": ("#a04ecf", "#3b2b68"),
}
