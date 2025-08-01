{ config, pkgs-stable, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages =
    (with pkgs-stable; [
      # Torrent Client
      qbittorrent
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
      # video players
      mpv
      # Free Live IPTV
      hypnotix
      # PDF actions
      stirling-pdf
      # Sound Recorder
      gnome-sound-recorder
    ])
    ++
    (with pkgs-unstable; [
      # Discord w/ Screenshare w/ Audio
      vesktop
      # YT Music
      ytmdesktop
    ]);
}
