{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.moon.programs.office;
  prof = config.moon.profiles;
in
{
  options.moon.programs.office.enable =
    mkEnableOption "Enable office suites"
    // {
      default = prof.workstation.enable;
    };

  config = mkIf cfg.enable {
    moon.packages = { inherit (pkgs) onlyoffice-desktopeditors libreoffice-fresh; };
  };
}