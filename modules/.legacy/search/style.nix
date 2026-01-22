{ config, lib, ... }:

with config.stylix.fonts;

let
  inherit (config.lib.formats.rasi) mkLiteral;
  mkRgba =
    opacity: color:
    let
      c = config.lib.stylix.colors;
      r = c."${color}-rgb-r";
      g = c."${color}-rgb-g";
      b = c."${color}-rgb-b";
    in
    mkLiteral "rgba ( ${r}, ${g}, ${b}, ${opacity} % )";
  mkRgb = mkRgba "100";
  rofiOpacity = builtins.toString (
    builtins.ceil (config.stylix.opacity.popups * 100)
  );
in
{
  programs.rofi = {
    # original theme by newmanls (rofi-themes-collection)
    location = "top";
    font = "${monospace.name} ${toString sizes.popups}";
    theme = lib.mkForce {
      "*" = {
        base00 = mkRgba rofiOpacity "base00";
        base01 = mkRgb "base01";
        base01a = mkRgba rofiOpacity "base01";
        base02 = mkRgb "base02";
        base03 = mkRgb "base03";
        base04 = mkRgb "base04";
        base05 = mkRgb "base05";
        base06 = mkRgb "base06";
        base07 = mkRgb "base07";
        base08 = mkRgb "base08";
        base09 = mkRgb "base09";
        base0A = mkRgb "base0A";
        base0B = mkRgb "base0B";
        base0C = mkRgb "base0C";
        base0D = mkRgb "base0D";
        base0E = mkRgb "base0E";
        base0F = mkRgb "base0F";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@base05";

        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        spacing = mkLiteral "0px";
      };

      window = {
        #location = mkLiteral "north";
        #y-offset = mkLiteral "calc(50% - 176px)";
        y-offset = mkLiteral "5px";
        width = 480;
        border-radius = mkLiteral "8px";

        background-color = mkLiteral "@base01a";
      };

      mainbox = {
          padding = mkLiteral "12px";
      };
      
      inputbar = {
          background-color = mkLiteral "@base01";
          border-color = mkLiteral "@base0E";
      
          border = mkLiteral "2px";
          border-radius = mkLiteral "8px";
      
          padding = mkLiteral "8px 16px";
          spacing = mkLiteral "8px";
          children = mkLiteral "[ prompt, entry ]";
      };
      
      prompt = {
          text-color = mkLiteral "@base05";
      };
      
      entry = {
          placeholder = "Search";
          placeholder-color = mkLiteral "@base03";
      };
      
      message = {
          margin = mkLiteral "12px 0 0";
          border-radius = mkLiteral "8px";
          border-color = mkLiteral "@base02";
          background-color = mkLiteral "@base02";
      };
      
      textbox = {
          padding = mkLiteral "8px 24px";
      };
      
      listview = {
          background-color = mkLiteral "transparent";
      
          margin = mkLiteral "12px 0 0";
          lines = mkLiteral "8";
          columns = mkLiteral "1";
      
          fixed-height = mkLiteral "false";
      };
      
      element = {
          padding = mkLiteral "8px 16px";
          spacing = mkLiteral "8px";
          border-radius = mkLiteral "8px";
      };
      
      "element normal active" = {
          text-color = mkLiteral "@base0E";
      };
      
      "element alternate active" = {
          text-color = mkLiteral "@base0E";
      };
      
      "element selected normal, element selected active" = {
          background-color = mkLiteral "@base0E";
      };

      "element selected" = {
        text-color = mkLiteral "@base01";
      };
      
      element-icon = {
          size = mkLiteral "1em";
          vertical-align = mkLiteral "0.5";
      };
      
      element-text = {
          text-color = mkLiteral "inherit";
      };
    };
  };
}
