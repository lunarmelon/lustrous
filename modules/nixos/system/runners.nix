{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.attrsets) genAttrs;
  inherit (lib.modules) mkIf;

  cfg = config.moon.system.security.binaries;
in
{
  options.moon.system.security = {
    binaries.enable = lib.mkEnableOption "Allow for non-patched binaries to run";
  };

  config = mkIf cfg.enable {
    moon.packages = { inherit (pkgs) appimage-run; };

    # run appimages with appimage-run
    boot.binfmt.registrations = 
      genAttrs
        [
          "appimage"
          "AppImage"
        ]
        (ext: {
          recognitionType = "extension";
          magicoOrExtension = ext;
          interpreter = "/run/current-system/sw/bin/appimage-run";
        });

    # run unpatched linux binaries with nix-ld
    programs.nix-ld = {
      enable = true;
      libraries = builtins.attrValues {
        inherit (pkgs)
          openssl
          curl
          glib
          util-linux
          glibc
          icu
          libunwind
          libuuid
          zlib
          libsecret
          # graphical
          freetype
          libgvlnd
          libnotify
          sdl3
          vulkan-loader
          gdk-pixbuf
          libx11
          ;

        inherit (pkgs.stdenv.cc) cc;
      };
    };
  };
}