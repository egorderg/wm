{ config, pkgs, lib, ... }:
let
	qmv = pkgs.writeShellScriptBin "qmv" (builtins.readFile ./qmv.sh);
in {
	home.packages = [
		qmv
	];
}