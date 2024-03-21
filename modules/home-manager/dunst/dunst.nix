{ pkgs, lib, config, ... }:

{
  options = {};
  config = {
    services.dunst = {
        enable = true;
        configFile = "./dunstrc";
    };
  };
}
