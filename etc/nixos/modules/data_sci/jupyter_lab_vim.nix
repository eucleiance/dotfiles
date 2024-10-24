{ lib, buildPythonPackage, fetchPypi, jupyterlab }:

buildPythonPackage rec {
  pname = "jupyterlab_vim";
  version = "4.1.4";  # Use the latest version

  src = fetchPypi {
    inherit pname version;
    sha256 = "abf2891aafb32f0cb94ad98321ae7ebcbe0cabe523d38d80d569c0a50b85225a";  # Replace with correct hash
  };

  propagatedBuildInputs = [ jupyterlab ];

  meta = with lib; {
    description = "Vim bindings for JupyterLab";
    homepage = "https://github.com/jwkvam/jupyterlab-vim";
    license = licenses.mit;
  };
}
