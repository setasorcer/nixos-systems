{ config, ... }:

{
  home.file.".config/umbriel/colors.toml".text = ''
    [colors]
    background = "${config.lib.stylix.colors.withHashtag.base01}FF"
    text_primary = "${config.lib.stylix.colors.withHashtag.base07}FF"
    text_muted = "${config.lib.stylix.colors.withHashtag.base04}FF"
    accent_primary = "${config.lib.stylix.colors.withHashtag.base0D}FF"
    accent_secondary = "${config.lib.stylix.colors.withHashtag.base09}FF"
    warning = "${config.lib.stylix.colors.withHashtag.base09}FF"
    error = "${config.lib.stylix.colors.withHashtag.base0F}FF"
    insert_hint = "${config.lib.stylix.colors.withHashtag.base0D}80"
    backdrop = "${config.lib.stylix.colors.withHashtag.base00}FF"
    shadow = "${config.lib.stylix.colors.withHashtag.base00}7F"
    [colors.border]
    focused = "${config.lib.stylix.colors.withHashtag.base0D}FF"
    unfocused = "${config.lib.stylix.colors.withHashtag.base00}FF"
    outer = "${config.lib.stylix.colors.withHashtag.base01}FF"
    [colors.overview]
    background_tint = "${config.lib.stylix.colors.withHashtag.base01}30"
    workspace_background = "${config.lib.stylix.colors.withHashtag.base00}44"
    badge = "${config.lib.stylix.colors.withHashtag.base0D}FF"
  '';
}
