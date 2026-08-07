{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  config = mkIf config.moon.profiles.laptop.enable {
    # handle ACPI events
    services.acpid.enable = true;

    moon.packages = { inherit (pkgs) acpi powertop; };

    boot = {
      kernelModules = [ "acpi_call" ];
      extraModulePackages = with config.boot.kernelPackages; [
        acpi_call
        cpupower
      ];
    };
  };
}