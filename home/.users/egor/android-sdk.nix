{ config, pkgs, lib, ... }:
let
	androidComposition = pkgs.androidenv.composeAndroidPackages {
		cmdLineToolsVersion = "11.0";
    toolsVersion = "26.1.1";
    platformToolsVersion = "33.0.3";
    buildToolsVersions = [ "33.0.2" ];
    includeEmulator = false;
    platformVersions = [ "33" ];
    includeSources = false;
    includeSystemImages = false;
    systemImageTypes = [ "google_apis_playstore" ];
    abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
    cmakeVersions = [ "3.10.2" ];
    includeNDK = true;
    ndkVersions = ["23.2.8568313"];
    useGoogleAPIs = false;
    useGoogleTVAddOns = false;
    includeExtras = [
      "extras;google;gcm"
    ];
	};
in
{
	home.packages = [
		androidComposition.androidsdk
	];

	home.sessionVariables = {
    ANDROID_HOME = "${androidComposition.androidsdk}/libexec/android-sdk";
	};
}