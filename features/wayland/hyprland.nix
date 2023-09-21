{ config, pkgs, lib, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
}
