{
  description = "lastfm-wordcloud - Last.fm wordcloud generator";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python3;
        pythonPackages = python.pkgs;
        pythonEnv = python.withPackages (ps: with ps; [
          pylast
          wordcloud
          matplotlib
          tqdm
        ]);
      in
      {
        packages.default = pythonPackages.buildPythonPackage {
          pname = "lastfm-wordcloud";
          version = "0.1.0";
          pyproject = true;
          src = ./.;
          nativeBuildInputs = [ pythonPackages.hatchling ];
          propagatedBuildInputs = [
            pythonPackages.pylast
            pythonPackages.wordcloud
            pythonPackages.matplotlib
            pythonPackages.tqdm
          ];
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pythonEnv
            pythonPackages.ruff
          ];
        };
      });
}
