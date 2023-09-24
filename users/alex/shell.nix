{ config, pkgs, lib, inputs, username, customizations, ... }: 
let 
  aliases = {
    bbb = "sudo nixos-rebuild switch --flake ~/nixos";
    ls = "ls --color=auto";
    ll = "ls -l";
    la = "ls -al";
    grep = "grep --color=auto";
    c = "clear & clear";
  };
in {
  
  home.sessionVariables = {
    PATH = "$HOME/sh:$PATH";
  };

  programs.bash = if customizations.shell == "bash" then 
  {
    enable = true;
    historyIgnore = [ "ls" "la" "ll" "cd" "exit" ];
    initExtra = ''
      PS1="[\[$(tput bold)\]\u@\h\[$(tput sgr0)\] \w]\[$(tput sgr0)\]\$" 
    '';
    shellAliases = aliases;

    profileExtra = ''
      [[ "$(tty)" == /dev/tty1 ]] && {
        ${customizations.desktop}
      }
    '';
  } else {};

  
  programs.fish = if customizations.shell == "fish" then 
  {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      #{ name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];

    shellAliases = aliases;

    loginShellInit = ''
      if test (tty) = "/dev/tty1"
        ${customizations.desktop}
      end
    '';
  } else {};
}