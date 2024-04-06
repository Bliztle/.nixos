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
        # commit = {
        #   gpgsign = "true";
        # };
        pager = {
          branch = "false";
        };
        "remote \"origin\"" = {
          prune = "true";
        };
      };

      includes = [
        { path = "~/${cfg-path}/includeif"; }
      ];
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = false;
    };

    home.file."${cfg-path}/includeif".text = ''
    [includeIf "gitdir:~/work/caretaker/"]
	    path = ~/.config/git/caretaker.gitconfig
    '';

    # Gitdir included configuration
    home.file."${cfg-path}/caretaker.gitconfig".text = ''
      [user]
        name = Asbjørn Rysgaard Eriksen
        email = are@caretaker.dk

      [core]
        sshCommand = ssh -i ~/.ssh/id_rsa_sha2_512
    '';
  };
}
