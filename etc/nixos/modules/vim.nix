{ config, pkgs-stable, pkgs-code, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages =
    (with pkgs-code; [
      # List of stable packages (if any)
      #vimPlugins.coc-tailwindcss
      vscodium-fhs
      vscode-fhs
    ])
    ++
    (with pkgs-unstable; [
    ]);
}
