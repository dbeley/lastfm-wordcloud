with import <nixpkgs> { };

pkgs.mkShell {
  buildInputs = [
    pkgs.python3

    python3Packages.pylast
    python3Packages.tqdm
    python3Packages.wordcloud
    python3Packages.black
  ];

}
