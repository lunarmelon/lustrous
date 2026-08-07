{ lib, self, pkgs, config, ... }:
let
  inherit (lib.modules) mkIf;
in
{
  config = {
    services.pulseaudio.enable = lib.mkForce false;

    services.pipewire = {
      enable = true;

      audio.enable = true;
      pulse.enable = true;
      jack.enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}