{ stdenv,
  lib,
  autoPatchelfHook,
  makeWrapper,
  fetchurl,
  unzip,
  udev,
	libffi,
	libXxf86vm,
  alsaLib, libXcursor, libXinerama, libXrandr, libXrender, libX11, libXi,
  libpulseaudio, libGL,
	zlib,
	freetype,
	xorg,
	jdk17
}:

let
  editorHash = "39bff6602d092925132d2ea845ac955677a67229";
	engineHash = "d9e9c49ab946c058f29a8b688c862d70f30e9c43";
	mainClass = "com.defold.editor.Main";
	channel = "editor-alpha";
  domain = "d.defold.com";
	buildTime = "2023-10-10T10:44:44.150279";
  resPath = "";
  launcherPath = "";
in

stdenv.mkDerivation rec {
  pname = "defold";
  version = "1.6.0";

  src = fetchurl {
    url = "https://d.defold.com/archive/${channel}/${editorHash}/${channel}/editor2/Defold-x86_64-linux.zip";
    sha256 = "Q8sEPNR9cf0X1PfjnKFT4rFBVxIYYBwHVCSaWlRs/nw=";
  };

  nativeBuildInputs = [autoPatchelfHook makeWrapper unzip];

  buildInputs = [
    udev
		freetype
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
		libXxf86vm
		xorg.libXtst
  ];

  libraries = lib.makeLibraryPath buildInputs;

  unpackCmd = "";
  installPhase = ''
		mkdir -p $out/bin $out/opt/defold

		install -m 444 -D packages/defold-${editorHash}.jar $out/share/defold/defold.jar

		makeWrapper ${jdk17}/bin/java $out/bin/defold \
        --add-flags "-Dfile.encoding=UTF-8" \
				--add-flags "-Djna.nosys=true" \
				--add-flags "-Ddefold.launcherpath=${launcherPath}" \
				--add-flags "-Ddefold.resourcespath=${resPath}" \
				--add-flags "-Ddefold.version=${version}" \
				--add-flags "-Ddefold.editor.sha1=${editorHash}" \
				--add-flags "-Ddefold.engine.sha1=${engineHash}" \
				--add-flags "-Ddefold.buildtime=${buildTime}" \
				--add-flags "-Ddefold.channel=${channel}" \
				--add-flags "-Ddefold.archive.domain=${domain}" \
				--add-flags "-Djava.net.preferIPv4Stack=true" \
				--add-flags "-Dsun.net.client.defaultConnectTimeout=30000" \
				--add-flags "-Dsun.net.client.defaultReadTimeout=30000" \
				--add-flags "-Djogl.texture.notexrect=true" \
				--add-flags "-Dglass.accessible.force=false" \
				--add-flags "--add-opens=java.base/java.lang=ALL-UNNAMED" \
				--add-flags "--add-opens=java.desktop/sun.awt=ALL-UNNAMED" \
				--add-flags "--add-opens=java.desktop/sun.java2d.opengl=ALL-UNNAMED" \
				--add-flags "--add-opens=java.xml/com.sun.org.apache.xerces.internal.jaxp=ALL-UNNAMED" \
				--add-flags "--add-opens=java.base/sun.nio.fs=ALL-UNNAMED" \
				--add-flags "--add-opens=java.desktop/sun.awt.image=ALL-UNNAMED" \
        --add-flags "-jar $out/share/defold/defold.jar -cp ${mainClass}"
  '';

  postFixup = ''
		wrapProgram $out/bin/defold \
      --set LD_LIBRARY_PATH ${libraries}
  '';

  meta = {
    homepage    = "https://defold.com/";
    description = "The game engine for high-performance cross-platform games";
    license     = lib.licenses.mit;
    platforms   = [ "x86_64-linux" ];
  };
}
