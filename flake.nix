{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let 
    system = "x86_64-linux";
    hostname = "stinkpad";
    username = "alex";
  in 
  {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system hostname username; };
      modules = [
        ./hosts/${hostname}
      ];
    };
  };
}
