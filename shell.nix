with import <nixpkgs> {}; stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    pandoc
    python3
    python3Packages.jinja2
    python3Packages.pyyaml
  ];
}