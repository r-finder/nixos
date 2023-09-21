{ config, pkgs, inputs, ... }:
{
  imports =
    [ 
      ./common.nix
      ./sway.nix
    ];
}