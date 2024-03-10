{ pkgs, lib, config, inputs, ... }:

let
    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
      ${pkgs.waybar}/bin/waybar &
      ${pkgs.swww}/bin/swww init &
      ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
      ${pkgs.mako}/bin/mako &
    '';

    grim = "${pkgs.grim}/bin/grim";
    slurp = "${pkgs.slurp}/bin/slurp";
    swappy = "${pkgs.swappy}/bin/swappy";
    playerctl = "${pkgs.playerctl}/bin/playerctl";
in
{
  options = {
    # Create options here to modify config from home.nix or the like
    # enable = lib.mkEnableOption "Enable hyprland config";

    hyprlandLayout = lib.mkOption {
      default = "master";
      description = ''
        hyprland window config
      '';
    };
  };

  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      # enableNvidiaPatches = true;
      xwayland.enable = true;
      package = lib.mkIf config.custom.unstable.enable inputs.hyprland.packages."${pkgs.system}".hyprland;

      settings = {
        exec-once = [
          "${startupScript}/bin/start"
	      ];
  
        # See https://wiki.hyprland.org/Configuring/Monitors/
        # monitor=",preferred,auto,auto";
        monitor = [
          "HDMI-A-1,1920x1080@60,2680x1440,1" # Asus
          "DP-1,1920x1080@60,0x360,1" # Omen
          "DP-2,3440x1440@60,1920x0,1" # Wide AOC
          "DP-3,1920x1080@60,5360x0,1,transform,1" # Regular AOC
        ];
        
        # Source a file (multi-file configs)
        # source = ~/.config/hypr/myColors.conf
        
        # Set programs that you use
        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$menu" = "rofi -show drun -show-icons";
        "$screenshot" = "${grim} -g \"$(${slurp})\" - | ${swappy} -f -";
        
        # Some default env vars.
        env = [
          "XCURSOR_SIZE,23"
          "QT_QPA_PLATFORMTHEME,qt4ct" # change to qt6ct if you have that
        ];
        # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
        input = {
            kb_layout = "dk";
            # kb_variant =
            # kb_model =
            # kb_options =
            # kb_rules =
        
            follow_mouse = "1";
        
            touchpad = {
                natural_scroll = false;
            };
        
            sensitivity = "0"; # -1.0 - 1.0, 0 means no modification.
        };
        
        general = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
        
            gaps_in = "4";
            gaps_out = "19";
            border_size = "1";
            "col.active_border" = "rgba(32ccffee) rgba(00ff99ee) 45deg";
            "col.inactive_border" = "rgba(595958aa)";
        
            layout = "dwindle";
        
            # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
            allow_tearing = false;
        };
        
        decoration = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
        
            rounding = "9";
        
            blur = {
                enabled = true;
                size = "2";
                passes = "0";
                
                vibrancy = "-1.1696";
            };
        
            drop_shadow = true;
            shadow_range = "3";
            shadow_render_power = "2";
            "col.shadow" = "rgba(0a1a1aee)";
        };
        
        animations = {
            enabled = true;
        
            # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        
            bezier = "myBezier, -1.05, 0.9, 0.1, 1.05";
            
            animation = [
              "windows, 0, 7, myBezie"
              "windowsOut, 0, 7, default, popin 80%"
              "border, 0, 10, default"
              "borderangle, 0, 8, default"
              "fade, 0, 7, default"
              "workspaces, 0, 6, default"
            ];
        };
        
        dwindle = {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true; # you probably want this
        };
        
        master = {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_is_master = true;
        };
        
        gestures = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = false;
        };
        
        misc = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            force_default_wallpaper = "-2"; # Set to 0 or 1 to disable the anime mascot wallpapers
        };
        
        # Example per-device config
        # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
        # device = {
        #     name = "epic-mouse-v0";
        #     sensitivity = "-1.5";
        # };
        
        # Example windowrule v0
        # windowrule = float, ^(kitty)$
        # Example windowrule v1
        # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
        # windowrulev2 = "nomaximizerequest, class:.*"; # You'll probably like this.
        
        /*
          Binds are configured with the following flags appended to the bind command

          l -> locked, aka. works also when an input inhibitor (e.g. a lockscreen) is active.
          r -> release, will trigger on release of a key.
          e -> repeat, will repeat when held.
          n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
          m -> mouse, see below
          t -> transparent, cannot be shadowed by other binds.
          i -> ignore mods, will ignore modifiers.

          see https://wiki.hyprland.org/Configuring/Binds/#bind-flags
        */

        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        "$mainMod" = "SUPER";
        "$secondMod" = "ALT";
        
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = [
          "$mainMod, RETURN, exec, $terminal"
          "$mainMod SHIFT, Q, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$secondMod, SPACE, exec, $menu"
          # "$mainMod, P, pseudo, # dwindle"
          "$mainMod, P, exec, $screenshot"
          "$mainMod, J, togglesplit, # dwindle"
        
        # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
        
        # Switch workspaces with mainMod + [-1-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
        
        # Move active window to a workspace with mainMod + SHIFT + [-1-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
        
        # Example special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
        
        # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+0"
          "$mainMod, mouse_up, workspace, e-2"

        # Media controls
          ", XF86AudioPlay, exec, ${playerctl} play-pause"
          ", XF86AudioNext, exec, ${playerctl} next"
          ", XF86AudioPrev, exec, ${playerctl} previous"
        ];
        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:271, movewindow"
          "$mainMod, mouse:272, resizewindow"
        ];

        
        bindel = [
          # Audio keys
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ];

        bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
      };
    };
  };

}
