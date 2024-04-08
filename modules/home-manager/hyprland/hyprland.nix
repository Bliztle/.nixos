{ pkgs, lib, config, inputs, ... }:

let
    cfg = "~/.nixos/modules/home-manager/hyprland";
    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
      # ${pkgs.waybar}/bin/waybar &
      # waybar -s ~/.nixos/modules/home-manager/style.css &
      waybar &
      `swww init && swww img ${cfg}/wallpapers/trees.jpg` &
      # ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
      # ${pkgs.mako}/bin/mako &
      # ${pkgs.dunst}/bin/dunst &
      dunst &
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

        source = "${cfg}/macchiato.conf";
  
        # See https://wiki.hyprland.org/Configuring/Monitors/
        # monitor=",preferred,auto,auto";
        monitor = [
          "HDMI-A-1,1920x1080@60,2680x1440,1" # Asus
          "DP-3,1920x1080@60,0x360,1" # Omen
          "DP-2,3440x1440@60,1920x0,1" # Wide AOC
          "DP-1,1920x1080@60,5360x0,1,transform,1" # Regular AOC
          "eDP-1,1920x1080@60,0x0,1" # Laptop
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
                disable_while_typing="1";
                natural_scroll="1";
                clickfinger_behavior="1";
                middle_button_emulation="0";
                tap-to-click="1";
            };
        
            sensitivity = "0"; # -1.0 - 1.0, 0 means no modification.
        };
        
        general = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
        
            layout="dwindle";
            sensitivity="1.0"; # for mouse cursor

            gaps_in="5";
            gaps_out="20";
            border_size="2";
            # "col.active_border"="$teal";
            # "col.inactive_border"="$surface1";

            apply_sens_to_raw="0"; # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
        };
        
        decoration = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
        
            rounding = "18";
        
            blur = {
                enabled = true;
                size = "6";
                passes = "2";
                new_optimizations = true;
                # vibrancy = "-1.1696";
            };
        
            drop_shadow = true;
            shadow_range="15";
            # "col.shadow" = "$teal";
            # "col.shadow_inactive" = "$base";
        };
        
        animations = {
            enabled = true;
        
            # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        
            bezier = "overshot,0.13,0.99,0.29,1.1";
            
            animation = [
                "windows,1,4,overshot,popin"
                "fade,1,10,default"
                "workspaces,1,6,overshot,slide"
                "border,1,10,default"
            ];
        };
        
        dwindle = {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true; # you probably want this
            force_split = false;
        };
        
        master = {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_is_master = true;
            new_on_top = true;
        };
        
        gestures = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = true;
            workspace_swipe_min_speed_to_force = "5";
        };
        
        misc = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            force_default_wallpaper = "-2"; # Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            mouse_move_enables_dpms = true;
            vfr = false;
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

        # Window rules taken from https://github.com/1amSimp1e/dots/tree/late-night-%F0%9F%8C%83
        windowrule = [
          "float,Rofi"
          "float,pavucontrol"
          "opacity 0.92,Thunar"
          "opacity 0.96,discord"
          "opacity 0.9,VSCodium"
          "opacity 0.88,obsidian"
          "tile,librewolf"
          "tile,spotify"
          "opacity 1,neovim"
          "opacity 0.8,kitty"
        ];

        windowrulev2 = [
          "float,class:^()$,title:^(Picture in picture)$"
          "float,class:^(brave)$,title:^(Save File)$"
          "float,class:^(brave)$,title:^(Open File)$"
          "float,class:^(LibreWolf)$,title:^(Picture-in-Picture)$"
          "float,class:^(blueman-manager)$"
          "float,class:^(org.twosheds.iwgtk)$"
          "float,class:^(blueberry.py)$"
          "float,class:^(xdg-desktop-portal-gtk)$"
          "float,class:^(geeqie)$"
        ];
        
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
          "$mainMod, RETURN, exec, $terminal -d `pwd`"
          "$mainMod SHIFT, Q, killactive,"
          "$mainMod, E, exit,"
          # "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$secondMod, SPACE, exec, $menu"
          # "$mainMod, P, pseudo, # dwindle"
          "$mainMod, P, exec, $screenshot"
          "$mainMod CTRL, S, togglesplit, # dwindle"
        
        # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, H, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, L, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, K, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, J, movefocus, d"
        
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
