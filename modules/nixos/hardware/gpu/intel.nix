{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.attrsets) attrValues;
  inherit (lib.modules) mkIf;
  inherit (config.moon) device;
in
{
  config = mkIf (device.gpu == "intel" || device.gpu == "hybrid-nv") {
    # we enable modesetting since this is recommended for intel gpus
    services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics = {
      extraPackages = attrValues {
        inherit (pkgs) intel-media-driver intel-compute-runtime vpl-gpu-rt;
      };

      extraPackages32 = attrValues {
        inherit (pkgs.pkgsi686Linux) intel-media-driver;
      };
    };
  };
}