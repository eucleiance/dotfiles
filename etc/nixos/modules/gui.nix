{ config, pkgs-stable, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages =
    (with pkgs-stable; [
      # Torrent Client
      qbittorrent
      # Discord w/ Screenshare w/ Audio
      vesktop
    ])
    ++
    (with pkgs-unstable; [

    ]);
}
