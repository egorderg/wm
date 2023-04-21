local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end

  return false
end

ensure_packer()
local packer = require('packer')

packer.init {
	max_jobs = 10,
}

return packer.startup(function(use)
	-- Neovim helper function libary, required for some plugins
	use 'nvim-lua/plenary.nvim'

	-- Themes
	use 'folke/tokyonight.nvim'

	-- Common devicons
	use {
		'nvim-tree/nvim-web-devicons',
		config = function()
			require('config.icons')
		end
	}

	-- Comment/Uncomment
	use {
    'numToStr/Comment.nvim',
		config = function ()
			require('Comment').setup()
		end
	}

	-- Autopairs
	use {
		"windwp/nvim-autopairs",
		config = function()
			require("config.autopairs")
		end
	}

	-- Fuzzy finder
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
		config = function ()
			require('config.telescope')
		end
	}

	-- Statusbar
	use {
		'nvim-lualine/lualine.nvim',
		config = function()
			require('config.lualine')
		end
	}

end)

