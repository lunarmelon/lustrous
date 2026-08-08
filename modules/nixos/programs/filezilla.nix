{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  prof = config.moon.profiles;
in
{
  config = mkIf prof.workstation.enable {
    moon.packages = { inherit (pkgs) filezilla; };
  };
}