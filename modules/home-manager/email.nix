{ pkgs, lib, config, ... }:

{
  options = {};
  config = {
    programs.thunderbird = {
      enable = true;
      profiles = {

      };
    };
  };
}
