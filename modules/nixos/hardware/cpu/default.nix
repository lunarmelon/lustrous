{lib, ...}:
let
  inherit (lib.options) mkOption;
  inherit (lib) types;
in
{
  imports = [
    ./amd.nix
    ./intel.nix
  ];

  options.moon.device.cpu = mkOption {
    type = types.nullOr (
      types.enum [
        "intel"
        "vm-intel"
        "amd"
        "vm-amd"
      ]
    );
    default = null;
    description = "The manufacturer of the system cpu";
  };
}