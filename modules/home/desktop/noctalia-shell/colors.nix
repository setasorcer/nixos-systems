{ config, ... }:

with config.lib.stylix.colors;
{
  programs.noctalia-shell.colors = {
    mPrimary = "${withHashtag.base0E}";
    mOnPrimary = "${withHashtag.base06}";

    mSecondary = "${withHashtag.base05}";
    mOnSecondary = "${withHashtag.base02}";

    mTertiary = "${withHashtag.base09}";
    mOnTertiary = "${withHashtag.base02}";

    mError = "${withHashtag.base0F}";
    mOnError = "${withHashtag.base02}";

    mSurface = "${withHashtag.base01}";
    mOnSurface = "${withHashtag.base06}";

    mSurfaceVariant = "${withHashtag.base02}";
    mOnSurfaceVariant = "${withHashtag.base05}";

    mOutline = "${withHashtag.base03}";
    mShadow = "${withHashtag.base00}";

    mHover = "${withHashtag.base09}";
    mOnHover = "${withHashtag.base02}";
  };
}
