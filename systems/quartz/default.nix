{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./user.nix
  ];

  config = {
    moon = {
      profiles = {
        laptop.enable = true;
        graphical.enable = true;
        workstation.enable = true;
      };

      device = {
        cpu = "intel";
        gpu = "intel";
      };

      users = [
        "melon"
      ];

      system = {
        boot.silent = true;
        bluetooth.enable = true;
        printing.enable = true;

        #plasma.enable = true;
        sway.enable = true;
      };
    };
  };
}
