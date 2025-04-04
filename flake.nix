{
  description = "Starter Configuration for MacOS and NixOS";

  inputs = {
    # Nixpkgs
    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # Unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Stable
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
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

    agenix.url = "github:ryantm/agenix";
    secrets = {
      url = "git+ssh://git@github.com/ClearAspect/nix-secrets.git";
      flake = false;
    };

    # Best Terminal Emulator
    # ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";
    ghostty.url = "github:ghostty-org/ghostty";

    # Nightly Zig
    zig.url = "github:mitchellh/zig-overlay";

    # Apple fonts
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

    # Grub theme
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";

    # Anyrun (Wayland)
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    nix-homebrew,
    home-manager,
    homebrew-bundle,
    homebrew-core,
    homebrew-cask,
    disko,
    agenix,
    secrets,
    ghostty,
    zig,
    apple-fonts,
    distro-grub-themes,
    anyrun,
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

    # Darwin Configuration
    darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (
      system: let
        user = "roanm";
      in
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            # Overlays
            {
              nixpkgs.overlays = [
                # Zig
                zig.overlays.default
              ];
            }

            # Agenix
            agenix.darwinModules.default

            # Home Manager
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                backupFileExtension = "backup";
                useGlobalPkgs = true;
                users.${user} = {
                  imports = [
                    ./modules/darwin/home-manager.nix
                  ];
                };
              };
            }

            # Nix Homebrew
            nix-homebrew.darwinModules.nix-homebrew
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

    # NixOS Configuration
    nixosConfigurations = nixpkgs.lib.genAttrs linuxSystems (system:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          # Overlays
          {
            nixpkgs.overlays = [
              # Zig
              zig.overlays.default

              # Apple Fonts
              (final: prev: {
                inherit
                  (apple-fonts.packages.${system})
                  sf-pro
                  ;
              })
            ];
          }

          # Agenix
          agenix.darwinModules.default

          # Disko
          disko.nixosModules.disko

          # Grub Theme
          distro-grub-themes.nixosModules.${system}.default

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              extraSpecialArgs = {inherit inputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user} = {
                imports = [
                  ./modules/nixos/home-manager.nix
                  anyrun.homeManagerModules.default
                ];
              };
            };
          }
          ./hosts/nixos
        ];
      });
  };
}
