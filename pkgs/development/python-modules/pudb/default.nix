{ lib
, buildPythonPackage
, dataclasses
, isPy3k
, fetchPypi
, jedi
, pygments
, urwid
, urwid-readline
, pytest-mock
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "pudb";
  version = "2022.1.1";
  format = "setuptools";

  disabled = !isPy3k;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-2zvdZkI8nSkHTBwsSfyyJL0Nbwgxn+0bTn6taDkUCD8=";
  };

  propagatedBuildInputs = [
    jedi
    pygments
    urwid
    urwid-readline
  ] ++ lib.optionals (pythonOlder "3.7") [
    dataclasses
  ];

  checkInputs = [
    pytest-mock
    pytestCheckHook
  ];

  preCheck = ''
    export HOME=$TMPDIR
  '';

  pythonImportsCheck = [
    "pudb"
  ];

  meta = with lib; {
    description = "A full-screen, console-based Python debugger";
    homepage = "https://github.com/inducer/pudb";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
