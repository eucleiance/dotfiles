{
  description = "@coldbrewrosh @eucleiance Flake";

  inputs = {
    nixpkgs-code.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-code, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      # pkgs = nixpkgs.legacyPackages.${system};
      # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      commonArgs = { inherit system; config.allowUnfree = true; };
      pkgs-stable = import nixpkgs commonArgs;
      pkgs-code = import nixpkgs-code commonArgs;
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
            ./modules/gui.nix
            ./modules/libs.nix
            ./modules/xorg.nix
            ./modules/audio.nix
            ./modules/rdp.nix
            ./modules/python/pip.nix
            ./modules/data_sci/data_sci.nix
            # ./modules/data_sci/jupyter_lab_vim.nix
            # Remember to (git add .) after adding new modules
          ];
          specialArgs = {
            inherit username;
            inherit name;
            inherit pkgs-stable;
            inherit pkgs-unstable;
            inherit pkgs-code;
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
