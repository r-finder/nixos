{ config, pkgs, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    configure = {
      customRC  = ''
        luafile ${./nvim.lua}

        set number relativenumber
        highlight LineNr ctermfg=DarkGray

        set encoding=utf-8

        set hlsearch
        set incsearch
        set ignorecase
        set smartcase

        syntax on

        nmap <C-n> :NvimTreeToggle<CR>
      '';

      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ 
            nvim-treesitter.withAllGrammars
            vim-nix
            lightline-vim
            nvim-tree-lua
            nvim-web-devicons
          ];
        opt = [ ];
      };
    };
  };
}
