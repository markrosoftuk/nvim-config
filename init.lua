	local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
	vim.api.nvim_create_autocmd(
		"BufWritePost",
		{ command = "source <afile> | PackerCompile", group = packer_group, pattern = "init.lua" }
	)

-- PLUGINS
 require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'justinmk/vim-sneak'
	use 'unblevable/quick-scope'
	use 'nvim-lua/plenary.nvim' 
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-telescope/telescope.nvim'
	use "nvim-telescope/telescope-file-browser.nvim"
	use 'nvim-lualine/lualine.nvim'
	use 'kyazdani42/nvim-web-devicons'
	use 'windwp/nvim-autopairs'
	use 'alvan/vim-closetag'
	use 'p00f/nvim-ts-rainbow'
	use 'akinsho/bufferline.nvim'
	use { 'kylechui/nvim-surround', tag = "*" }
	use 'numToStr/Comment.nvim'
	use 'mattn/emmet-vim'
	use 'VDuchauffour/neodark.nvim'
	use 'romainl/vim-cool'
	use 'ojroques/vim-oscyank'
 end)


------ THEMES ------
require("neodark").setup({
  theme_style = "neodarker"
})

-- SET OPTIONS
vim.o.mouse = ""
vim.o.background = "dark"
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.g.mapleader = " "
vim.g['sneak#label'] = 1
vim.g.closetag_filenames = '*.html,*.php'
vim.g.closetag_filetypes = 'html,php'
vim.g.php_sql_query = 1
vim.g.php_htmlInStrings = 1
vim.opt.termguicolors = true
vim.cmd([[ autocmd FileType * highlight rainbowcol1 guifg=#FCD066 ]]) -- Fix incorrect initial tag color
vim.g.CoolTotalMatches = 1
vim.g.user_emmet_leader_key = ','
vim.cmd([[hi SneakLabel cterm=bold ctermfg=15 ctermbg=201 gui=bold guifg=white guibg=#ABABAB]]) -- change sneak highlight to something less bright
vim.g.emmet_html5 = 1
vim.cmd([[set ignorecase]])
vim.cmd([[set smartcase]])
vim.cmd([[let g:sneak#use_ic_scs = 1]])
vim.g["sneak#use_ic_scs"] = true
vim.api.nvim_command([[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif]]) -- copy text to the system clipboard from anywhere using the ANSI OSC52 sequence
-- vim.api.nvim_command([[autocmd CursorMoved * normal! zz]]) -- copy text to the system clipboard from anywhere using the ANSI OSC52 sequence

-- REMAPS
vim.keymap.set("n", "<Leader>pv", "<cmd>Ex<CR>") -- open netrw
vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<cr>") -- open telescope
vim.keymap.set("n", "<Leader>fb", ":Telescope file_browser<cr>") -- open telescope
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("i", "GG", "<ESC>A") -- got to end of line
vim.keymap.set("i", "<C-a>", "<ESC>I") -- go to beginning of line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move whole line down in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv-gv") -- move whole line up in visual mode
vim.keymap.set("n", "<C-j>", "<C-d>zz") -- movie screen down and center
vim.keymap.set("n", "<C-k>", "<C-u>zz") -- move screen up and center
vim.keymap.set("n", "J", "jjzz") -- move cursor down 1 line and center
vim.keymap.set("n", "K", "kkzz") -- move cursor up 1 line and center
vim.keymap.set("x", "<leader>p", "\"_dP")	
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {}) -- next tab
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {}) -- previous tab


-- LOAD PLUGINS
require('lualine').setup {
  options = {
    theme = 'neodark'
  }
}

require("nvim-surround").setup()
require("nvim-autopairs").setup {}

require("nvim-treesitter.configs").setup {
	ensure_installed = {
		"bash",
		"css",
		"make",
		"python",
		"rust",
		"tsx",
		"typescript",
		"yaml",
		"lua",
	},
	-- highlight = { enable = true },
  	autotag = {
    	enable = true,
  	},
  	indent = {
    	enable = false,
  	},
	rainbow = {
    	enable = true,
    	disable = { "html", "cpp" },
    	extended_mode = false,
    	max_file_lines = nil, 
	},
}

require("bufferline").setup{
	  options = {
    mode = "tabs",
--    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true
  },
}

require('telescope').setup{
	    defaults = {
        preview = {
            filesize_hook = function(filepath, bufnr, opts)
                local max_bytes = 10000
                local cmd = {"head", "-c", max_bytes, filepath}
                require('telescope.previewers.utils').job_maker(cmd, bufnr, opts)
            end
        }
    }
}
	
require("telescope").load_extension "file_browser"

require('Comment').setup()

