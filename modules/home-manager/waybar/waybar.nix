{ pkgs, lib, config, ... }:

let
  cfg = "~/.nixos/modules/home-manager/waybar";
  python3 = "${pkgs.python3}/bin/python3";
  pythonWithDeps = "nix-shell -p 'python3.withPackages (python-pkgs: [python-pkgs.pygobject3])' -p playerctl -p gobject-introspection --command";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
in
{
  options = {};
  config = {
    programs.waybar = {
        enable = true;
        # style = "${cfg}/style.css"; 
        style = ./style.css; 
        settings = {
          mainBar = {
            height = 30; # Waybar height (to be removed for auto height)
            layer = "top"; # Waybar at top layer
            margin-top = 6;
            margin-left = 10;
            margin-bottom = 0;
            margin-right = 10;
            spacing = 5; # Gaps between modules (4px)
            modules-left = ["custom/launcher" "cpu" "memory" "hyprland/workspaces"];
            modules-center = ["custom/spotify"];
            modules-right = ["tray" "backlight" "pulseaudio" "network" "battery" "clock" "custom/power-menu"];
            "hyprland/workspaces" = {
              format = "{icon}";
              on-click = "activate";
              format-icons = {
                "1" = "";
                "2" = "";
                "3" = "";
                "4" = "";
                "5" = "";
                urgent = "";
                active = "";
                default = "";
              };
            };
            "hyprland/window" = {
                format = "{}";
            };
            tray = {
                spacing = 10;
            };
            clock = {
                format = "<span color='#bf616a'> </span>{:%H:%M}";
                format-alt = "<span color='#bf616a'> </span>{:%A, %B %d, %Y (%R)}";
                tooltip-format = "<tt><small>{calendar}</small></tt>";
                calendar = {
                  mode          = "year";
                  mode-mon-col  = 3;
                  weeks-pos     = "right";
                  on-scroll     = 1;
                  on-click-right= "mode";
                  format = {
                    months =     "<span color='#ffead3'><b>{}</b></span>";
                    days =       "<span color='#ecc6d9'><b>{}</b></span>";
                    weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
                    weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
                    today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
                  };
                };
                actions = {
                  on-click-right = "mode";
                  on-click-forward = "tz_up";
                  on-click-backward = "tz_down";
                  on-scroll-up = "shift_up";
                  on-scroll-down = "shift_down";
                };
            };

            cpu = {
              interval = 10;
              format = " {}%";
              max-length = 10;
              on-click = "";
            };
            memory = {
                interval = 30;
                format = " {}%";
                format-alt =" {used =0.1f}G";
                max-length = 10;
            };
            backlight = {
                device = "DP-1";
                format = "{icon} {percent}%";
                format-icons = ["" "" "" "" "" "" "" "" ""];
                on-click = "";
            };
            network = {
                format-wifi = "直 {signalStrength}%";
                format-ethernet = " wired";
                # format-disconnected = "睊";
                on-click = "bash ${cfg}/scripts/rofi-wifi-menu.sh";
                format-disconnected = "Disconnected  ";
            };

            pulseaudio = {
                format = "{icon} {volume}%";
                format-bluetooth = "  {volume}%";
                format-bluetooth-muted = " ";
                format-muted = "婢";
                format-icons = {
                    headphone = "";
                    hands-free = "";
                    headset = "";
                    phone = "";
                    portable = "";
                    car = "";
                    default = ["" "" ""];
                };
                on-click = "${pavucontrol}";
            };

            bluetooth = {
                on-click = "${cfg}/scripts/rofi-bluetooth &";
                format = " {status}";
            };

            battery = {
              bat = "BAT0";
              adapter = "ADP0";
              interval = 60;
              states = {
                  warning = 30;
                  critical = 15;
              };
              max-length = 20;
              format = "{icon} {capacity}%";
              format-warning = "{icon} {capacity}%";
              format-critical = "{icon} {capacity}%";
              format-charging = "<span font-family='Font Awesome 6 Free'></span> {capacity}%";
              format-plugged = "  {capacity}%";
              format-alt = "{icon} {time}";
              format-full = "  {capacity}%";
              format-icons = [" " " " " " " " " "];
            };
            # "custom/weather" = {
            #   exec = "${pkgs.python3}/bin/python3 ${cfg}/scripts/weather.py";
            #   restart-interval = 300;
            #   return-type = "json";
            #   on-click = "xdg-open https://weather.com/en-IN/weather/today/l/a319796a4173829988d68c4e3a5f90c1b6832667ea7aaa201757a1c887ec667a";
            # };   

            "custom/spotify" = {
              exec = "${pythonWithDeps} 'python ${cfg}/scripts/mediaplayer.py --player spotify'";
              format = "{}  ";
              return-type = "json";
              on-click = "${playerctl} play-pause";
              on-double-click-right = "${playerctl} next";
              on-scroll-down = "${playerctl} previous";
            };
            "custom/power-menu" = {
                format = " <span color='#6a92d7'>⏻ </span>";
                on-click = "bash ${cfg}/scripts/power-menu/powermenu.sh";
            }; 
            "custom/launcher" = {
                format = " <span color='#6a92d7'> </span>";
                on-click = "rofi -show drun";
            };
          };
        };
    };
  };
}