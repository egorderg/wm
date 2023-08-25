{ config, pkgs, lib, ... }:
{
	programs.git = {
		enable = true;

		userEmail = "edergunov@proton.me";
		userName = "Egor Dergunov";

		ignores = ["*~" ".direnv" "node_modules"];

		extraConfig = {
			init = {
				defaultBranch = "main";
			};
		};
	};
}