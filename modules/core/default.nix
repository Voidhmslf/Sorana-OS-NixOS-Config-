{ ... }:

{
  imports = [
    ./bootloader.nix
    ./network.nix
    ./nvidia.nix
    ./system.nix
    ./user.nix
    ./program.nix
    ./multimedia.nix
    ./displaymanager.nix
    ./printing.nix
  ];
}
