{ pkgs, ... }:

let
  noctalia = cmd: [
    "noctalia" "msg"
  ] ++ (pkgs.lib.splitString " " cmd);
in
{
  wayland.windowManager.niri.settings.binds = {
    "Mod+BackSpace" = {
      _props.repeat = false;
      spawn = noctalia "panel-toggle session";
    };
    "Mod+N" = {
      _props.repeat = false;
      spawn = noctalia "panel-open control-center notifications";
    };
    "Mod+Shift+N" = {
      _props.repeat = false;
      spawn = noctalia "notifications notifications dismissAllPopups";
    };
    "Mod+B" = {
      _props.repeat = false;
      spawn = noctalia "control-center toggle";
    };

    "XF86AudioRaiseVolume" = {
      _props.allow-when-locked = true;
      spawn = noctalia "volume-up 5";
    };
    "XF86AudioLowerVolume" = {
      _props.allow-when-locked = true;
      spawn = noctalia "volume-down 5";
    };
    "XF86AudioMute" = {
      _props.allow-when-locked = true;
      spawn = noctalia "volume-mute";
    };
    "XF86AudioMicMute" = {
      _props.allow-when-locked = true;
      spawn = noctalia "mic-mute";
    };
    "XF86MonBrightnessUp" = {
      _props.allow-when-locked = true;
      spawn = noctalia "brightness-up";
    };
    "XF86MonBrightnessDown" = {
      _props.allow-when-locked = true;
      spawn = noctalia "brightness-down";
    };
    "XF86AudioPlay".spawn = noctalia "media toggle";
    "XF86AudioStop".spawn = noctalia "media stop";
    "XF86AudioPrev".spawn = noctalia "media previous";
    "XF86AudioNext".spawn = noctalia "media next";
    "Mod+Down".spawn = noctalia "media toggle";
    "Mod+Up".spawn = noctalia "media stop";
    "Mod+Left".spawn = noctalia "media previous";
    "Mod+Right".spawn = noctalia "media next";
  };
}
