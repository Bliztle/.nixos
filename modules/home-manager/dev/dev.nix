{ lib, inputs, config, pkgs, ... }:

let
  cfg = config.custom.dev;
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
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

    home.packages = with unstable; [
      # Nix
      nil
      # Lua
      lua-language-server
      # C
      gcc
      # C#
      dotnet-sdk_8
      omnisharp-roslyn
      # Javascript / Typescript
      nodePackages_latest.pnpm
      nodePackages_latest.typescript-language-server
      # Rust
      rustc
      cargo
      rustfmt
      clippy
      evcxr # REPL and Jupyter kernel
      rust-analyzer
      # Haskell
      #haskell.compiler.ghcHEAD
      #haskell.compiler.native-bignum.ghc965
      #haskellPackages.ghc
      haskell.compiler.ghc963
      haskellPackages.haskell-language-server
      haskellPackages.stack
    ];
  };
}
