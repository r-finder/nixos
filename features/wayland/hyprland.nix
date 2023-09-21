{ config, pkgs, lib, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
  ];

nixpkgs.overlays = [
  (self: super: {
    waybar = super.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  })
];

  programs.waybar = {
    enable = true;
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
}
