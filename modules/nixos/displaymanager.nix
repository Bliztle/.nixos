{ lib, config, pkgs, ... }:

let
  cfg = config.custom.displaymanager;
in
{
  options.custom.displaymanager = {
    enable = lib.mkEnableOption "enable display manager module";

    gdm.enable = lib.mkEnableOption "use gdm";
  };

  # config = lib.mkIf cfg.enable {
  config = {
    # services.xserver.enable = true;

    # services.xserver.displayManager = {
    #   # gdm = lib.mkIf cfg.gdm.enable {
    #   gdm = {
    #     enable = true;
    #     wayland = true;
    #   };
    # };
  };
}
