{ config, pkgs-stable, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages =
    (with pkgs-stable; [
      zoxide
      fzf
      bat
      ripgrep
      tree
      stow

    ])
    ++
    (with pkgs-unstable; [

    ]);
}
