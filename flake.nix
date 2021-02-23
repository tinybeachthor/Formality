{
  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
    tinybeachthor = {
      url = github:tinybeachthor/nur-packages/master;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, flake-utils, nixpkgs, tinybeachthor }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        fmjs = (import ./nix/default.nix { inherit pkgs system; }).package;
        pkgs = (import nixpkgs {
          inherit system;
          overlays = [
            tinybeachthor.overlay
            (self: super: { inherit fmjs; })
          ];
        });
      in {
        devShell = import ./shell.nix { inherit pkgs; };
        defaultPackage = fmjs;
      });
}
