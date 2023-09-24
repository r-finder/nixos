{ config, pkgs, lib, inputs, username, customizations, ... }: 
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        name = "Cascadia";
        size = 10;
      };
    };
  };
}
