{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      version = "2026.09.15-261d405";
      hytale-launcher-bin = pkgs.fetchzip {
        url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-2026.09.15-261d405.zip";
        sha256 = "sha256-bH5iVP0ElNRYOoOdG0K/8q4LtDDINDQqVDYuK66Uxf0=";
      };
    in
    {
      packages.x86_64-linux.default = self.packages.x86_64-linux.hytale-launcher;

      packages.x86_64-linux.hytale-launcher = pkgs.buildFHSEnv {
        pname = "hytale-launcher";
        inherit version;

        targetPkgs =
          p: with p; [
            libsoup_3
            gdk-pixbuf
            glib
            gtk3
            webkitgtk_4_1
          ];
        runScript = "${hytale-launcher-bin}/hytale-launcher";
      };
    };
}

