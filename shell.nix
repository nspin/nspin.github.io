with import <nixpkgs> { config = {}; }; stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    (haskellPackages.ghcWithPackages (hp: with hp; [
      hakyll
      pandoc
    ]))
    pandoc
    python3
    python3Packages.jinja2
  ];
}
