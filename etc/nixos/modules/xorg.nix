{ config, pkgs-stable, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages =
    (with pkgs-stable; [
      # Clipboard
      xclip
      # Wallpaper
      feh
      # Theming
      lxappearance
      picom

      # App Launcher
      dmenu
      # Bar
      polybar

      i3lock
      i3status
      i3blocks
    ])
    ++
    (with pkgs-unstable; [

    ]);

}
