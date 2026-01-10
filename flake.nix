{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      packages.x86_64-linux.default = self.packages.x86_64-linux.hytale-launcher;
      packages.x86_64-linux.hytale-launcher = pkgs.stdenv.mkDerivation rec {
        pname = "hytale-launcher";
        version = "2026.01.10-980a9ef";

        src = pkgs.fetchzip {
          url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-${version}.zip";
          sha256 = "sha256-kf4TNvtwBb8sF1Sty7wbNzLiQl3McBXiM+2bFWfAT9c=";
        };

        nativeBuildInputs = [ pkgs.autoPatchelfHook ];

        buildInputs = with pkgs; [
          libsoup_3
          gdk-pixbuf
          glib
          gtk3
          webkitgtk_4_1
        ];

        installPhase = ''
          mkdir -p $out/bin
          cp hytale-launcher $out/bin/
        '';
      };
    };
}
