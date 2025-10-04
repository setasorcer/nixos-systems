{ pkgs, config, lib, ... }:

{
  imports = [
    ./binds.nix
    ./decoration.nix
    ./idle.nix
    ./lock.nix
  ];
  # Extra packages for desktop environment
  home.packages = with pkgs; [
    swww # set wallpaper
    wl-clipboard
    hyprpicker # color picker
    hyprshot # screenshots
    chayang # screen dimming
  ];
  wayland.windowManager.hyprland = {
    enable = false;
    # Disable because of UWSM
    systemd.enable = false;
    xwayland.enable = true;

    settings = {
      monitor = [
        "eDP-1, highrr, auto, 1.5, cm, auto, vrr, 1"
        "DP-2, highrr, auto, 1, cm, auto"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      # Default programs
      "$term" = "foot";
      "$fm" = "yazi";
      "$web" = "floorp";

      env = [
        "GNUPGHOME,$XDG_DATA_HOME/gnupg"
        "PASSWORD_STORE_DIR,$XDG_DATA_HOME/password-store" # For tessen
      ];

      exec-once = [
	"dbus-update-activation-environment --systemd --all" # For tessen (send env to hyprland)
	"uwsm finalize"
        "swww-daemon & sleep 0.2 && swww img ${config.stylix.image}" # Wallpaper
	"waybar" # Bar
	"avizo-service" # OSD
      ];

      general = {
        gaps_in = 5;
	gaps_out = "25, 50, 25, 50";

	border_size = 4;
	"col.active_border" = lib.mkForce "rgb(${config.stylix.base16Scheme.base0E})";
	"col.inactive_border" = lib.mkForce "rgb(${config.stylix.base16Scheme.base00})";

	resize_on_border = false;
	resize_corner = 3;
	allow_tearing = false;

	layout = "master";
      };

      input = {
	# Faster key repeat
        repeat_delay = 300;
	repeat_rate = 50;

	focus_on_close = 1; # Focus window under cursor when window is closed (can be none)
	mouse_refocus = false;
	accel_profile = "adaptive";
	# Natural scrolling
	touchpad = {
	  natural_scroll = true;
	  clickfinger_behavior = true;
	};
      };

      gestures = {
        workspace_swipe = true;
      };

      # Rules
      # Disable idle for fullscreen applications
      windowrulev2 = [ "idleinhibit fullscreen, class:.*" ];

      layerrule = [
        "blur, waybar|rofi|avizo|swaync-control-center|swaync-notification-window"
        "ignorealpha 0.5, waybar|rofi|avizo|swaync-control-center|swaync-notification-window"
        "animation slide top, waybar|rofi|swaync-control-center|swaync-notification-window"
      ];

      # Scratchpad configuration
      workspace = [
        "special:S, on-created-empty:[float; size 50% 50%] $term -a spterm"
        "special:C, on-created-empty:[float; size 25% 50%] $term -a spcalc bc -lq"
        "special:M, on-created-empty:[float; size 40% 25%] $term -a spmpd ncmpcpp"
      ];

      # Layout config
      master = {
        new_status = "master";
	mfact = 0.6;
      };

      misc = {
        enable_swallow = true; # Swallow terminal windows
	swallow_regex = [ "^($term)$" ];
	swallow_exception_regex = [ "^(wev)$" "^(dragon)$" ];
	vrr = 1; # VRR to save battery
	mouse_move_enables_dpms = true; 
	key_press_enables_dpms = false;
      };
    };
  };
  stylix.targets = {
    avizo.enable = true;
    btop.enable = true;
    fcitx5.enable = true;
    floorp.enable = true;
    floorp.profileNames = [ "default" ];
    foot.enable = true;
    gtk.enable = true;
    gtk.flatpakSupport.enable = true;
    #hyprland.enable = true;
    nvf.enable = true;
    nvf.transparentBackground.main = true;
    #rofi.enable = true;
    #swaync.enable = true;
    yazi.enable = true;
  };
  #stylix.targets.hyprland.hyprpaper.enable = lib.mkForce false;
  #stylix.targets.vencord.enable = lib.mkForce false;
  #stylix.targets.forge.enable = lib.mkForce false;
}
