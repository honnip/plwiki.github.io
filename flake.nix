{
  description = "plwiki";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      packages.x86_64-linux.default = pkgs.callPackage ./plwiki.nix { };
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          (ghc.withPackages (
            hpkgs: with hpkgs; [
              pandoc
              blaze-html
              shakespeare
              optparse-applicative
              shake
            ]
          ))
          nodejs_22
          nodePackages.mathjax
          nodePackages.serve
        ];
      };
    };
}
