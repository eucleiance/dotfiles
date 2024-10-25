{ config, pkgs-stable, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages =
    (with pkgs-stable; [
      pkg-config
      #libdbus
      gcc
      libcxx
    ])
    ++
    (with pkgs-unstable; [

    ]);
}
