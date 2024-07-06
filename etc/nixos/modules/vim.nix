{ config, pkgs-stable, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages =
    (with pkgs-stable; [
      # List of stable packages (if any)
      #vimPlugins.coc-tailwindcss
      vscodium-fhs
      vscode-fhs
    ])
    ++
    (with pkgs-unstable; [
    ]);
}
