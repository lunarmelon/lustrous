{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  cfg = config.moon.style;
  ctp = config.catppuccin;

  schema = pkgs.gsettings-desktop-schemas;
in
{
  config = mkIf config.moon.profiles.graphical.enable {
    xdg = {
      systemDirs.data = [ "${schema}/share/gsettings-schemas/${schema.name}" ];

      configFile =
        let
          gtk4Dir = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gkt-4.0";
        in
        {
          "gtk-4.0/assets".source = "${gtk4Dir}/assets";
          "gtk-4.0/gtk.css".source = "${gtk4Dir}/gtk.css";
          "gtk-4.0/gtk-dark.css".source = "${gtk4Dir}/gtk-dark.css";
        };
    };

    home = {
      packages = [
        pkgs.glib
      ];

      sessionVariables.GTK_USE_PORTAL = "1";
    };

    gtk = {
      enable = true;

      theme = {
        name = "catppuccin-${ctp.flavor}-${ctp.accent}-standard";
        package =
          (pkgs.catppuccin-gtk.override {
            size = "standard";
            accents = [ ctp.accent ];
            variant = ctp.flavor;
          }).overrideAttrs
            (oa: {
              nativeBuildInputs = oa.nativeBuildInputs or [ ] ++ [
                config.catppuccin.sources.whiskers
                pkgs.which
              ];

              preinstall = ''
                cd sources/patches/colloid
                whiskers pallete.tera
                cd -
              '';
            });
      };

      font = {
        inherit (cfg.fonts) name size;
      };

      gtk3.extraConfig = {
        # make things look nice
        gtk-application-prefer-dark-theme = true;

        gtk-decoration-layout = "appmenu:none";

        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";

        # stop annoying sounds
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-error-bell = 0;

        # config that is not the same as gtk4
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";

        gtk-button-images = 1;
        gtk-menu-images = 1;
      };

      gtk4 = {
        inherit (config.gtk) theme;

        extraConfig = {
          # make things look nice
          gtk-application-prefer-dark-theme = true;

          gtk-decoration-layout = "appmenu:none";

          gtk-xft-antialias = 1;
          gtk-xft-hinting = 1;
          gtk-xft-hintstyle = "hintslight";

          # stop annoying sounds again
          gtk-enable-event-sounds = 0;
          gtk-enable-input-feedback-sounds = 0;
          gtk-error-bell = 0;
        };
      };
    };
  };
}