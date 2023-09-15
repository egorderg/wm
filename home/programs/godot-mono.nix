# https://github.com/sgillespie/nixos-godot-bin
{ stdenv,
  lib,
  autoPatchelfHook,
  makeWrapper,
  fetchurl,
  unzip,
  udev,
  alsaLib, libXcursor, libXinerama, libXrandr, libXrender, libX11, libXi,
  libpulseaudio, libGL,
	msbuild,
	dotnetPackages,
	mono5,
	zlib
}:

let
  qualifier = "stable";
in

stdenv.mkDerivation rec {
  pname = "godot-mono-bin";
  version = "3.5.1";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${version}/mono/Godot_v${version}-${qualifier}_mono_x11_64.zip";
    sha256 = "7phG4vgq4m0h92gCMPv5kehQQ1BH7rS1c5VZ6Dx3WPc=";
  };

  nativeBuildInputs = [autoPatchelfHook makeWrapper unzip];

  buildInputs = [
    udev
    alsaLib
    libXcursor
    libXinerama
    libXrandr
    libXrender
    libX11
    libXi
    libpulseaudio
    libGL
		zlib
  ];

  libraries = lib.makeLibraryPath buildInputs;

  unpackCmd = "";
  installPhase = ''
		mkdir -p $out/bin $out/opt/godot-mono

    install -m 0755 Godot_v${version}-${qualifier}_mono_x11.64 $out/opt/godot-mono/Godot_v${version}-${qualifier}_mono_x11.64
    cp -r GodotSharp $out/opt/godot-mono

    ln -s $out/opt/godot-mono/Godot_v${version}-${qualifier}_mono_x11.64 $out/bin/godot-mono
  '';

  postFixup = ''
		wrapProgram $out/bin/godot-mono \
      --set LD_LIBRARY_PATH ${libraries}
  '';

  meta = {
    homepage    = "https://godotengine.org";
    description = "Free and Open Source 2D and 3D game engine";
    license     = lib.licenses.mit;
    platforms   = [ "i686-linux" "x86_64-linux" ];
    maintainers = [ lib.maintainers.twey ];
  };
}
