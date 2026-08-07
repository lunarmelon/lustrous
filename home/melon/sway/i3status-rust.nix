{
  lib,
  pkgs, 
  config,
  osConfig,
  ...
}:
let
  inherit (lib) mkIf;

  inherit (osConfig.moon.system) sway;
in
{
  config = mkIf sway.enable {
    wayland.windowManager.sway.config.bars = [ 
      { 
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${config.xdg.configHome}/i3status-rust/config-default.toml";
        
        fonts = {
          names = [ "JetBrainsMono Nerd Font" ];
          size = 10.0;
        };
        
        colors = {
          background = "$crust";
          statusline = "$text";
          focusedStatusline = "$text";
          focusedSeparator = "$crust";

          focusedWorkspace = {
            border = "$crust";
            background = "$mauve";
            text = "$crust";
          };

          activeWorkspace = {
            border = "$crust";
            background = "$surface2";
            text = "$text";
          };

          inactiveWorkspace = {
            border = "$crust";
            background = "$crust";
            text = "$text";
          };          
          
          urgentWorkspace = {
            border = "$crust";
            background = "$red";
            text = "$crust";
          };
        };
      } 
    ];
  
    programs.i3status-rust = {
      enable = true;
      bars = {
        default = {
          settings = {
            theme = {
              overrides = {
                end_separator = "";
                start_separator = "";
                separator = "|";
                separator_bg = "";
                separator_fg = "#cdd6f4";
                idle_bg = "#11111b";
                idle_fg = "";
                good_bg = "";
                good_fg = "";
                warning_bg = "#11111b";
                warning_fg = "#f9e2af";
                critical_bg = "#11111b";
                critical_fg = "#f38ba8";
                info_bg = "";
                info_fg = "#cba6f7";
                alternating_tint_bg = "";
                alternating_tint_fg = "";
              };
            };
            icons = {
              icons = "material-nf";
              overrides = {
                bat = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
                bat_charging = "󱐋";
              };
            };
          };
          blocks = [
            {
              block = "music";
              player = "mpd";
            }
            {
              block = "battery";
              driver = "upower";
              missing_format = "";
              info = 0;
              good = 0;
              warning = 20;
              critical = 10;
            }
            {
              block = "net";
              format = " $icon {$signal_strength $ssid|Wired }";
            }
            {
              block = "cpu";
              info_cpu = 100;
              warning_cpu = 70;
              critical_cpu = 90;
            }
            {
              block = "memory";
              format = " $icon $mem_total_used_percents.eng(w:2) ";
              format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
            }
            {
              block = "sound";
              click = [
                {
                  button = "left";
                  cmd = "pavucontrol";
                }
                {
                  button = "right";
                  cmd = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                }
              ];
            }
            {
              block = "time";
              interval = 60;
              format = {
                short = " $timestamp.datetime(f:'%a %d-%b') ";
                full = " $timestamp.datetime(f:'%a %d-%b %R') ";
              };
            }
          ];
        };
      };
    };
  };
}