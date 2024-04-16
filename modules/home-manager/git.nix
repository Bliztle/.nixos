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
        a = "add";
        aa = "add -A";
        s = "status";
        sw = "switch";
        swc = "switch -c";
        c = "commit -m";
        ca = "!git add -A && git commit -m";
        cam = "commit --amend";
        camn = "commit --amend --no-edit";
        caam = "!git add -A && git commit -a --amend";
        caamn = "!git add -A && git commit -a --amend --no-edit";
        co = "checkout";
        cob = "checkout -b";
        d = "diff";
        dh = "diff HEAD";
        do = "diff origin/HEAD";
        p = "push";
        pb = "push --set-upstream origin HEAD";
        pf = "push --force-with-lease";
        r = "reset";
        ro = "reset origin/HEAD";
        rs = "reset --soft";
        rso = "reset --soft origin/HEAD";
        rh = "reset --hard";
        rho = "reset --hard origin/HEAD";
        lg = "!git log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30";

        sub = "submodule";
        sub-pull = "submodule foreach git pull";
        sub-add = "submodule add -b main"; # Call with <repo> [<path>]
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
