{ config, pkgs, lib, inputs, username, customizations, ... }: {

  imports = [ 
    ./firefox/firefox.nix 
    ./desktops/${lib.strings.toLower customizations.desktop}
    ./vscode
  ];

  home.stateVersion = "23.05";
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.packages = [ ];

  home.sessionVariables = {
    PATH = "$HOME/sh:$PATH";
  };

  programs.bash = {
    enable = true;
    historyIgnore = [ "ls" "la" "ll" "cd" "exit" ];
    initExtra = ''
      PS1="[\[$(tput bold)\]\u@\h\[$(tput sgr0)\] \w]\[$(tput sgr0)\]\$" 
    '';
    shellAliases = {
      bbb = "sudo nixos-rebuild switch --flake ~/nixos";
      ls = "ls --color=auto";
      ll = "ls -l";
      la = "ls -al";
      grep = "grep --color=auto";
      c = "clear & clear";
    };

    profileExtra = ''
      [[ "$(tty)" == /dev/tty1 ]] && {
        ${customizations.desktop}
      }
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      #{ name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];

    shellAliases = {
      bbb = "sudo nixos-rebuild switch --flake ~/nixos";
      ls = "ls --color=auto";
      ll = "ls -l";
      la = "ls -al";
      grep = "grep --color=auto";
      c = "clear & clear";
    };

    loginShellInit = ''
      if test (tty) = "/dev/tty1"
        ${customizations.desktop}
      end
    '';
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

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
