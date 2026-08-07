{
  osConfig,
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  inherit (lib) mkIf;

  inherit (osConfig.moon.system) sway;
in
{
  config = mkIf sway.enable {
    moon.packages = { inherit (pkgs) nemo-with-extensions; };
  };
}