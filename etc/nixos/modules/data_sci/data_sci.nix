{ config, pkgs-stable, pkgs-unstable, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs-stable; [
    # Import jupyter_lab_vim from jupyter_lab_vim.nix
    (pkgs-stable.callPackage ./jupyter_lab_vim.nix {
      lib = pkgs-stable.lib;
      buildPythonPackage = pkgs-stable.python311Packages.buildPythonPackage; # Updated here
      fetchPypi = pkgs-stable.python311Packages.fetchPypi; # Updated here
      jupyterlab = pkgs-stable.python311Packages.jupyterlab; # Updated here
    })

    # Python 3.11 packages with system-wide installation
    (pkgs-stable.python311.withPackages (ps: with ps; [
      pip
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
    # Add any additional packages from pkgs-unstable here
  ]);
}
