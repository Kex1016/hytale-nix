{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      version = "2026.01.10-5fdaa5c";
      hytale-launcher-bin = pkgs.fetchzip {
        url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-${version}.zip";
        sha256 = "sha256-cnFgrn4YW4SuAvmlPfuW0lGXziFat61W+tj1LoQbsOQ=";
      };

      libraries =
        p: with p; [
          libsoup_3
          gdk-pixbuf
          glib
          gtk3
          webkitgtk_4_1
        ];
    in
    {
      packages.x86_64-linux.hytale-launcher = pkgs.stdenv.mkDerivation {
        pname = "hytale-launcher";
        inherit version;

        src = hytale-launcher-bin;

        nativeBuildInputs = [ pkgs.autoPatchelfHook ];

        buildInputs = libraries pkgs;

        installPhase = ''
          mkdir -p $out/bin
          cp hytale-launcher $out/bin/
        '';
      };

      packages.x86_64-linux.hytale-launcher-fhs = pkgs.buildFHSEnv {
        pname = "hytale-launcher";
        inherit version;

        targetPkgs = p: libraries p;
        runScript = "${hytale-launcher-bin}/hytale-launcher";
      };
    };
}
