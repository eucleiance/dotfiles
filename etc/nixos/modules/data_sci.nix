{ config, pkgs-stable, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs-stable; [
    (python311.withPackages (ps: with ps; [
      # pip
      numpy
      scipy
      jupyterlab
      pandas
      statsmodels
      scikitlearn
      matplotlib
      notebook # Jupyter Notebook
      ipywidgets
    ]))
  ] ++ (with pkgs-unstable; [
    # Add packages from pkgs-unstable here
  ]);
}

