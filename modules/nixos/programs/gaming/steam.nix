{
  config,
  lib,
  pkgs,
  ...
}: 
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.moon.programs.gaming.steam;
in 
{
  options.moon.programs.gaming.steam.enable = mkEnableOption "Enable steam";

  config = mkIf cfg.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            libpng
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
            gamemode
          ];
      };
    };

    hardware = {
      graphics.enable32Bit = true;
      xone.enable = true;
    };

    boot = {
      # FIXME https://github.com/NixOS/nixpkgs/issues/378447
      extraModulePackages = with config.boot.kernelPackages; [ xone ];
      extraModprobeConfig = ''
        options bluetooth disable_ertm=Y
      '';
    };

    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        extest.enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        extraPackages = with pkgs; [
          libpng
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
      };
    };

    moon.packages = {
      inherit (pkgs) 
      steam
      gamemode
      inotify-tools
      protonup-qt
      ; 
    };


    users.groups = {
      steam = {};
    };

    systemd.services.steamshare = {
      enable = true;
      unitConfig = {
        Type = "exec";
      };

      serviceConfig = {
        ExecStart = [''/run/current-system/sw/bin/chmod -R 777 /opt/Steam;'' ''/run/current-system/sw/bin/inotifywait -mr -e close_write,create,moved_to,modify /opt/Steam | while /run/current-system/sw/bin/read path file; do /run/current-system/sw/bin/chmod 777 $path/$file; done;''];
      };

      wantedBy = ["graphical.target"];
    };

    services.cron = {
      enable = true;
      systemCronJobs = [
        "*/1 * * * * steamgrab"
      ];
    };

    networking.firewall = {
      allowedTCPPorts = [24872];
      allowedUDPPorts = [24872];
    };
  };
}
