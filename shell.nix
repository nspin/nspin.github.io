let
  nixpkgs = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs";
    ref = "nixos-23.11";
    rev = "01885a071465e223f8f68971f864b15829988504";
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
