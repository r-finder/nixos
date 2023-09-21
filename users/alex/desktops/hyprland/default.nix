{ config, pkgs, inputs, username, ... }: 
{
  xdg = {
    enable = true;
    configFile."hypr/hyprland.conf".source = ./config;
    configFile."kanshi/config".source = ../../kanshi/config;
    configFile."waybar/config".source = ./config_waybar;
		configFile."waybar/style.css".source = ../../waybar/waybar_css;
  };
}
