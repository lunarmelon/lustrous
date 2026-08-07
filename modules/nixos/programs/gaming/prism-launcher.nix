{
  config,
  lib,
  pkgs,
  ...
}: 
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.moon.programs.gaming.prism;
in 
{
  options.moon.programs.gaming.prism.enable = mkEnableOption "Enable prism-launcher for Minecraft";

  config = mkIf cfg.enable {
    moon.packages = { inherit (pkgs) prism-launcher; };
  };
}
