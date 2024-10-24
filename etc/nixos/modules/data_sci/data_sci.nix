{ config, pkgs-stable, pkgs-unstable, ... }:

let
  # Import the package from your custom Nix expression
  jupyterLabVim = pkgs-stable.callPackage ./modules/data_sci/jupyter_lab_vim.nix { };
in
{
  nixpkgs.config.allowUnfree = true;

  # Define system packages
  environment.systemPackages = with pkgs-stable; [
    jupyterLabVim
    (python311.withPackages (ps: with ps; [
      pip
      numpy
      scipy
      jupyterlab
      pandas
      statsmodels
      scikitlearn
      matplotlib
      notebook   # Jupyter Notebook
      ipywidgets
    ]))
  ] ++ (with pkgs-unstable; [
    # Add packages from pkgs-unstable here
  ]);
}
