
{ pkgs, lib, config, ... }:

{
  options = {};
  config = {
    home.sessionPath = [ "$HOME/.config/scripts" ];
    xdg.configFile."scripts" = {
      recursive = true;
      source = ./src;
    };
  };
}
