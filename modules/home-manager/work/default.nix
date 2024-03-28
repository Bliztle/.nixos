{ lib, ... }:
{
    options.custom.work = {
        enable = lib.mkEnableOption "Enable work";
    };
    imports = [
        ./caretaker.nix
    ];
}