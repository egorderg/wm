{ pkgs, lib, ... }:
{
	programs = {
		fish.enable = true;
	};

	users = {
		users.egor = {
			uid = 1000;
			isNormalUser = true;
			home = "/home/egor";
			description = "Egor";
			shell = pkgs.fish;
			extraGroups = [ "networkmanager" "wheel" "video" "share" ];
		};
	};

	time.timeZone = lib.mkDefault "Europe/Berlin";
	console.keyMap = "us";

	i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      "ro_RO.UTF-8/UTF-8"
    ];
  };

	environment.sessionVariables = {
		FZF_DEFAULT_OPTS = ''--cycle --layout=reverse --border --height=90% --no-separator --no-scrollbar --preview-window=wrap --marker=\"*\" --prompt=\">\"'';
		EDITOR = "vim";
	};

	environment.systemPackages = with pkgs; [
		git
		grc
		fd
		fzf
		ripgrep
		wget
		zip
		unrar
		unzip
		p7zip
    ((vim_configurable.override {  }).customize {
      name = "vim";
      vimrcConfig.customRC = ''
        set encoding=utf8

        set noswapfile
        set clipboard=unnamedplus
        set relativenumber
        set number
        set incsearch
        set hlsearch
        set ignorecase

        set noerrorbells
        set novisualbell
        set t_vb=
        set tm=500

        set expandtab
        set smarttab
        set smartindent
        set shiftwidth=2
        set tabstop=2
        set softtabstop=2

        syntax enable

        let mapleader=" "

        nmap <leader>q <cmd>q<cr>
        nmap <leader>sh <cmd>vsplit<cr>
        nmap <leader>sv <cmd>split<cr>
        nmap <leader>ww <cmd>w<cr>
        nmap <leader>wa <cmd>wa<cr>
        nmap <leader>bc <cmd>bd<cr>
      '';
    })
	];
}
