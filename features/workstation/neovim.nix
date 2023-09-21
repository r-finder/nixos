{ config, pkgs, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    configure = {
      customRC  = ''
                set number relativenumber
                highlight LineNr ctermfg=DarkGray

                set encoding=utf-8

                set hlsearch
                set incsearch
                set ignorecase
                set smartcase

                syntax on
      '';

      packages.myVimPackage = with pkgs.vimPlugins; {
                # loaded on launch
                start = [ 
                    # fugitive 
                    # nvim-lspconfig
                    nvim-treesitter.withAllGrammars
                    # plenary-nvim
                    # gruvbox-material
                    # mini-nvim
                    vim-nix
                    lightline-vim
                  ];
                # manually loadable by calling `:packadd $plugin-name`
                opt = [ ];
              };
            };
          };
        }
