{
  description = "Description for the project";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    disko = {
      url = "github:nix-community/disko";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    haumea = {
      url = "github:nix-community/haumea";
    };
  };

  outputs = inputs @ {
    flake-utils,
    nixpkgs,
    home-manager,
    haumea,
    ...
  }: let
    inherit (nixpkgs.lib) mapAttrs mapAttrs' nameValuePair foldl isFunction isPath;
    inherit (haumea.lib) load loaders transformers;

    importDefault = {
      src,
      inputs ? {},
      loader ? loaders.scoped,
      transformer ? transformers.liftDefault,
    }:
      load {
        inherit src inputs transformer;
      };

    overlays = importDefault {
      src = ./overlays;
      inputs = {
        inherit inputs;
      };
    };

    homeModules = importDefault {
      src = ./modules/home-manager;
      inputs = {
        inherit inputs;
      };
    };

    homeProfiles = importDefault {
      src = ./profiles/home-manager;
      inputs = {
        inherit inputs;
        modules = homeModules;
      };
    };

    nixosModules = importDefault {
      src = ./modules/nixos;
      inputs = {
        inherit inputs;
      };
    };

    nixosProfiles = importDefault {
      src = ./profiles/nixos;
      inputs = {
        inherit inputs;
        modules = nixosModules;
      };
    };
  in {
    lib = {
      inherit importDefault;

      homeManagerConfiguration = {
        pkgs,
        modules ? [],
        extraInputs ? {},
        ...
      }: (home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = builtins.map (m:
          if isPath m
          then
            import m ({
                modules = homeModules;
                profiles = homeProfiles;
              }
              // extraInputs)
          else if isFunction m
          then
            m ({
                modules = homeModules;
                profiles = homeProfiles;
              }
              // extraInputs)
          else m)
        modules;
      });
    };
  };
}
