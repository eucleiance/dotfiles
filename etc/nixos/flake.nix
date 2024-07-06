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
      # pkgs = nixpkgs.legacyPackages.${system};
      # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      commonArgs = { inherit system; config.allowUnfree = true; };
      pkgs-stable = import nixpkgs commonArgs;
      pkgs-unstable = import nixpkgs-unstable commonArgs;
      username = "coldbrewrosh";
      name = "Rosh";
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          modules = [
            ./configuration.nix
            ./modules/unstable.nix
            ./modules/cli.nix
            ./modules/vim.nix
            # Remember to (git add .) after adding new modules
          ];
          specialArgs = {
            inherit username;
            inherit name;
            inherit pkgs-stable;
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
