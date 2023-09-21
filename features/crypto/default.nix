{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
     pass
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}