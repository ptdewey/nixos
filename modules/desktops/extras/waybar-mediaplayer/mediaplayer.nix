# Sourced from `https://github.com/nomisreual/mediaplayer`
{ pkgs }:

pkgs.python3Packages.buildPythonApplication {
  pname = "mediaplayer";
  version = "0.1.0";

  propagatedBuildInputs = with pkgs.python3Packages; [
    pygobject3
  ];

  pyproject = true;
  build-system = [pkgs.python313Packages.setuptools];

  buildInputs = with pkgs; [
    gobject-introspection
    playerctl
    glib
    wrapGAppsHook3
  ];

  src = ./.;

  dontWrapGApps = true;

  preFixup = ''
    gappsWrapperArgs+=(
      --prefix GI_TYPELIB_PATH : "${pkgs.playerctl}/lib/girepository-1.0"
    )
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';
}
