{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkDefault;
in
{
  xdg.portal = {
    enable = mkDefault config.moon.profiles.graphical.enable;

    xdgOpenUsePortal = true;

    config = {
      common = {
        default = [ "gtk" ];

        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };

    wlr = {
      enable = mkDefault config.moon.profiles.graphical.enable;
    };
  };
}