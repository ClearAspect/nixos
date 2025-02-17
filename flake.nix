{
  description = "Starter Configuration for MacOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/ClearAspect/nix-secrets.git";
      flake = false;
    };

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    # Best Terminal Emulator
    # ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";
    ghostty.url = "github:ghostty-org/ghostty";

    # Best Colour Scheme
    catppuccin.url = "github:catppuccin/nix";

    # Nightly Zig
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = {
    self,
    darwin,
    nix-homebrew,
    homebrew-bundle,
    homebrew-core,
    homebrew-cask,
    home-manager,
    nixpkgs,
    disko,
    agenix,
    secrets,
    ghostty,
    zig,
    catppuccin,
    hyprpanel,
  } @ inputs: let
    user = "roanm";
    linuxSystems = ["x86_64-linux" "aarch64-linux"];
    darwinSystems = ["aarch64-darwin" "x86_64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) f;
    devShell = system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = with pkgs;
        mkShell {
          nativeBuildInputs = with pkgs; [bash git];
          shellHook = with pkgs; ''
            export EDITOR=vim
          '';
        };
    };
    mkApp = scriptName: system: {
      type = "app";
      program = "${(nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
        #!/usr/bin/env bash
        PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
        echo "Running ${scriptName} for ${system}"
        exec ${self}/apps/${system}/${scriptName}
      '')}/bin/${scriptName}";
    };
    mkLinuxApps = system: {
      "apply" = mkApp "apply" system;
      "build-switch" = mkApp "build-switch" system;
      "copy-keys" = mkApp "copy-keys" system;
      "create-keys" = mkApp "create-keys" system;
      "check-keys" = mkApp "check-keys" system;
      "install" = mkApp "install" system;
    };
    mkDarwinApps = system: {
      "apply" = mkApp "apply" system;
      "build" = mkApp "build" system;
      "build-switch" = mkApp "build-switch" system;
      "copy-keys" = mkApp "copy-keys" system;
      "create-keys" = mkApp "create-keys" system;
      "check-keys" = mkApp "check-keys" system;
      "rollback" = mkApp "rollback" system;
    };
  in {
    devShells = forAllSystems devShell;
    apps = nixpkgs.lib.genAttrs linuxSystems mkLinuxApps // nixpkgs.lib.genAttrs darwinSystems mkDarwinApps;

    darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (
      system: let
        user = "roanm";
      in
        darwin.lib.darwinSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            {nixpkgs.overlays = [zig.overlays.default];}
            agenix.darwinModules.default
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              home-manager = {
                useGlobalPkgs = true;
                users.${user} = {
                  imports = [
                    ./modules/darwin/home-manager.nix
                  ];
                };
              };
            }
            {
              nix-homebrew = {
                inherit user;
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./hosts/darwin
          ];
        }
    );

    nixosConfigurations = nixpkgs.lib.genAttrs linuxSystems (system:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          {
            nixpkgs.overlays = [
              zig.overlays.default
              inputs.hyprpanel.overlay
            ];
          }
          agenix.darwinModules.default
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          catppuccin.nixosModules.catppuccin
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user} = {
                imports = [
                  ./modules/nixos/home-manager.nix
                  catppuccin.homeManagerModules.catppuccin
                ];
              };
            };
          }
          ./hosts/nixos
        ];
      });
  };
}
