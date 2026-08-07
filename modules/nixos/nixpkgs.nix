{ pkgs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;

    allowVariants = true;

    allowBrocken = false;

    permittedInsecurePackages = [];

    allowUnsupportedSystem = false;

    allowAliases = false;
  };
}