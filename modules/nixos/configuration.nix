# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

let
  cfg = config.custom;
in
{
  options.custom = {
    unstable.enable = lib.mkEnableOption "enable configuration from unstable";
    nvidia.enable = lib.mkEnableOption "enable nvidia specific options";
  };

  imports =
    [ # Include the results of the hardware scan
      ./audio.nix
      ./displaymanager.nix
      ./games.nix
      ./locale.nix
      ./main-user.nix
      ./security.nix
      ./shell.nix
      inputs.home-manager.nixosModules.default
    ];

  config = {
  
    # SSH
    programs.ssh = {
      startAgent = true;
    };
  
    # Hyprland
    programs.hyprland = {
      enable = true;
      # Only set package if unstable is enabled
      package = lib.mkIf cfg.unstable.enable inputs.hyprland.packages."${pkgs.system}".hyprland;
      xwayland.enable = true;
    };
  
    environment.sessionVariables = {
      # Prevent cursor becoming invisible
      WLR_NO_HARDWARE_CURSORS = lib.mkIf cfg.nvidia.enable "1"; # This doesn't work properly
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  
    hardware = {
      # Opengl
      opengl.enable = true;
      # Most wayland compositors need this
      # nvidia.modesetting.enable = cfg.nvidia.enable;
      nvidia.modesetting.enable = cfg.nvidia.enable;
    };
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  
    # Enable networking
    networking.networkmanager.enable = true;
  
    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
  
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      sl # TUU TUUUUUUUU
      wl-clipboard
      # kitty # Maybe try alacritty in the future
      # firefox
      librewolf
      vscode
      git
      github-cli
      # pam_u2f
      # home-manager
      spotify
      polkit_gnome
      # gnome_keyring # Set this up at some point
      # obsidian-wayland
      # obsidian
      discord
      cmatrix

      curl
      (curl.overrideAttrs (oldAttrs: {
        configureFlags = oldAttrs.configureFlags ++ ["--enable-versioned-symbols"];
      }))
  
      # hyprland
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xwayland
      # waybar and override for it
      meson
      waybar
      (pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        })
      )
      rofi-wayland
      grim
      # wayland-protocols
      # wayland-utils
      # wlroots
  
      # Notifications
      # dunst
      # mako
      # libnotify # Above depends on this
  
      swww # Wallpaper daemon
  
      # Caretaker
      teams-for-linux
    ];
  
    fonts.packages = with pkgs; [
      nerdfonts
    ];
  
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  
    # List services that you want to enable:
  
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
  
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };
}
