{
  config,
  lib,
  ...
}: 
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.moon.system.bluetooth;
in {
  options.moon = {
    system.bluetooth = {
      enable = mkEnableOption "Enable bluetooth";
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;

      disabledPlugins = [
        "sap"
        "handsfree"
      ];

      settings = { 
        General = {
          JustWorksRepairing = "always";
          MultiProfile = "multiple";

          Enable = "Source,Sink,Media,Socket";

          FastConnectable = true;

          Experimental = true;
          KernelExperimental = true;
        };

        Policy = {
          AutoEnable = true;
        };
      };
    };

    boot.kernelModules = [ "btusb" ];

    services.blueman.enable = true;
  };
}
