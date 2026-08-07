{
  config,
  inputs,
  osClass,
  osConfig,
  ...
}:
let
  isGui = config.moon.profiles.graphical.enable;
in
{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  config = {
    catppuccin = {
      enable = true;
      autoEnable = true;

      flavor = "mocha";
      accent = "mauve";

      sources = osConfig.catppuccin.sources;

      gtk.icon.enable = isGui;
    };
  };
}