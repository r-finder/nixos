{ config, pkgs, inputs, ... }:
{
  imports = [
    ./neovim.nix
    ./obsidian.nix
  ];

  environment.systemPackages = with pkgs; [
    nodejs
    #vscode 
    nixfmt
  ];
}