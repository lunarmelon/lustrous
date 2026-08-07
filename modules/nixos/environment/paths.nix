{ lib, config, ... }:
let
  inherit (lib.lists) optional;

  cfg = config.programs;
in
{
  environment.pathsToLink = [
    "/share/bash-completion"
  ]
  ++ optional cfg.zsh.enable "/share/zsh"
  ++ optional cfg.fish.enable "/share/fish";
}