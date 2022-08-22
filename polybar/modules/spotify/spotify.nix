{ lib, python3Packages }:

with python3Packages;

buildPythonApplication {
  pname = "polybar-spotify-status";
  version = "1.0";

  propagatedBuildInputs = [ dbus-python ];

  src = ./.;
}
