let
  nixpkgs = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs";
    ref = "master";
    rev = "b7ddbd52bd1ab9365436573c0c5b6d1edcc1919f";
  };
in
with import nixpkgs {};
stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    pandoc
    python3
    python3Packages.jinja2
    python3Packages.pyyaml
    (texlive.combine {
      inherit (texlive)
        luatex
        scheme-small
        collection-latexextra
        collection-fontsrecommended
        fontawesome
      ;
    })
  ];
}
