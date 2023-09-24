{ config, pkgs, lib, inputs, username, customizations, ... }: 
{
  imports = [ 
    ./firefox/firefox.nix 
    ./desktops/${lib.strings.toLower customizations.desktop}
    ./vscode
    ./shell.nix
    ./alacritty.nix
  ];

  home.stateVersion = "23.05";
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.packages = [ ];

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Alex S";
    userEmail = "alex.sustavov@outlook.com";
  };

  xdg = {
    enable = true;
    #configFile."Code/User/settings.json".source = ./vscode/vscode;
  };

  # dconf.settings = {
  #   "org/gnome/desktop/interface" = { font-name = "Sans 8"; };
  # };

}
