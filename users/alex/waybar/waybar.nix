{ config, pkgs, ... }:
{ 

    home.packages = with pkgs; [ #enabling workspaces through Dexperimental flag
        waybar
    ];

    xdg = {
        configFile."waybar/config".source = ./waybar;
        configFile."waybar/style.css".source = ./waybar_css;
    };
}