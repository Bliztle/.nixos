{ lib, config, pkgs, ... }:

let
  cfg = config.custom.security;
in
{
  options.custom.security = {
    enable = lib.mkEnableOption "enable security module";

    yubico.challenge = lib.mkEnableOption "enable challenge response mode authentication";
    yubico.u2f = lib.mkEnableOption "enable u2f authentication";

    polkit = lib.mkOption {
      # Should add type = types.bool, but i don't know how to get access to types.
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
  
    /*
      Yubico configuration
  
      Implementet below are 2 options for yubikey authentication
      - HMAC Challenge response
      - FIDO U2F
  
      For general use, U2F allows more configuration for which services should utilize it, 
      but unlike HMAC challenge response, it can not used for LUKS partition decryption
  
      Setting up:
  
          HMAC challenge response
            # Get ID to add below
            nix-shell --command 'ykinfo -s' -p yubikey-personalization
  
            # Enter shell
            nixshell -c zsh -p yubico-pam -p yubikey-manager
            # If key is not set up with chal-resp on slot 2, run:
            ykman otp chalresp --touch --generate 2
            # Register key
            ykpamcfg -2 -v
  
          FIDO U2FA
            nix-shell -p pam_u2f
            mkdir -p ~/.config/Yubico
            # For each key:
            pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
            
              
    */
  
    ### HMAC challenge response
    services.pcscd.enable = cfg.yubico.challenge;
    security.pam.yubico = lib.mkIf cfg.yubico.challenge {
      enable = true;
      debug = true;
      control = "sufficient";
      mode = "challenge-response";
      id = [ "18298980" ];
    };
  
    ### FIDO U2FA
    security.pam.services = {
      # u2fa - Allow auth with yubikeys
      # see list of services with ls /etc/pam.d
      login.enableGnomeKeyring = true;
      login.u2fAuth = lib.mkIf cfg.yubico.u2f true;
      sudo.u2fAuth = lib.mkIf cfg.yubico.u2f true;
      polkit-1.u2fAuth = lib.mkIf cfg.yubico.u2f true;
    };
  
    ### Polkit. Allow applications to ask for raised permission level
    security.polkit.enable = cfg.polkit;
    systemd.user.services.polkit-gnome-authentication-agent-1 = lib.mkIf cfg.polkit {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };

    programs.seahorse.enable = true;
    services.gnome.gnome-keyring.enable = true;
  };
}
