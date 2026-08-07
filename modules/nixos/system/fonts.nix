{
  lib,
  pkgs,
  ...
}:
{
  fonts.packages = lib.attrValues {
    inherit (pkgs)
      corefonts

      fira

      inter

      noto-fonts

      noto-fonts-cjk-sans
      
      vista-fonts
    ;
  };
}