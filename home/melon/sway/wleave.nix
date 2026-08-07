{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (osConfig.moon.system) sway;
in
{
  config = mkIf sway.enable {
    moon.packages = { inherit (pkgs) wayland-logout; };

    catppuccin.wleave.enable = false;
    programs.wleave = {
      enable = true;
      settings = {
        buttons = [
          {
            label = "lock";
            action = "swaylock";
            text = "Lock";
            keybind = "l";
            icon = "${pkgs.wleave}/share/wleave/icons/lock.svg";
          }
          {
            label = "logout";
            action = "wayland-logout";
            text = "Logout";
            keybind = "e";
            icon = "${pkgs.wleave}/share/wleave/icons/logout.svg";
          }
          {
            label = "shutdown";
            action = "systemctl poweroff";
            text = "Shutdown";
            keybind = "s";
            icon = "${pkgs.wleave}/share/wleave/icons/shutdown.svg";
          }
        ];
      };
    };
  };
}