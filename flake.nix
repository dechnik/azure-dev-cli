{
  description = "Flake for Azure Developer CLI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem
      [
        "x86_64-linux"
        "aarch64-linux"
      ]
      (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          azure-dev-cli = pkgs.callPackage ./default.nix { };
        in
        {
          packages = {
            default = azure-dev-cli;
            inherit azure-dev-cli;
          };
          apps = {
            default = {
              type = "app";
              program = "${azure-dev-cli}/bin/azd";
            };
            bicep = {
              type = "app";
              program = "${pkgs.bicep}/bin/bicep";
            };
          };
        }
      );
}
