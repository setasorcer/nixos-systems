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
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
      ui.colorizer = {
        enable = true;
        setupOpts = {
          filetypes = {
            "*" = { };
          };
        };
      };

      lsp.enable = true;
      lsp.servers.nixd.settings.nil.nix.autoArchive = false;
      languages = {
        enableTreesitter = true;

        nix.enable = true;
      };
    };
  };
}
