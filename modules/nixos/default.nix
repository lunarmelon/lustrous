{
  _class = "nixos";

  imports = [
    ../generic
    ./boot
    ./catppuccin.nix
    ./environment
    ./hardware
    ./kernel
    ./networking
    ./nix
    ./nixpkgs.nix
    ./programs
    ./secrets.nix
    ./security
    ./shell
    ./system
    ./users
  ];
}