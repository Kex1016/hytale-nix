{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      version = "2026.11.16-1726018";
      hytale-launcher-bin = pkgs.fetchzip {
        url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-2026.11.16-1726018.zip";
        sha256 = "sha256-JDQeUKnj7jf/z2iUO7kk3I0K8YBx+j/eVdJ1WprdVP4=";
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

