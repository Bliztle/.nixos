{ lib, config, pkgs, ... }:

let
  cfg = config.custom.shell;
in
{
  # Currently no options are used
  options.custom.shell = {
    enable = lib.mkEnableOption "enable custom shell module";
  };

  config = {

    # Always enable Zsh as default
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;


    environment.shells = with pkgs; [
      zsh
    ];
  
    # Put Nu or Fish options here when you try it out
  };
}
