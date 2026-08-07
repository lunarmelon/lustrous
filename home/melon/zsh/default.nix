{
  config,
  lib,
  pkgs,
  ...
}: 
let
  cfg = config.moon.programs.zsh;
in {
  options.moon.programs.zsh.enable = lib.mkEnableOption "Enable zsh customization";

  config = lib.mkIf cfg.enable {
    programs = {
      zsh = {
        enable = true;
        autocd = true;
        enableCompletion = lib.mkForce false; # disable for zsh autocomplete plugin
        autosuggestion.enable = true;

        initContent = lib.mkOrder 1200 ''
          stty stop undef
          eval "$(direnv hook zsh)"
        '';

        dotDir = "${config.xdg.configHome}/zsh";

        autosuggestion.strategy = [
          "history"
          "completion"
          "match_prev_cmd"
        ];
        history = {
          append = true;
          findNoDups = true;
          ignoreDups = true;
          ignoreSpace = true;
          path = "${config.xdg.dataHome}/zsh/zsh_history";
          saveNoDups = true;
          share = true;
          size = 1000000;
        };

        historySubstringSearch = {
          enable = true;
          searchDownKey = ["^[[B" "$terminfo[kcud1]"];
          searchUpKey = ["^[[A" "$terminfo[kcuu1]"];
        };

        setOptions = [
          "nobeep"
          "inc_append_history"
        ];

        antidote = {
          enable = true;
          plugins = [
            #"Aloxaf/fzf-tab"
            "zdharma-continuum/fast-syntax-highlighting"
            "marlonrichert/zsh-autocomplete"
            #"zsh-users/zsh-history-substring-search" # not compatible with zsh-autocomplete
            #"hlissner/zsh-autopair"
          ];
        };
        sessionVariables = {
          WGETRC = "$XDG_CONFIG_HOME/wget/wgetrc";
          GNUPGHOME = "$XDG_DATA_HOME/gnupg";
          CARGO_HOME = "$XDG_DATA_HOME/cargo";
          GOPATH = "$XDG_DATA_HOME/go";
          GOBIN = "$GOPATH/bin";
          GOMODCACHE = "$XDG_CACHE_HOME/go/mod";
          _JAVA_AWT_WM_NONREPARENTING = 1;
          FFMPEG_DATADIR = "$XDG_CONFIG_HOME/ffmpeg";
          WINEPREFIX = "$XDG_DATA_HOME/wineprefixes/default";
          BUN_INSTALL = "$XDG_DATA_HOME/bun";
          NVM_DIR = "$XDG_CONFIG_HOME/nvm";
        };
      };
    };
  };
}
