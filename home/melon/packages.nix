{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.attrsets) optionalAttrs mergeAttrsList;

  cfg = config.moon.profiles;
in
{
  moon.packages = mergeAttrsList [
    (optionalAttrs cfg.media.creation.enable {
      inherit (pkgs)
        # inkscape # vector graphics editor
        gimp # image editor
        ;
    })
    (optionalAttrs cfg.graphical.enable {
      inherit (pkgs)
        btop
        ;
    })
  ];
}

