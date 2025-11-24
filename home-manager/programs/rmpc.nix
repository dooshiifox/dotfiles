{ pkgs, ... }:
let
  on_song_change = pkgs.writeScriptBin "on_song_change" ''
    #!/usr/bin/env sh

    sticker=$(rmpc sticker get "$FILE" "playCount" | jq -r '.value')
    if [ -z "$sticker" ]; then
    	rmpc sticker set "$FILE" "playCount" "1"
    else
    	rmpc sticker set "$FILE" "playCount" "$((sticker + 1))"
    fi
  '';
in
{
  # https://mynixos.com/home-manager/options/programs.rmpc
  programs.rmpc = {
    enable = true;
    config = ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
        address: "/tmp/mpd_socket",
        cache_dir: "/tmp/rmpc/cache",
        on_song_change: ["${on_song_change}/bin/on_song_change"],
        lyrics: "/home/dooshii/Music/0lyrics",
        theme: "dooshii",
        keybinds: (
          navigation: {
            "r": Rate(kind: Modal(), current: true),
          }
        ),
        tabs: [
          (
            name: "Queue",
            pane: Split(
              direction: Horizontal,
              panes: [
                (
                  size: "30%",
                  pane: Split(
                    direction: Vertical,
                    panes: [
                      (
                        size: "3",
                        pane: Pane(Lyrics)
                      ),
                      (
                        size: "100%",
                        pane: Pane(AlbumArt)
                      ),
                    ],
                  ),
                ),
                (size: "70%", pane: Split(
                  direction: Vertical,
                  panes: [
                    (size: "70%", pane: Pane(Queue)),
                    (size: "30%", pane: Pane(Cava)),
                  ],
                )),
              ],
            ),
          ),
        ],
      )
    '';
  };
  xdg.configFile."rmpc/themes/dooshii.ron".text = ''
    (
      draw_borders: true,
      cava: (
        input: (
          method: Fifo,
          source: "/tmp/mpd.fifo",
          sample_rate: 44100,
          channels: 2,
          sample_bits: 16,
        ),
      ),
      song_table_format: [
        (
          prop: (kind: Property(Artist),
            default: (kind: Text("Unknown"))
          ),
          width: "30%",
        ),
        (
          prop: (kind: Property(Title),
            default: (kind: Property(Filename))
          ),
          width: "45%",
        ),
        (
          prop: (kind: Property(Album)
            default: (kind: Text("-"))
          ),
          width: "25%",
        ),
        (
          prop: (kind: Transform(Replace(content: (kind: Sticker("rating")), replacements: [
            (match:  "0", replace: (kind: Group([(kind: Text("     "))]))),
            (match:  "1", replace: (kind: Group([(kind: Text("·    "),style: (fg: "gray"))]))),
            (match:  "2", replace: (kind: Group([(kind: Text("*    "),style: (fg: "red"))]))),
            (match:  "3", replace: (kind: Group([(kind: Text("*·   "),style: (fg: "light_red"))]))),
            (match:  "4", replace: (kind: Group([(kind: Text("**   "),style: (fg: "yellow"))]))),
            (match:  "5", replace: (kind: Group([(kind: Text("**·  "),style: (fg: "light_yellow"))]))),
            (match:  "6", replace: (kind: Group([(kind: Text("***  "),style: (fg: "green"))]))),
            (match:  "7", replace: (kind: Group([(kind: Text("***· "),style: (fg: "light_green"))]))),
            (match:  "8", replace: (kind: Group([(kind: Text("**** "),style: (fg: "light_cyan"))]))),
            (match:  "9", replace: (kind: Group([(kind: Text("****·"),style: (fg: "magenta"))]))),
            (match: "10", replace: (kind: Group([
              (kind: Text("*"),style: (fg: "light_red"))
              (kind: Text("*"),style: (fg: "light_yellow"))
              (kind: Text("*"),style: (fg: "light_green"))
              (kind: Text("*"),style: (fg: "light_cyan"))
              (kind: Text("*"),style: (fg: "light_magenta"))
            ]))),
          ])), default: (kind: Text("  ?  "), style: (fg: "gray"))),
          width: "7",
          label: "    ",
          alignment: Right,
        ),
        (
          prop: (kind: Property(Duration),
            default: (kind: Text("-"), style: (fg: "light_red"))
          ),
          width: "8",
          label: " "
          alignment: Right,
        ),
      ],
    )
  '';
}
