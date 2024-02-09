{ config, pkgs, lib, ... }:
{
	programs.vscode = {
		enable = true;
		package = pkgs.vscode;
		enableUpdateCheck = false;
		mutableExtensionsDir = true;
		userSettings = lib.importJSON ./settings.json;
		keybindings = lib.importJSON ./keybindings.json;
		extensions = with pkgs.vscode-extensions; [
			alefragnani.project-manager
			bbenoist.nix
			ms-vscode-remote.remote-ssh
			usernamehw.errorlens
			vscode-icons-team.vscode-icons
			vscodevim.vim
      vadimcn.vscode-lldb
      ms-dotnettools.csharp
      sumneko.lua
		] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
			{
				name = "csharpier-vscode";
				publisher = "csharpier";
				version = "1.5.2";
				sha256 = "A2AGcUF1SQuSPECghArBxx/gi5JiIk7o6wzfgCPcfgI=";
			}
			{
				name = "todo-tree";
				publisher = "gruntfuggly";
				version = "0.0.226";
				sha256 = "Fj9cw+VJ2jkTGUclB1TLvURhzQsaryFQs/+f2RZOLHs=";
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
