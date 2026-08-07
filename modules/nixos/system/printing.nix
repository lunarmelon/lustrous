{
  pkgs,
  lib,
  config,
  ...
}: 
let
  inherit (lib.attrsets) attrValues;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) attrsOf path;

  cfg = config.moon.system.printing;
in {
  options.moon.system.printing = {
    enable = mkEnableOption "Printing";

    extraDrivers = mkOption {
      type = attrsOf path;
      default = { };
      description = "A list of additional drivers to install for printing";
    };
  };

  config = mkIf cfg.enable {
    services = {
      printing = {
        enable = true;

        drivers = attrValues (
          {
            inherit (pkgs) hplip;
          }
          // cfg.extraDrivers
        );
      };

      avahi = {
        enable = true;
        nssmdns4 = true;
        nssmdns6 = true;
        openFirewall = true;
      };
    };
  };
}
