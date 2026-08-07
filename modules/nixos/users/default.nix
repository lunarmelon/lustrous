{
  lib,
  config,
  ...
}:
let
  inherit (lib.types) listOf str;
  inherit (lib.attrsets) genAttrs;

  inherit (lib) mkIf mkMerge mkOption;

  inherit (config.moon) users;
in
{
  options.moon.users = mkOption {
    type = listOf str;
    default = [ ];
    example = [ "melon" ];
    description = ''
      A list of users to be added to the system
    '';
  };

  config = {
    users.users = genAttrs users (name: {
      initialPassword = "password";
      isNormalUser = true;

      shell = config.home-manager.users.${name}.programs.zsh.package;

      extraGroups = mkMerge [
        [
          "wheel"
          "nix"
          "network"
          "networkmanager"
          "inputs"
          "power"
          "git"
        ]
        (mkIf config.moon.profiles.graphical.enable [
          "pipewire"
          "video"
          "audio"
        ])
      ];
    });
  };
}