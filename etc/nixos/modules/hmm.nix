{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      username = "coldbrewrosh";
      name = "Rosh";
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            ./modules/unstable.nix
          ];
          specialArgs = {
            inherit username;
            inherit name;
            inherit pkgs-unstable;
          };
        };
      };

      # homeConfigurations = {
      #   USERNAME = home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs;
      #     modules = [
      #       ./home.nix
      #     ];
      #     extraSpecialArgs = {
      #       inherit username;
      #       inherit name;
      #       inherit pkgs-unstable;
      #     };
      #   };
      # };
    };
}
