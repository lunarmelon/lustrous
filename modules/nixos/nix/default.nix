{pkgs, ...}: {
  imports = [
    ./environment.nix
    ./nix.nix
    ./substituters.nix
  ];

  environment = {
    sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
    pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
  };

  programs.nix-ld = {
    enable = true;
    #Include libstdc++ in the nix-ld profile
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      fuse3
      icu
      nss
      openssl
      curl
      expat
      libx11
      vulkan-headers
      vulkan-loader
      vulkan-tools
    ];
  };
}
