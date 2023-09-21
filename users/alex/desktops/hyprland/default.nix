{ config, pkgs, inputs, username, ... }: 
{
  xdg = {
    enable = true;
    configFile."hypr/hyprland.conf".source = ./config;
    configFile."kanshi/config".source = ../../kanshi/config;
  };
}
