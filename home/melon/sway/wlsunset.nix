{ 
  osConfig,
  config,
  lib,
  pkgs,
  ... 
}:
let
  inherit (osConfig.moon.system) sway;
in
{
  config = lib.mkIf sway.enable {
    services.wlsunset = {
      enable = true;
      sunrise = "07:00";
      sunset = "19:00";
      temperature = {
        day = 6500;
        night = 4100;
      };
    };
  };
}