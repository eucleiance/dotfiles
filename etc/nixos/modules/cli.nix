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
      # Sym Links
      stow

      # For Gifs -> Gifski is better
      gifsicle
      gifski

      # Move to Trash
      trashy

      # System Monitoring
      # npm -> vtop
      gotop
    ])
    ++
    (with pkgs-unstable; [

    ]);
}
