{
  config,
  lib,
  pkgs,
  ...
}: 
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.moon.system.plasma;
in 
{
  options.moon.system.plasma.enable = mkEnableOption "Enable KDE Plasma";

  config = mkIf cfg.enable {
    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        settings.General.DisplayServer = "wayland";
      };
      desktopManager.plasma6.enable = true;
    };
    environment.systemPackages = with pkgs; [
      kdePackages.kate
      kdePackages.dolphin
      kdePackages.skanpage
      kdePackages.okular
      kdePackages.gwenview
    ];
  };
}
