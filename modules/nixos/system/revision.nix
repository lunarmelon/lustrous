{
  lib,
  self,
  config,
  ...
}:
let
  inherit (lib.options) mkOption;

  cfg = config.moon.system;
in
{
  options.moon.system.stateVersion = mkOption {
    internal = true;
    type = lib.types.str;
    default = "26.05";
  };

  config.system = {
    stateVersion = cfg.stateVersion;
  };
}