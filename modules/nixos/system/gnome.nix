{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf mkForce;
in
{
  config = mkIf config.moon.profiles.graphical.enable {
    services = {
      udev.packages = [ pkgs.gnome-settings-daemon ];

      gnome = {
        glib-networking.enable = true;

        gnome-keyring.enable = true;

        # since https://github.com/NixOS/nixpkgs/pull/379731
        # was merged, gcr-ssh-agent is enabled by gnome-keyring.enable
        gcr-ssh-agent.enable = false;

        gnome-remote-desktop.enable = mkForce false;
      };
    };
  };
}