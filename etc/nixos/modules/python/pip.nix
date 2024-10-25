{ config, pkgs-stable, pkgs-unstable, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs-stable; [

    # Python 3.11 packages with system-wide installation
    (pkgs-stable.python311.withPackages (ps: with ps; [
      pip
      virtualenv
      # numpy
      # scipy
      # jupyterlab
      # pandas
      # statsmodels
      # scikitlearn
      # matplotlib
      # notebook # Jupyter Notebook
      # ipywidgets
    ]))
  ] ++ (with pkgs-unstable; [
    # Add any additional packages from pkgs-unstable here
  ]);
}
