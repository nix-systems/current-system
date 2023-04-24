{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nuenv.url = "github:DeterminateSystems/nuenv";
  };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      perSystem = { pkgs, lib, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ inputs.nuenv.overlays.nuenv ];
        };
        packages.default = pkgs.nuenv.mkScript {
          name = "current-system";
          script = ''
            let system = $"($nu.os-info.arch)-($nu.os-info.name | str replace macos darwin)"

            def current-system [] {
              $system
            }

            # Return the Nix system for current system architecture.
            def main [
              --json # Whether to return json
              ] {
              if $json {
                current-system | to json
              } else {
                current-system
              }
            }
          '';
        };
      };
    };
}

