{ lib, buildPythonPackage, fetchPypi, pkgs ? import <nixpkgs> {} }:

buildPythonPackage rec {
  pname = "jupyterlab_vim";
  version = "4.1.4";  # Use the latest version

  src = fetchPypi {
    inherit pname version;
    sha256 = "abf2891aafb32f0cb94ad98321ae7ebcbe0cabe523d38d80d569c0a50b85225a";  # Replace with the correct hash
  };

  # Override to add a description if required
  overridePythonAttrs = oldAttrs: {
    # Set a static description in pyproject.toml
    preBuild = ''
      echo "description = 'Vim bindings for JupyterLab'" >> pyproject.toml
    '';
  };

  propagatedBuildInputs = [ pkgs.python311Packages.jupyterlab ];

  meta = with lib; {
    description = "Vim bindings for JupyterLab";
    homepage = "https://github.com/jwkvam/jupyterlab-vim";
    license = licenses.mit;
  };
}
