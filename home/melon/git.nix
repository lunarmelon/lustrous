{
  lib,
  pkgs,
  self,
  config,
  ...
}: 
let
  inherit (lib.modules) mkIf;
  inherit (lib.hm.dag) entryBefore;
in 
{
  programs = {
    git = {
      inherit (config.moon.profiles.workstation) enable;
      package = pkgs.gitMinimal;

      lfs = {
        enable = false;
        skipSmudge = true;
      };

      signing = {
        format = "openpgp";
        key = "DEE01CFFE2B917FA";
        signByDefault = true;
      };

      ignores = [
        # system residue
        ".cache/"
        ".DS_Store"
        ".Trashes"
        ".Trash-*"
        "*.bak"
        "*.swp"
        "*.swo"
        "*.elc"
        ".~lock*"

        # build residue
        "tmp/"
        "target/"
        "result"
        "result-*"
        "*.exe"
        "*.exe~"
        "*.dll"
        "*.so"
        "*.dylib"

        # dependencies
        ".direnv/"
        "node_modules"
        "vendor"
      ];

      settings = {
        user = {
          name = "lunarmelon";
          email = "lunar" + "melon" + "@" + "tuta" + "." + "io";
        };

        alias = {
          st = "status";
          br = "branch";
          c = "commit -m";
          ca = "commit -am";
          co = "checkout";
          d = "diff";
        };

        init.defaultBranch = "main";
        repack.usedeltabaseoffset = "true";
        color.ui = "auto";
        help.autocorrect = 10;

        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicprefix = true;
        };

        branch = {
          autosetupmerge = "true";

          # sort branches so the newest ones by latest commit are at the top
          sort = "committerdate";
        };

        commit.verbose = true;

        # if a remote does not have a branch that i have, create it
        push.autoSetupRemote = true;

        merge = {
          stat = "true";
          conflictstyle = "zdiff3";
          tool = "meld";
        };

        rebase = {
          # https://andrewlock.net/working-with-stacked-branches-in-git-is-easier-with-update-refs/
          updateRefs = true;

          autoSquash = true;
          autoStash = true;
        };

        # prevent data corruption
        transfer.fsckObjects = true;
        fetch.fsckObjects = true;
        receive.fsckObjects = true;
      };
    };

    delta = {
      inherit (config.moon.profiles.workstation) enable;
      enableGitIntegration = true;

      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
      };
    };
  };

  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  home.activation = mkIf (pkgs.stdenv.hostPlatform.isDarwin && config.programs.git.enable) {
    removeExistingGitconfig = entryBefore [ "checkLinkTargets" ] ''
      rm -f ~/.gitconfig
    '';
  };
}
