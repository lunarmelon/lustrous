{
  programs.zsh.shellAliases = {
    # Package managers
    apt = "sudo apt";
    nala = "sudo nala";
    dnf = "sudo dnf";
    pac = "sudo pacman";

    # Python
    py = "python3";
    # Vim and Neovim
    v = "vim";
    nv = "nvim";

    # Git
    lg = "lazygit";

    # Newsboat
    nws = "newsboat";

    # Eza
    ls = "eza --group-directories-first --icons";
    ll = "ls -lh --git";
    #ll = "ls -lh";
    la = "ll -a";
    tree = "ll --tree --level=2";
    # Display images in terminal with Kitty;
    icat = "kitten icat";
    # Misc;
    ff = "fastfetch";
    ht = "htop";
    bt = "btop";
    rel = "exec zsh";
  };
}
