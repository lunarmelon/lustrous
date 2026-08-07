{
  config,
  lib,
  ...
}: 
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.moon.programs.librewolf;
in 
{
  options.moon.programs.librewolf.enable = mkEnableOption "Enable Librewolf";

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      settings = {
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;

        "privacy.clearOnShutdown.history" = false;
        "identity.fxaccounts.enabled" = true;

        # disable notifications
        "dom.push.enabled" = false;
        "dom.push.connection.enabled" = false;
        "dom.battery.enabled" = false;
      };
      
      profiles."default" = {
        extensions.force = true;
      };
    };
  };
}
