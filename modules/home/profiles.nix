{
  lib,
  config,
  osConfig,
  ...
}:
let
  inherit (lib.options) mkEnableOption;
in
{
  options.moon.profiles.media = {
    creation.enable = mkEnableOption "media creation profile";
  };

  config = {
    moon.profiles = {
      inherit (osConfig.moon.profiles)
        graphical
        workstation
        laptop
        server
        ;
    };
  };
}