{ lib, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib) types;
in
{
  imports = [
    ./intel.nix
  ];

  options.moon.device.gpu = mkOption {
    type = types.nullOr (
      types.enum [
        "amd"
        "intel"
        "nvidia"
      ]
    );
    default = null;
    description = "The manufacturer of the system gpu";
  };
}