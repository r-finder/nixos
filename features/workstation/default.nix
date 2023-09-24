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

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

}