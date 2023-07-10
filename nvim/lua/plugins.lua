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

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- この下にインストールするプラグインを記載します。
    -- 見た目
    use 'folke/tokyonight.nvim'
    use {
        'nvim-lualine/lualine.nvim', 
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use 'nvim-tree/nvim-web-devicons'
    use 'kdheepak/tabline.nvim'
    use 'echasnovski/mini.indentscope'
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
    }
    
    -- brackets 補完 
    use {
		'windwp/nvim-autopairs',
		config = function() require('nvim-autopairs').setup {} end
	}

    -- ファイル検索
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    
    -- ファイルツリー    
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }

    -- Lsp
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    }
    
    -- Cmp
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline' 
    use 'onsails/lspkind.nvim'

    -- Flutter
    use {
       'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
    }

    -- auto save
    use{
    	'Pocco81/auto-save.nvim',
	    config = function()
		    require('auto-save').setup {
                trigger_events = {'InsertLeave', 'BufLeave', 'FocusLost'},               
		    }
	    end,
    }
end)
