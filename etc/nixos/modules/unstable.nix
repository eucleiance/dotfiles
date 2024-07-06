{ config, pkgs-stable, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages =
    (with pkgs-stable; [
      # List of stable packages (if any)

    ])
    ++
    (with pkgs-unstable; [
      obsidian
      zed-editor
      vscode
    ]);
}
