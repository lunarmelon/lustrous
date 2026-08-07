{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.moon.music;
in
{
  options.moon.music.enable = mkEnableOption "Enable mpd and services";

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      network.startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
      extraConfig = ''
        audio_output {
          type        "pulse"
          name        "Pulse Audio"
          mixer_type  "software"
        }
        audio_output {
          type        "fifo"
          name        "Visualizer"
          path        "/tmp/mpd.fifo"
          format      "44100:16:2"
        }
      '';
    };

    xdg.configFile."rmpc/themes/mocha.ron".text = ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
        cava: (
          orientation: Bottom,
          bar_width: 1,
          bar_spacing: 1,
          bg_color: "#1e1e2e",
          bar_color: Gradient({
            0: "#94e2d5", // gradient_color_1 (Bottom - Teal)
            14: "#89dceb", // gradient_color_2 (Sky)
            28: "#74c7ec", // gradient_color_3 (Sapphire)
            42: "#89b4fa", // gradient_color_4 (Blue)
            57: "#cba6f7", // gradient_color_5 (Mauve)
            71: "#f5c2e7", // gradient_color_6 (Pink)
            85: "#eba0ac", // gradient_color_7 (Maroon)
           100: "#f38ba8", // gradient_color_8 (Top - Red)
          }),
          bar_symbols: [' ', '▂', '▃', '▄', '▅', '▆', '▇', '█'],
        ),
      )
    '';

    programs = {
      cava.enable = true;
      rmpc = {
        enable = true;
        config = ''
          #![enable(implicit_some)]
          #![enable(unwrap_newtypes)]
          #![enable(unwrap_variant_newtypes)]
          (
            address: "127.0.0.1:6600",
            theme: "mocha",
            password: None,
            enable_config_hot_reload: true,
            cache_dir: None,
            on_song_change: None,
            volume_step: 5,
            max_fps: 30,
            scrolloff: 0,
            wrap_navigation: false,
            enable_mouse: true,
            select_current_song_on_change: false,
            album_art: (
              method: Auto,
              max_size_px: (width: 500, height: 500),
              disabled_protocols: ["http://", "https://"],
              vertical_align: Center,
              horizontal_align: Center,
            ),
            cava: (
              framerate: 60,
              autosens: true,
              sensitivity: 100,
              lower_cutoff_freq: 50,
              higher_cutoff_freq: 10000,
              input: (
                method: Fifo,
                source: "/tmp/mpd.fifo",
                sample_rate: 44100,
                channels: 2,
                sample_bits: 16,
              ),
              smoothing: (
                noise_reduction: 77,
                monstercat: false,
                waves: false,
              ),
            eq: [],
            ),
            tabs: [
              (
                name: "Queue",
                pane: Split(
                  direction: Horizontal,
                  panes: [
                    (size: "40%", pane: Pane(AlbumArt)),
                    (size: "60%", pane: Split(
                      direction: Vertical,
                        panes: [
                          (size: "50%", pane: Pane(Queue)),
                          (size: "50%", pane: Pane(Cava)),
                        ],
                    )),
                  ],
                ),
              ),
          (
              name: "Directories",
              border_type: None,
              pane: Pane(Directories),
          ),
          (
              name: "Artists",
              border_type: None,
              pane: Pane(Artists),
          ),
          (
              name: "Album Artists",
              border_type: None,
              pane: Pane(AlbumArtists),
          ),
          (
              name: "Albums",
              border_type: None,
              pane: Pane(Albums),
          ),
          (
              name: "Playlists",
              border_type: None,
              pane: Pane(Playlists),
          ),
          (
              name: "Search",
              border_type: None,
              pane: Pane(Search),
          ),
            ],
          )
        '';
      };
    };
  };
}