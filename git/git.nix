{ pkgs, lib, config, ... }:

let
  cfg-path = "~/.config/git";
in
{
  options = {};
  config = {
    # Normal git configuration
    programs.git = {
      enable = true;
      userName = "Bliztle";
      userEmail = "asbjoern.r.e@gmail.com";

      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        pull = {
          rebase = "false";
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
        # "includeIf \"gitdir:~/work/caretaker/\"" = {
        #   path = "~/.config/git/caretaker.gitconfig";
        # };
      };

      # includes = [
      #   # { path = "${cfg-path}/includeif"; }
      #   { path = "~/.config/git/includeif"; }
      # ];
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = false;
    };

    # home.file."${cfg-path}/includeif".text = ''
    home.file."~/.config/git/includeif".text = ''
    [includeIf "gitdir:~/work/caretaker/"]
	    path = ~/.config/git/caretaker.gitconfig
    '';

    # Gitdir included configuration
    # home.file."${cfg-path}/caretaker.gitconfig".text = ''
    home.file."~/.config/git/caretaker.gitconfig".text = ''
      [user]
        name = Asbjørn Rysgaard Eriksen
        email = are@caretaker.dk

      [core]
        # ssh-keygen -t rsa-sha2-512 -f ~/.ssh/id_rsa_sha2_512"
        sshCommand = ssh -i ~/.ssh/id_rsa_sha2_512
    '';
  };
}
