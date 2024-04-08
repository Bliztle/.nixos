{ pkgs, lib, config, ... }:

let
  colors = config.colorScheme.palette;
in
{
  options = {};
  config = {
    programs.kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;
        font = {
          name = "JetBrainsMono Nerd Font";
          size = 12;
        };
        settings = {
          # The string below written as nix confugration
          linux_display_server = "wayland";
          wayland_titlebar_color = "background";
          # font_family = "JetBrainsMono Nerd Font";
          bold_font = "auto";
          italic_font = "auto";
          bold_italic_font = "auto";
          # font_size = 13;
          initial_window_width = "95c";
          initial_window_height = "35c";
          window_padding_width = 20;
          confirm_os_window_close = 0;
          # Upstream colors {{{
          # background = "#${colors.base00}";
          # foreground = "#${colors.base05}";
          # color0 = "#${colors.base00}";
          # color8 = "#${colors.base01}";
          # color1 = "#${colors.base02}";
          # color9 = "#${colors.base03}";
          # color2 = "#${colors.base04}";
          # color10 ="#${colors.base05}";
          # color3 = "#${colors.base06}";
          # color11 ="#${colors.base07}";
          # color4 = "#${colors.base08}";
          # color12 ="#${colors.base09}";
          # color5 = "#${colors.base0A}";
          # color13 ="#${colors.base0B}";
          # color6 = "#${colors.base0C}";
          # color14 ="#${colors.base0D}";
          # color7 = "#${colors.base0E}";
          # color15 ="#${colors.base0F}";
          # cursor = "#${colors.base00}";
          # cursor_text_color = "#a5b6cf";
          # selection_foreground = "#a5b6cf";
          # selection_background = "#1c1e27";
          # url = "#5de4c7";
          # active_border_color = "#3d59a1";
          # inactive_border_color = "#101014";
          # bell_border_color = "#fffac2";
          # tab_bar_style = "fade";
          # tab_fade = 1; 
          # active_tab_foreground = "#3d59a1";
          # active_tab_background = "#16161e";
          # active_tab_font_style = "bold";
          # inactive_tab_foreground = "#787c99";
          # inactive_tab_background = "#16161e";
          # inactive_tab_font_style = "bold";
          # tab_bar_background = "#101014";
          # macos_titlebar_color = "#16161e";


          background = "#${colors.base00}";
          foreground = "#${colors.base05}";
          selection_background = "#${colors.base05}";
          selection_foreground = "#${colors.base00}";
          url_color = "#${colors.base0D}";
          cursor = "#${colors.base0D}";
          cursor_text_color = "#${colors.base00}";
          active_border_color = "#${colors.base03}";
          inactive_border_color = "#${colors.base01}";
          active_tab_background = "#${colors.base00}";
          active_tab_foreground = "#${colors.base05}";
          inactive_tab_background = "#${colors.base01}";
          inactive_tab_foreground = "#${colors.base04}";

          # Normal
          color0 = "#${colors.base00}";
          color1 = "#${colors.base08}";
          color2 = "#${colors.base0B}";
          color3 = "#${colors.base0A}";
          color4 = "#${colors.base0D}";
          color5 = "#${colors.base0E}";
          color6 = "#${colors.base0C}";
          color7 = "#${colors.base05}";

          # Bright (same as Normal except 8/15)
          color8 = "#${colors.base03}";
          color9 = "#${colors.base08}";
          color10 = "#${colors.base0B}";
          color11 = "#${colors.base0A}";
          color12 = "#${colors.base0D}";
          color13 = "#${colors.base0E}";
          color14 = "#${colors.base0C}";
          color15 = "#${colors.base07}";
        };
        extraConfig = ''
          background_opacity: 0.8;
        '';
    };
  };
}
