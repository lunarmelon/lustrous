{
  lib,
  osClass,
  ...
}:
let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.options) mkOption;
  inherit (lib.types) enum nullOr str;

  mkDefault = name: args: mkOption ({ description = "default ${name} for the system"; } // args);
in
{
  options.moon.programs.defaults = mapAttrs mkDefault {
    shell = {
      type = enum [
        "bash"
        "zsh"
        "fish"
      ];
      default = "zsh";
    };

    terminal = {
      type = enum [
        "alacritty"
        "kitty"
      ];
      default = "kitty";
    };

    editor = {
      type = enum [
        "nvim"
        "codium"
      ];
      default = "nvim";
    };

    pager = {
      type = str;
      default = "less -FR";
    };

    manpager = {
      type = str;
      default = "nvim +Man";
    };

    screenLocker = {
      type = nullOr (enum [
        "swaylock"
        "gtklock"
      ]);
      default = "swaylock";
      descriptionb = ''
        The lockscreen module to be loader by home-manager
      '';
    };
  };
}