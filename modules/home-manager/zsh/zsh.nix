{ pkgs, lib, config, ... }:

{
  options = {};
  config = {
    # All configuration is done in program.zsh
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = {
        enable = true;
      };
      syntaxHighlighting = {
        enable = true;
      };

      history = {
        size = 10000;
        save = 10000;
        ignoreDups = true;
      };

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./p10k-config;
          file = "p10k.zsh";
        }
      ];

      sessionVariables = {
        EDITOR = "nvim";
        SHELL = "zsh";
        XDG_CONFIG_DIR = "$HOME/.config";
      };

      shellAliases = {
        c = "clear";
        g = "git";
        n = "nvim";
        p = "${pkgs.python3}/bin/python3";
        cat = "${pkgs.bat}/bin/bat";
        grep = "${pkgs.ripgrep}/bin/rg";
        find = "${pkgs.fd}/bin/fd";
        ls = "${pkgs.eza}/bin/eza";

        sgit = "sudo git -c \"include.path=\${XDG_CONFIG_DIR:-$HOME/.config}/git/config\" -c \"include.path=$HOME/.gitconfig\"";
        nshell = "nix-shell --command zsh -p";

        # Alias required on stable channel
        code = if config.custom.unstable.enable then "code" else "env -u WAYLAND_DISPLAY code";
      };

      oh-my-zsh = {
        enable = true;
      };
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
