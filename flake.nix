{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let 
    system = "x86_64-linux";
    hostname = "stinkpad";
    username = "alex";
    desktop = "sway";
  in 
  {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system hostname username desktop; };
      modules = [
        ./hosts/${hostname}
      ];
    };
  };
}
