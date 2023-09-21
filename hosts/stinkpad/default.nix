{ config, pkgs, inputs, hostname, username, ... }:
{
  system.stateVersion = "23.05"; # Did you read the comment?
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
  };
  nixpkgs.config.allowUnfree = true; 

  imports =
    [ 
      inputs.home-manager.nixosModules.home-manager
      ./hardware-configuration.nix
      ../../features/secrets
      ../../features/crypto
      ../../features/wayland
      ../../features/laptop
      ../../features/workstation
    ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = false;
  
  networking.hostName = hostname; # Define your hostname.
  networking.enableIPv6 = false;
  systemd.network.enable = true;
  systemd.network.networks."10-wlan" = {
	matchConfig.Name = "wl*";
	networkConfig.DHCP = "yes";
  };

  networking.wireless.enable = true;  
  networking.wireless.userControlled.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.wheelNeedsPassword = false;
  users.users.${username} = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; 
     packages = with pkgs; [

     ];
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit username; };
  home-manager.users.${username} = import ../../users/${username};  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     #home-manager
     htop
     btop
     tree
     git
     curl
     killall
     zip
     unzip
     tldr
     mc
  ];
}

