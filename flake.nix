{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    # home-manager-unstable.url = "github:nix-community/home-manager";

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    {

      nixosConfigurations = {

        # Get system from unstable on desktop
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/desktop/configuration.nix
            ./modules/stable.nix
            home-manager.nixosModules.default
          ];
        };

        # Zenbook uses 23.11
        zenbook = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/zenbook/configuration.nix
            ./modules/stable.nix
            home-manager.nixosModules.default
          ];
        };
      };
    };
}
