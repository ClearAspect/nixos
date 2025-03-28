{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;

    systemd.enable = true;

    settings = {
      monitor = [
        "DP-2,3840x2160@144, 0x0, 1.5, bitdepth, 10"
        "DP-1,3840x2160@60, 0x-1440, 1.5"
        "HDMI-A-1,1920x1080@60, -1080x-1080, 1, transform, 1"
      ];
      workspace = [
        "1,monitor:DP-2, default:true"
        "2,monitor:DP-2"
        "3,monitor:DP-2"
        "4,monitor:DP-2"
        "5,monitor:DP-2"
        "6,monitor:DP-1, default:true"
        "7,monitor:DP-1"
        "8,monitor:DP-1"
        "9,monitor:DP-1"
        "10,monitor:DP-1"
      ];
      exec-once = [
        "waybar" #& swww-daemon & swaync
        "hyprpaper"
      ];
      general = {
        gaps_in = "4";
        gaps_out = "4";

        border_size = "1";

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        # "col.active_border" = "$blue $blue 45deg";
        "col.active_border" = "rgb(76787c)";
        "col.inactive_border" = "rgb(76787c)";

        # Set Uto true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = "false";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = "false";

        layout = "dwindle";
      };

      decoration = {
        rounding = "10";

        # Change transparency of focused and unfocused windows
        active_opacity = "1.0";
        inactive_opacity = "1.0";

        shadow = {
          enabled = "false";
          range = "4";
          render_power = "3";
          color = "rgb(76787c)";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = "true";
          size = "4";
          passes = "4";
          ignore_opacity = "false";
          new_optimizations = "true";
          noise = "0.0117";
          vibrancy = "0.1696";
        };
      };
      animations = {
        enabled = "true";

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        # bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        # animation = windows, 1, 7, myBezier
        # animation = windowsOut, 1, 7, default, popin 80%
        # animation = border, 1, 10, default
        # animation = borderangle, 1, 8, default
        # animation = fade, 1, 7, default
        # animation = workspaces, 1, 3, default # Speed half default

        # bezier = [
        #   "myBezier, 0.05, 0.9, 0.1, 1.05"
        # ];
        # animation = [
        #   "windows, 1, 7, myBezier"
        #   "windowsOut, 1, 7, default, popin 80%"
        #   "border, 1, 10, default"
        #   "borderangle, 1, 8, default"
        #   "fade, 1, 7, default"
        #   "workspaces, 1, 3, default"
        # ];

        bezier = [
          # NAME, X0, Y0, X1, Y1
        ];
        animation = [
          # NAME, ONOFF, SPEED, CURVE [,STYLE]
          # windows - styles: slide, popin, gnomed
          "windows, 1, 3, default, popin 80%"
          # "windowsIn, 1, 7, default"
          # "windowsOut, 1, 7, default"
          # "windowsMove, 1, 7, default"
          # layers - styles: slide, popin, fade
          # "layers, 1, 7, default"
          # "layersIn, 1, 7, default"
          # "layersOut, 1, 7, default"
          # fade
          # "fade, 1, 7, default"
          # "fadeIn, 1, 7, default"
          # "fadeOut, 1, 7, default"
          # "fadeSwitch, 1, 7, default"
          # "fadeDim, 1, 7, default"
          # "fadeLayers, 1, 7, default"
          # "fadeLayersIn, 1, 7, default"
          # "fadeLayersOut, 1, 7, default"
          # border
          # "border, 1, 10, default"
          # "borderangle, 1, 8, default"
          # workspaces - styles: slide, slidevert, fade, slidefade, slidefadevert
          "workspaces, 1, 3, default, slidefade 80%"
          # "workspacesIn, 1, 3, default"
          # "workspacesOut, 1, 3, default"
          # "specialWorkspace, 1, 3, default"
          # "specialWorkspaceIn, 1, 3, default"
          # "specialWorkspaceOut, 1, 3, default"
        ];
      };

      dwindle = {
        pseudotile = "true"; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "true"; # You probably want this
      };

      layerrule = [
        "blur, logout_dialog"
        "blur, swaync-control-center"
        "blur, swaync-notiication-window"
        "blur, anyrun"

        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"
        "ignorezero, anyrun"

        "ignorealpha 0.5, swaync-control-center"
        "ignorealpha 0.5, swaync-notification-window"
        "ignorealpha 0.5, anyrun"
      ];

      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      "$browser" = "firefox";
      "$fileManager" = "nautilus";
      "$menu" = "anyrun";
      "$wallpaper" = "";
      "$screenshot" = "hyprshot -m region -m active --clipboard-only";

      bind = [
        "$mainMod, T, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, P, pseudo" # dwindle
        "$mainMod, O, togglesplit" # dwindle

        "$mainMod ALT, N, exec, swaync-client -t -sw" # swayNC panel
        "$mainMod, W, exec, $wallpaper"

        "$mainMod, F, fullscreen"

        "$mainMod SHIFT, P, exec, $screenshot"

        # Move focus with mainMod + vim motions
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Move windows with mainMod + SHIFT + vim motions
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
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

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
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
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Volume Control Bindings
        "$mainMod, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Media Control Bindings
        "$mainMod, XF86AudioPlay, exec, playerctl play-pause"
        "$mainMod, XF86AudioNext, exec, playerctl next"
        "$mainMod, XF86AudioPrev, exec, playerctl previous"
      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging

        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      windowrulev2 = [
        "float, class:steam"
      ];
      input = {
        kb_layout = "us";

        follow_mouse = "1";
        force_no_accel = "1";
        accel_profile = "fat";

        sensitivity = "0"; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = "false";
        };
      };
      # binde = [
      #   # Volume Control Bindings
      #   "XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
      #   "XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      # ];
    };
  };
}
