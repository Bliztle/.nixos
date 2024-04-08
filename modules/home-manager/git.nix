{ pkgs, lib, config, ... }:

let
  cfg-path = ".config/git";
in
{
  options = {};
  config = {
    # Normal git configuration
    programs.git = {
      enable = true;
      userName = "Asbjørn Rysgaard Eriksen";
      userEmail = "mail@bliztle.com";
      delta.enable = true;

      signing = {
        key = "654D56C64D41EAB7!";
        signByDefault = true;
        gpgPath = "${pkgs.gnupg}/bin/gpg";
      };

      aliases = {
        s = "status";
        sw = "switch";
        swc = "switch -c";
        c = "commit -m";
        ca = "!git add -A && git commit -m";
        cam = "commit --amend";
        caam = "!git add -A && commit -a --amend";
        co = "checkout";
        cob = "checkout -b";
        d = "diff";
        dh = "diff HEAD";
        do = "diff origin/HEAD";
        p = "push";
        pb = "push --set-upstream origin HEAD";
        pf = "push --force-with-lease";
        lg = "!git log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30";
      };

      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        pull = {
          rebase = "true";
        };
        core = {
          editor = "nvim";
        };
        pager = {
          branch = "false";
        };
        "remote \"origin\"" = {
          prune = "true";
        };
      };

      includes = [
        { 
          path = "~/${cfg-path}/caretaker.gitconfig";
          condition = "gitdir:~/work/caretaker/";
        }
      ];
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = false;
    };

    # Gitdir included configuration
    home.file."${cfg-path}/caretaker.gitconfig".text = ''
      [user]
        name = Asbjørn Rysgaard Eriksen
        email = are@caretaker.dk
    '';
  };
}
