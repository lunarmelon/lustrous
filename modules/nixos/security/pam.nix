{ lib, config, ... }:
let
  inherit (lib.attrsets) genAttrs;
  inherit (lib.modules) mkIf mkMerge;

  services = [
    "login"
    "greetd"
    "tuigreet"
  ];

  mkService = {
    enableGnomeKeyring = true;
    gnupg = {
      enable = true;
      noAutostart = true;
      storeOnly = true;
    };
  };
in
{
  security.pam = mkMerge [
    {
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];
    }

    (mkIf config.moon.profiles.graphical.enable {
      services = genAttrs services (_: mkService);
    })
  ];
}