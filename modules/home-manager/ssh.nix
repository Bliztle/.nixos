{ pkgs, lib, config, ... }:

{
  options = {};
  config = {
    programs.ssh = {
      enable = true;
      # addKeysToAgent = "yes";
      extraConfig = ''
        AddKeysToAgent yes
      '';
    };
  };
}
