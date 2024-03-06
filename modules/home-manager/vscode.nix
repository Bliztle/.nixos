{ pkgs, lib, config, ... }:

{
  options = {};
  config = {
    programs.vscode = {
      enable = true;
      userSettings = {
        "window.titleBarStyle" = "custom";
      };
    };
  };
}
