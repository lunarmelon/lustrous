{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: 
let
  inherit (lib) mkIf;

  inherit (osConfig.moon.system) sway;
in 
{
  config = mkIf sway.enable {
    #catppuccin.kitty.enable = true;
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      font = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetbrainsMono Nerd Font";
        size = 14;
      };
      # Color theme
      #themeFile = "Catppuccin-Mocha";
      settings = {
        # Mouse
        mouse_hide_wait = 10.0;
        url_style = "double";

        # Cursor
        cursor_blink_interval = 0;
        cursor_shape = "beam";

        # Tab bar
        tab_bar_edge = "top";
        tab_bar_margin_width = 5;
        tab_bar_style = "separator";
        tab_separator = " '' ";
        tab_bar_min_tabs = 2;
        tab_title_template = "{fmt.fg._11111b}{fmt.bg.default} {fmt.fg._abb2bf}{fmt.bg._11111b} ({index}) {tab.active_oldest_exe} {fmt.fg._11111b}{fmt.bg.default} ";
        active_tab_title_template = "{fmt.fg._875fff}{fmt.bg.default} {fmt.fg._ffffff}{fmt.bg._875fff} ({index}) {tab.active_oldest_exe} {fmt.fg._875fff}{fmt.bg.default} ";
        active_tab_font_style = "bold";
      };
    };
  };
}
