{config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
    # Telescope
      plenary-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      nvim-web-devicons
      telescope-nvim

    # Mason LSP 
      mason.nvim
      mason-lspconfig.nvim
      mason-tool-installer.nvim
      fidget-nvim
      neodev-nvim
      nvim-lspconfig
      conform-nvim

    # Theme
      catppuccin-nvim

    # Cool stuff
      vim-sleuth
      comment-nvim
      gitsigns-nvim
      nvim-treesitter
      nvim-tree-lua
      todo-comments-nvim
      mini-nvim

   ];

  };
}
