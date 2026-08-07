{ lib, config, ... }:
{
  programs.lazygit = {
    enable = config.moon.profiles.workstation.enable && config.programs.git.enable;

    settings = {
      update.method = "never";

      gui = {
        nerdFontsVersion = 3;
        authorColors.melon = "#f5c2e7";
      };

      git = {
        overrideGpg = true;

        # https://github.com/jesseduffield/lazygit/blob/68f3bcf53b0e19da3f7b1aaee19718605e339e8c/docs/Custom_Pagers.md#delta
        pagers = lib.lists.singleton {
          pager = lib.strings.escapeShellArgs [
            "delta"
            "--paging=never"
            "--line-numbers"
            "--hyperlinks"
            "--hyperlinks-file-link-format=lazygit-edit://{path}:{line}"
          ];
        };
      };
    };
  };
}