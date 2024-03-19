{ config, pkgs, inputs, lib, ... }:

let
  cfg = config.custom.games;
in
{
  options.custom.games = {
    steam = {
      enable = lib.mkEnableOption "Enable Steam";
    };
  };

  config = {
    programs.steam = lib.mkIf cfg.steam.enable {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };
  };
}
