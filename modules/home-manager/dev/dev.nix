{ lib, config, pkgs, ... }:

let
  cfg = config.custom.dev;
in
{
  options.custom.dev = {
    enable = lib.mkEnableOption "enable development module";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
