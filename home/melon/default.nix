{
  imports = [
    ./browser
    ./catppuccin.nix
    ./cursors.nix
    ./direnv.nix
    ./eza.nix
    ./fd.nix
    ./fuzzel.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gtk.nix
    ./keepassxc.nix
    ./mpv.nix
    ./neovim
    ./nemo.nix
    ./oh-my-posh
    ./sway
    ./terminal
    ./qt.nix
    ./ripgrep.nix
    ./vscode.nix
    ./zsh
    ./zoxide.nix
  ];

  moon = {
    programs = {
      librewolf.enable = true;
      neovim.enable = true;
      vscode.enable = true;
      zsh.enable = true;
    };
  };
}