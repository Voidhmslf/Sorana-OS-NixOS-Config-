{ pkgs, ... }:

{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "teams-for-linux";
      paths = [ pkgs.teams-for-linux ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/teams-for-linux --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland --disable-features=WaylandFractionalScaleV1"
      '';
    })
  ];
}
