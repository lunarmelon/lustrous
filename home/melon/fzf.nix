{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.meta) getExe;
in
{
  programs.fzf = {
    inherit (config.moon.profiles.workstation) enable;

    historyWidget.command = "";

    defaultCommand = "${getExe pkgs.fd} --type --hidden --exclude=.git";
    defaultOptions = [
      "--height=30%"
      "--layout=reverse"
      "--info=inline"
    ];
  };
}