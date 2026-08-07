{
  config,
  lib,
  pkgs,
  ...
}: 
let
  inherit (lib.types) raw;
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkOverride;

  cfg = config.system.kernel;
in
{
  options.system.kernel = {
    packages = mkOption {
      type = raw;
      default = pkgs.linuxPackages_latest;
      description = "The kernel to use for the system";
    };
  };

  config = {
    boot.kernelPackages = mkOverride 500 cfg.packages;
  };
}
