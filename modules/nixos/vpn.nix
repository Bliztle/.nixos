
{ lib, config, pkgs, ... }:

let
  cfg = config.custom.vpn;
in
{
  # Currently no options are used
  options.custom.vpn = {
    enable = lib.mkEnableOption "express vpn";
  };

  config = lib.mkIf cfg.enable {
    services.expressvpn.enable = true;
  };
}
