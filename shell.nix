{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = [
    git

    nodePackages.node2nix

    fmjs
  ];
  shellHook = ''
  '';
}
