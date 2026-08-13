{
  home-manager.users.melon = {
    moon = {
      music.enable = true;
      programs = {
        chromium.enable = true;
        librewolf.enable = true;
        neovim.enable = true;
        zsh.enable = true;
      };

      profiles.media = {
        creation.enable = true;
      };
    };
  };
}