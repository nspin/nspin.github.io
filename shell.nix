with import <nixpkgs> { config = {}; }; stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    lessc
    (haskellPackages.ghcWithPackages (hp: with hp; [
      hakyll
      pandoc
    ]))
  ];
}
