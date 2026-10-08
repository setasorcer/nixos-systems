{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        pad = "24x24";
      };
      cursor = {
        style = "beam";
        blink = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };

      # Original foot-on-nix by ABDsheikho
      key-bindings = {
        scrollback-up-page = "Alt+Page_Up";
        scrollback-up-half-page = "Alt+u";
        scrollback-up-line = "Alt+k Alt+Up";
        scrollback-down-page = "Alt+Page_Down";
        scrollback-down-half-page = "Alt+d";
        scrollback-down-line = "Alt+j Alt+Down";
        scrollback-home = "Alt+h Alt+Home";
        scrollback-end = "Alt+l Alt+End";
        clipboard-copy = "Alt+y Alt+c";
        clipboard-paste = "Alt+p Alt+v";
        primary-paste = "Alt+Shift+p Alt+Shift+v";
        search-start = "Alt+slash Alt+Shift+f";
        font-increase = "Alt+plus Alt+equal Alt+KP_Add";
        font-decrease = "Alt+minus Alt+KP_Subtract";
        font-reset = "Alt+0 Alt+KP_0";
        spawn-terminal = "Alt+w";
        # minimize = "none";
        # maximize = "none";
        fullscreen = "Alt+Shift+Return Alt+Shift+KP_Enter";
        # pipe-visible = "[sh -c "xurls | fuzzel | xargs -r firefox"] none";
        # pipe-scrollback = "[sh -c "xurls | fuzzel | xargs -r firefox"] none";
        # pipe-selected = "[xargs -r firefox] none";
        # pipe-command-output = "[wl-copy] none # Copy last command's output to the clipboard";
        show-urls-launch = "Alt+o";                  # similar to o for open a new line, but for urls
        show-urls-copy = "Alt+Shift+o";
        show-urls-persistent = "Alt+Control+o";      # launche url without exiting url-mode
        prompt-prev = "Alt+Shift+k";                 # enable shell integration first, check https://codeberg.org/dnkl/foot/wiki#shell-integration"
        prompt-next = "Alt+Shift+j";                 # enable shell integration first, check https://codeberg.org/dnkl/foot/wiki#shell-integration"
        unicode-input = "Alt+i Control+Shift+u";     # i for input unicode, try input `99ff` or `1f60d` then press enter to confirm"
        # noop = "none";
        quit = "Alt+q";
      };
      
      search-bindings  = {
        cancel = "Escape Alt+bracketleft";
        # commit = "Return KP_Enter";
        find-prev = "Alt+n";
        find-next = "Alt+Shift+n";
        cursor-left = "Left Alt+h";
        cursor-left-word = "Alt+b Control+Left";
        cursor-right = "Right Alt+l";
        cursor-right-word = "Alt+w Control+Right";
        cursor-home = "Home Alt+0 Control+a";
        cursor-end = "End Alt+Shift+4 Control+e";
        # delete-prev = "BackSpace";
        delete-prev-word = "Alt+a Control+BackSpace";        # I'll use a
        # delete-next = "Delete";
        delete-next-word = "Alt+s Control+Delete";           # I'll use s
        delete-to-start = "Alt+Shift+a Control+u";           # I'll use shift+a
        delete-to-end = "Alt+Shift+s Control+k";             # I'll use shift+s
        extend-char = "Alt+Shift+l Shift+Right";
        extend-to-word-boundary = "Alt+Shift+w Control+w Control+Shift+Right";
        # extend-to-next-whitespace = "Control+Shift+w";
        extend-line-down = "Alt+Shift+j Shift+Down";
        extend-backward-char = "Alt+Shift+h Shift+Left";
        extend-backward-to-word-boundary = "Alt+Shift+b Control+Shift+Left";
        # extend-backward-to-next-whitespace = "none";
        extend-line-up = "Alt+Shift+k Shift+Up";
        clipboard-paste = "Alt+p Alt+v";
        primary-paste = "Alt+Shift+p Alt+Shift+v";
        unicode-input = "Alt+i Control+Shift+u";     # i for input unicode, try input `99ff` or `1f60d` then press enter to confirm
        scrollback-up-page = "Alt+Page_Up";
        scrollback-up-half-page = "Alt+u";
        scrollback-up-line = "Alt+k Alt+Up";
        scrollback-down-page = "Alt+Page_Down";
        scrollback-down-half-page = "Alt+d";
        scrollback-down-line = "Alt+j Alt+Down";
        # scrollback-home = "none";
        # scrollback-end = "none";
      };
      
      url-bindings = {
        cancel = "Escape Alt+bracketleft";
        # toggle-url-visible = "t";
      };
    };
  };
  home.sessionVariables.TERMINAL = "footclient";
}
