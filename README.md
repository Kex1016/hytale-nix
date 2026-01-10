# Hytale Launcher for Nix

Small derivation to run the hytale launcher on nixos without flatpaks.
It can be run with the following command:
```
nix run github:andreashgk/hytale-nix#hytale-launcher-fhs
```

There is also a non-fhs package, but it currently breaks whenever there is an update available:
```
nix run github:andreashgk/hytale-nix#hytale-launcher
```
I'm currently looking into how to disable auto updating.
