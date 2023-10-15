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
	zlib,
	fontconfig,
	libxkbcommon,
	xorg,
	dbus
}:

let
  qualifier = "4.2-beta1";
in

stdenv.mkDerivation rec {
  pname = "godot-mono-bin";
  version = "4.2";

  src = fetchurl {
		url = "https://github.com/godotengine/godot-builds/releases/download/${qualifier}/Godot_v${qualifier}_mono_linux_x86_64.zip";
    sha256 = "U0V/89ik+gHipEt5g30KO4gwC200Dvcqmpi+FJ5qUv0=";
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
		fontconfig
		libxkbcommon
		xorg.libXext
		dbus.lib
  ];

  libraries = lib.makeLibraryPath buildInputs;

  unpackCmd = "";
  installPhase = ''
		mkdir -p $out/bin $out/opt/godot-mono

    install -m 0755 Godot_v${qualifier}_mono_linux.x86_64 $out/opt/godot-mono/Godot_v${qualifier}_mono_linux.x86_64
    cp -r GodotSharp $out/opt/godot-mono

    ln -s $out/opt/godot-mono/Godot_v${qualifier}_mono_linux.x86_64 $out/bin/godot
  '';

  postFixup = ''
		wrapProgram $out/bin/godot \
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
