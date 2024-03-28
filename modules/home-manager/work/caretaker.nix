{ pkgs, lib, config, ... }:

let
    cfg = config.custom.work;
in
{
  
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      teams-for-linux
    ];
  };
}
