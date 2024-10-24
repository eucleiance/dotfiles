{ config, pkgs-stable, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages =
    (with pkgs-stable; [
      # Torrent Client
      qbittorrent
      # Discord w/ Screenshare w/ Audio
      vesktop
      # File Manager
      xfce.thunar
      # Ebook Reader
      foliate
      # Interior Design
      # sweethome3d.application
      # Email Client
      thunderbird
      # Office
      onlyoffice-bin
      # Lightroom
      darktable
      # Digital Art
      krita
      # Maps 
      qgis
    ])
    ++
    (with pkgs-unstable; [

    ]);
}
