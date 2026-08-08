{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  prof = config.moon.profiles;
in
{
  config = mkIf prof.workstation.enable {
    programs.vscodium.enable = true;
  };
}
