{ ... }:

{
  imports = [
    ./bootloader.nix
    ./network.nix
    ./nvidia.nix
    ./sddm.nix
    ./system.nix
    ./user.nix
    ./program.nix
    ./multimedia.nix
  ];
}
