{ wallpaper, lock, terminal, menu }:
{ config, pkgs, lib, ... }:
{
	imports = with pkgs; [
		./waybar
		./bemenu.nix
		./gtk.nix
		./swayidle.nix

		(import ./swaylock.nix { image = lock; })
	];

	home.packages = with pkgs; [
		grim
		slurp
		swaybg
		wl-clipboard
	];

	xdg.configFile."hypr/wallpaper".source = ../../.users + "/${wallpaper}";

	home.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		GDK_BACKEND = "wayland,x11";
		QT_QPA_PLATFORM = "wayland;xcb";
		# SDL_VIDEODRIVER = "wayland";
		CLUTTER_BACKEND = "wayland";
		QT_AUTO_SCREEN_SCALE_FACTOR = "1";
		QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

		XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
	};

	wayland.windowManager.hyprland = {
		enable = true;
		systemdIntegration = true;
		enableNvidiaPatches = true;
		extraConfig = ''
		# Launch
		exec-once = hyprctl setcursor Catppuccin-Mocha-Dark-Cursors 24
		exec-once = swaybg -i ~/.config/hypr/wallpaper
		exec-once = waybar

		# Monitors
		monitor=eDP-1,1920x1080@360,auto,1
		monitor=HDMI-A-1,3840x2160@60,auto,2
		monitor=,highres,auto,1

		# Mouse
		env = XCURSOR_SIZE,14

		input {
		  kb_layout = us
		  kb_variant =
		  kb_model =
		  kb_options =
		  kb_rules =

		  follow_mouse = 1

		  touchpad {
		    natural_scroll = false
		  }

		  sensitivity = -0.6
		  repeat_delay = 250
		  repeat_rate = 40
		}

		general {
		  gaps_in = 5
		  gaps_out = 10
		  border_size = 0

		  col.active_border = 0xFF7AA2F7 0xFF61AFEF 45deg
		  col.inactive_border = rgba(595959aa)
		  col.group_border = 0x00000000
		  col.group_border_active = 0x00000000

		  layout = dwindle

		  cursor_inactive_timeout = 3
		  no_cursor_warps = false
		}

		misc {
		  render_titles_in_groupbar = false
		  groupbar_titles_font_size = 8
		  groupbar_gradients = false

		  disable_hyprland_logo = true
		  disable_splash_rendering = true
		  mouse_move_enables_dpms = true
		  no_direct_scanout = true
		  render_ahead_of_time = false
		  vfr = false
		  vrr = 1
		}

		debug {
		  overlay = false
		}

		decoration {
		  rounding = 6
		  multisample_edges = true

		  active_opacity = 1.0
		  inactive_opacity = 0.9

		  # blur = false
		  # blur_size = 6
		  # blur_passes = 3
		  # blur_new_optimizations = true

		  drop_shadow = false
		  shadow_ignore_window = true
		  shadow_offset = 1 2
		  shadow_range = 10
		  shadow_render_power = 2
		  col.shadow = 0x66404040
		}

		animations {
		  enabled = false

		  bezier = overshot, 0.05, 0.9, 0.1, 1.05
		  bezier = smoothOut, 0.36, 0, 0.66, -0.56
		  bezier = smoothIn, 0.25, 1, 0.5, 1

		  animation = windows, 1, 5, overshot, slide
		  animation = windowsOut, 1, 4, smoothOut, slide
		  animation = windowsMove, 1, 4, default
		  animation = border, 1, 10, default
		  animation = fade, 1, 10, smoothIn
		  animation = fadeDim, 1, 10, smoothIn
		  animation = workspaces, 1, 6, default
		}

		dwindle {
		  no_gaps_when_only = false
		  pseudotile = true
		  preserve_split = true
		}

		gestures {
		  workspace_swipe = false
		}

		# Rules
		windowrule = float, file_progress
		windowrule = float, confirm
		windowrule = float, dialog
		windowrule = float, download
		windowrule = float, notification
		windowrule = float, error
		windowrule = float, splash
		windowrule = float, confirmreset
		windowrule = float, title:Open File
		windowrule = float, title:branchdialog
		windowrule = float, feh
		windowrule = float, pavucontrol-qt
		windowrule = float, pavucontrol
		windowrule = float, file-roller
		windowrule = float, title:DevTools
		# windowrulev2 = opacity 0.95 0.95,class:^(${terminal})$

		# Bindings
		$mainMod = SUPER

		# Launcher
		bind = $mainMod SHIFT, RETURN, exec, ${terminal}
		bind = $mainMod, Space, exec, ${menu}
		bind = $mainMod, q, killactive, 
		bind = $mainMod SHIFT, Escape, exit, 
		bind = $mainMod, f, fullscreen, 
		bind = $mainMod, v, togglefloating, 
		bind = $mainMod, a, togglespecialworkspace
		bind = $mainMod SHIFT, a, movetoworkspace, special
		bind = $mainMod, c, exec, hyprctl dispatch centerwindow
		bind = $mainMod, p, pseudo, # dwindle
		bind = $mainMod, s, togglesplit, # dwindle
		bind = $mainMod SHIFT, z, exec, swaylock
		bind = $mainMod SHIFT, b, exec, killall -SIGUSR2 waybar # Reload Waybar

		# Music
		bind = , XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -2000
		bind = , XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +2000
		bind = , XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
		bind = , XF86AudioPrev, exec, mpc prev
		bind = , XF86AudioNext, exec, mpc next
		bind = , XF86AudioPlay, exec, mpc toggle
		bind = $mainMod, Prior, exec, mpc prev
		bind = $mainMod, Next, exec, mpc next
		bind = $mainMod, XF86AudioMute, exec, mpc toggle
		bind = $mainMod, XF86AudioLowerVolume, exec, mpc seek -5
		bind = $mainMod, XF86AudioRaiseVolume, exec, mpc seek +5

		# Functions
		bind = , XF86MonBrightnessDown, exec, light -U 10
		bind = , XF86MonBrightnessUp, exec, light -A 10
		bind = , XF86KbdBrightnessDown, exec, asusctl -p
		bind = , XF86KbdBrightnessUp, exec, asusctl -n
		bind = , XF86Launch1, exec, asusctl led-mode -n
		bind = , XF86RFKill, exec, rfkill toggle all
		bind = , Print, exec, grim -g "$(slurp)" ~/Desktop/screenshot.png

		# Focus
		bind = $mainMod, h, movefocus, l
		bind = $mainMod, l, movefocus, r
		bind = $mainMod, k, movefocus, u
		bind = $mainMod, j, movefocus, d

		# Movement
		bind = $mainMod SHIFT, h, movewindow, l
		bind = $mainMod SHIFT, l, movewindow, r
		bind = $mainMod SHIFT, k, movewindow, u
		bind = $mainMod SHIFT, j, movewindow, d

		# Resizing
		bind = $mainMod ALT, h, resizeactive, -20 0
		bind = $mainMod ALT, l, resizeactive, 20 0
		bind = $mainMod ALT, k, resizeactive, 0 -20
		bind = $mainMod ALT, j, resizeactive, 0 20

		# Switch Workspaces
		bind = $mainMod, 1, workspace, 1
		bind = $mainMod, 2, workspace, 2
		bind = $mainMod, 3, workspace, 3
		bind = $mainMod, 4, workspace, 4
		bind = $mainMod, 5, workspace, 5
		bind = $mainMod, 6, workspace, 6
		bind = $mainMod, 7, workspace, 7
		bind = $mainMod, 8, workspace, 8
		bind = $mainMod, 9, workspace, 9
		bind = $mainMod, 0, workspace, 10
		bind = $mainMod SHIFT, 1, movetoworkspace, 1
		bind = $mainMod SHIFT, 2, movetoworkspace, 2
		bind = $mainMod SHIFT, 3, movetoworkspace, 3
		bind = $mainMod SHIFT, 4, movetoworkspace, 4
		bind = $mainMod SHIFT, 5, movetoworkspace, 5
		bind = $mainMod SHIFT, 6, movetoworkspace, 6
		bind = $mainMod SHIFT, 7, movetoworkspace, 7
		bind = $mainMod SHIFT, 8, movetoworkspace, 8
		bind = $mainMod SHIFT, 9, movetoworkspace, 9
		bind = $mainMod SHIFT, 0, movetoworkspace, 10

		# Tabs
		bind = $mainMod, t, togglegroup
		bind = $mainMod, Tab, changegroupactive, f
		bind = $mainMod SHIFT, Tab, changegroupactive, b

		# Mouse
		bindm = $mainMod, mouse:272, movewindow
		bindm = $mainMod, mouse:273, resizewindow
		'';
	};
}