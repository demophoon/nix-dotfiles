{
  description = "My dotfiles as a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ...}:
  let
    system = "x86_64-linux";
  in
  {
    defaultPackage.${system} = home-manager.defaultPackage.${system};

    homeConfigurations = {
      "britt" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };

        modules = [
          ./home-manager/home.nix
        ];
      };
    };

  };
}
