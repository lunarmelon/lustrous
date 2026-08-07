{
  lib,
  config,
  _class,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib.types) attrsOf package;
in
{
  options.moon.packages = mkOption {
    type = attrsOf package;
    default = {};
    description = ''
      A set of packages that should be installed for this system
    '';
  };

  # check if packages should be installed on system level or user level
  config = 
    if (_class == "nixos") then
      {
        environment.systemPackages = builtins.attrValues config.moon.packages;
      }
    else
      {
        home.packages = builtins.attrValues config.moon.packages;
      };
}