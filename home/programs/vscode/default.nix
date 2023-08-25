{ config, pkgs, lib, ... }:
{
	programs.vscode = {
		enable = true;
		package = pkgs.vscode;
		enableUpdateCheck = false;
		mutableExtensionsDir = false;
		userSettings = lib.importJSON ./settings.json;
		keybindings = lib.importJSON ./keybindings.json;
		extensions = with pkgs.vscode-extensions; [
			alefragnani.project-manager
			bbenoist.nix
			enkia.tokyo-night
			ibm.output-colorizer
			kamikillerto.vscode-colorize
			ms-dotnettools.csharp
			ms-vscode-remote.remote-ssh
			usernamehw.errorlens
			vscode-icons-team.vscode-icons
			vscodevim.vim
		] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
			{
				name = "vscode-todo-highlight";
				publisher = "wayou";
				version = "1.0.5";
				sha256 = "CQVtMdt/fZcNIbH/KybJixnLqCsz5iF1U0k+GfL65Ok=";
			}
			{
				name = "remote-explorer";
				publisher = "ms-vscode";
				version = "0.4.1";
				sha256 = "E0QsXIpCUjpoX6GNtzbI8/UzxTwWMpQpzVvsPhA+3t4=";
			}
			{
				name = "remote-ssh-edit";
				publisher = "ms-vscode-remote";
				version = "0.86.0";
				sha256 = "JsbaoIekUo2nKCu+fNbGlh5d1Tt/QJGUuXUGP04TsDI=";
			}
		];
	};
}
