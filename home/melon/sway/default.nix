{
  osConfig,
  lib,
  pkgs,
  config,
  self,
  ...
}:
let
  inherit (lib)
    mkIf
    mkOptionDefault
    concatStringsSep
    getExe
    mkMerge
    forEach
    elemAt
    ;

  modifier = "Mod4";
  inherit (osConfig.moon.system) sway;
in
{
  imports = [
    ./dunst.nix
    ./i3status-rust.nix
    ./swaylock.nix
    ./wl-clipboard.nix
    ./wleave.nix
    ./wlsunset.nix
  ];
  
  config = mkIf sway.enable {
    moon.packages = { inherit (pkgs) pulseaudio-ctl brightnessctl grim slurp; };

    wayland.windowManager.sway = {
      enable = true;

      package = null;

      systemd = {
        enable = true;
        xdgAutostart = true;
      };

      config = {
        inherit modifier;
        terminal = "${getExe config.programs.kitty.package}";
        defaultWorkspace = "1";

        menu = "${getExe config.programs.fuzzel.package}";

        output."*".bg = "${self}/assets/outset_island2.png fill";

        input = {
          "*" = {
            xkb_layout = "us,latam";
            xkb_options = "grp:alt_caps_toggle,ctrl:nocaps,ctrl:swapcaps";
          };

          # HP Laptop touchpadS
          "1267:12541:ELAN0712:00_04F3:30FD_Touchpad" = {
            dwt = "enabled";
            tap = "enabled";
            natural_scroll = "enabled";
            middle_emulation = "enabled";
          };
        };

        gaps.inner = 5;

        fonts = {
          names = [ "JetBrainsMono Nerd Font" ];
          size = 10.0;
        };

        bindswitches = 
          let
            laptop = "eDP-1";
          in
          {
            "lid:on" = {
              reload = true;
              locked = true;
              action = "output ${laptop} disable";
            };
            "lid:off" = {
              reload = true;
              locked = true;
              action = "output ${laptop} enable";
            };
          };

        colors = {
          focused = {
            childBorder = "$lavender";
            background = "$base";
            text = "$text";
            indicator = "$rosewater";
            border = "$lavender";
          };

          focusedInactive = {
            childBorder = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$rosewater";
            border = "$overlay0";
          };

          unfocused = {
            childBorder = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$rosewater";
            border = "$overlay0";
          };          
          
          urgent = {
            childBorder = "$peach";
            background = "$base";
            text = "$peach";
            indicator = "$overlay0";
            border = "$overlay0";
          };          
          
          placeholder = {
            childBorder = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$overlay0";
            border = "$overlay0";
          };

          background = "$base";
        };

        keybindings = mkOptionDefault {
          # Special keys to adjust volume via PulseAudio
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          # Special keys to adjust brightness via brightnessctl
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";

          # wleave
          "${modifier}+Shift+e" = "exec ${getExe pkgs.wleave}";

          # clipboard
          "${modifier}+Shift+v" = "exec ${self}/scripts/cliphist-fuzzel-img.sh";

          # screenshot
          "${modifier}+Shift+s" = "exec ${self}/scripts/screenshot.sh";
        };

        startup = [
          # clipboard
          {
            command = "wl-paste --type text --watch cliphist store";
            always = true;
          }
          {
            command = "wl-paste --type image --watch cliphist store";
            always = true;
          }

          # notifications
          { 
            command = "${getExe config.services.dunst.package}";
            always = true;
          }
        ];
      };

      extraConfig = concatStringsSep "\n" [
        "title_align center"
        "default_border pixel 1"
        "default_floating_border pixel 1"
      ];
    };
  };
}