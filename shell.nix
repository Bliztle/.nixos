{ pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    lua-language-server
    nil # Nix language server
  ];
}

