{ ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number relativenumber
      set title
      set noruler

      nnoremap S :%s//g<Left><Left>
    '';
  };
}
