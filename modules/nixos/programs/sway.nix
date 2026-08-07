{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.moon.system.sway;
  prof = config.moon.profiles;
in
{
  options.moon.system.sway.enable =
    mkEnableOption "Enable sway compositor"
    // {
      default = prof.graphical.enable;
    };

  config = mkIf cfg.enable {
    services.gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    programs.sway = {
      enable = true;
      package = pkgs.swayfx;
      wrapperFeatures.gtk = true;
    };
  };
}