{ pkgs, lib, config, ... }:

{
  options = {};
  config = {
    # Set which programs should open files
    xdg.mimeApps.defaultApplications = {
        "application/pdf" = [ "librewolf" ];
    };
  };
}
