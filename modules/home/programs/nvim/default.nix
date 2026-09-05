{ inputs, ... }:

{
  imports = [ inputs.nvf.homeManagerModules.default ];
  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      options = {
        shiftwidth = 2;
        relativenumber = true;
      };
      keymaps = [
        {
          key = "S";
          mode = ["n"];
          action = ":%s//g<Left><Left>";
        }
      ];

      statusline.lualine.enable = true;
      autocomplete.nvim-cmp.enable = true;
      binds.whichKey.enable = true;

      autopairs.nvim-autopairs.enable = true;
      notes.todo-comments.enable = true;
      utility = {
        surround.enable = true;
      };
      ui = {
        colorizer = {
          enable = true;
          setupOpts = {
            filetypes = {
              "*" = { };
            };
          };
        };
        noice.enable = true;
      };
      visuals.indent-blankline.enable = true;

      lsp.enable = true;
      languages = {
        enableTreesitter = true;

        nix.enable = true;
        markdown = {
          enable = true;
          extensions.render-markdown-nvim.enable = true;
        };
      };
    };
  };
  home.sessionVariables.EDITOR = "nvim";
}
