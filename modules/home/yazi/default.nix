{ config, pkgs, ... }:

{
  # Ability to move directories within terminal
  programs.fish.functions = {
    y = ''
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      yazi $argv --cwd-file="$tmp"
      if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
      end
      rm -f -- "$tmp"
    '';
  };
  # lf accessories
  home.packages = with pkgs; [
    dragon-drop # Drag and drop with dragon
    chafa # Sixel companion
    # Unfree ouch build for rar functions
    (ouch.override {
      enableUnfree = true;
    })
    exiftool
    mediainfo
    sshfs # For sshfs plugin
  ];

  programs.yazi = {
    enable = true;
    initLua = ./init.lua;
    settings = {
      mgr = {
        show_symlink = false;
      };
      plugin = {
        prepend_preloaders = [
          { name = "${config.home.homeDirectory}/dox/mnt/**"; run = "noop"; }
        ];
        prepend_previewers = [
          { name = "${config.home.homeDirectory}/dox/mnt/**"; run = "noop"; }
          # Archive previewer
          { mime = "application/*zip"; run = "ouch"; }
          { mime = "application/x-tar"; run = "ouch"; }
          { mime = "application/x-bzip2"; run = "ouch"; }
          { mime = "application/x-7z-compressed"; run = "ouch"; }
          { mime = "application/x-rar"; run = "ouch"; }
          { mime = "application/x-xz"; run = "ouch"; }
          { name = "*.zip"; run = "ouch"; }
          { name = "*.xz"; run = "ouch"; }
          { name = "*.rar"; run = "ouch"; }
          { name = "*.7z"; run = "ouch"; }
          { name = "*.tar"; run = "ouch"; }
        ];
      };
      opener = {
        extract = [{ run = ''ouch d -y "$@"''; desc = "Extract here with ouch"; }];
        edit = [{ run = ''nvim "$@"''; block = true; }];
      };
      tasks = {
        image_bound = [ 10000 10000 ];
      };
    };
    keymap = {
      mgr.prepend_keymap = [
        # Exit to shell
        { run = '' shell "$SHELL" --block ''; on = [ "!" ]; desc = "Open shell here"; }
        # Alternative movement (personal preference coming from lf)
        { on = [ "[" ]; run = "plugin parent-arrow 1"; }
        { on = [ "]" ]; run = "plugin parent-arrow -1"; }
        { on = [ "f" ]; run = "plugin jump-to-char"; desc = "Jump to char"; }
        { on = [ "1" ]; run = "plugin relative-motions 1"; desc = "Move in relative steps"; }
        { on = [ "2" ]; run = "plugin relative-motions 2"; desc = "Move in relative steps"; }
        { on = [ "3" ]; run = "plugin relative-motions 3"; desc = "Move in relative steps"; }
        { on = [ "4" ]; run = "plugin relative-motions 4"; desc = "Move in relative steps"; }
        { on = [ "5" ]; run = "plugin relative-motions 5"; desc = "Move in relative steps"; }
        { on = [ "6" ]; run = "plugin relative-motions 6"; desc = "Move in relative steps"; }
        { on = [ "7" ]; run = "plugin relative-motions 7"; desc = "Move in relative steps"; }
        { on = [ "8" ]; run = "plugin relative-motions 8"; desc = "Move in relative steps"; }
        { on = [ "9" ]; run = "plugin relative-motions 9"; desc = "Move in relative steps"; }

        # External applications
        { run = '' shell 'dragon-drop "$@"' ''; on = [ "<C-n>" ]; desc = "Drag and drop with dragon"; }
        { run = '' shell 'ouch d "$@"' ''; on = [ "<S-e>" ]; desc = "Extract here with ouch"; }
        { run = '' plugin ouch ''; on = [ "<S-c>" ]; desc = "Compress with ouch"; }

        # Bookmarks with yamb
        { on = [ "u" "a" ]; run = "plugin yamb save"; desc = "Add bookmark"; }
        { on = [ "'" ]; run = "plugin yamb jump_by_key"; desc = "Jump bookmark by key"; }
        { on = [ ''"'' ]; run = "plugin yamb jump_by_fzf"; desc = "Jump bookmark by fzf"; }
        { on = [ "u" "d" ]; run = "plugin yamb delete_by_key"; desc = "Delete bookmark by key"; }
        { on = [ "u" "D" ]; run = "plugin yamb delete_by_fzf"; desc = "Delete bookmark by fzf"; }
        { on = [ "u" "A" ]; run = "plugin yamb delete_all"; desc = "Delete all bookmarks"; }
        { on = [ "u" "r" ]; run = "plugin yamb rename_by_key"; desc = "Rename bookmark by key"; }
        { on = [ "u" "R" ]; run = "plugin yamb rename_by_fzf"; desc = "Rename bookmark by fzf"; }
        # Disable builtin keybindings
        { on = [ "g" "h" ]; run = "noop"; }
        { on = [ "g" "c" ]; run = "noop"; }
        { on = [ "g" "d" ]; run = "noop"; }
        { on = [ "M" "m" ]; run = "plugin sshfs -- mount --jump"; desc = "Mount & jump"; }
        { on = [ "M" "u" ]; run = "plugin sshfs -- unmount"; desc = "Unmount SSHFS"; }
        { on = [ "M" "a" ]; run = "plugin sshfs -- add"; desc = "Add SSH host"; }
        { on = [ "M" "r" ]; run = "plugin sshfs -- remove"; desc = "Remove SSH host"; }
        { on = [ "M" "h" ]; run = "plugin sshfs -- home"; desc = "Go to mount home"; }
        { on = [ "M" "c" ]; run = "cd ~/.ssh/"; desc = "Go to ssh config"; }
        { on = [ "g" "m" ]; run = "plugin sshfs -- jump"; desc = "Jump to mount"; }
      ];
    };
    plugins = {
      ouch = pkgs.yaziPlugins.ouch;
      yamb = ./yamb;
      parent-arrow = ./parent-arrow;
      jump-to-char = pkgs.yaziPlugins.jump-to-char;
      relative-motions = pkgs.yaziPlugins.relative-motions;
      sshfs = ./sshfs;
    };
  };
}
