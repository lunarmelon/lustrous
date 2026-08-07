{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.systemSettings.prism-launcher;
in {
  options = {
    systemSettings.prism-launcher = {
      enable = lib.mkEnableOption "Enable Prism launcher for Minecraft";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [prismlauncher];
  };
}
