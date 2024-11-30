vim.cmd('syntax enable')
vim.opt.clipboard:append('unnamed')

local vim = vim
local Plug = vim.fn['plug#']
vim.opt.termguicolors = true

vim.call('plug#begin')
Plug 'xiyaowong/transparent.nvim'
Plug ('catppuccin/nvim', {as = 'catppuccin'})
Plug ('akinsho/bufferline.nvim', { tag = '*' })
Plug 'nvim-tree/nvim-tree.lua'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/plenary.nvim'
Plug 'goolord/alpha-nvim'
Plug ('nvim-telescope/telescope.nvim', {tag = '0.1.8' })
Plug ('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && npx --yes yarn install' })
Plug 'goolord/alpha-nvim'
Plug 'williamboman/mason.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'RchrdAriza/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'stevearc/oil.nvim'
vim.call('plug#end')

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()


vim.cmd.colorscheme "catppuccin"

local bufferline = require("bufferline").setup{
  options = {
    hover = {
        enabled = true,
        delay = 200,
        reveal = {'close'}
    },
    separator_style = "slant",
  }
}

vim.g.airline_powerline_fonts = 1

local function fd()
  local confirm = vim.fn.confirm("Delete buffer and file?", "&Yes\n&No", 2)

  if confirm == 1 then
    os.remove(vim.fn.expand("%:p")) -- ensure the full file path is provided
    vim.api.nvim_buf_delete(0, { force = true })
  end
end

-- Create the custom command
vim.api.nvim_create_user_command('Fd', fd, {})
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Search", ":cd $HOME | Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent files"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Configuration" , ":e C:\\Users\\loven\\AppData\\local\\nvim\\init.lua"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),

}

local alpha = require("alpha")
require'alpha'.setup(require'alpha.themes.dashboard'.config)
require'lspconfig'.pyright.setup{}
require'lspconfig'.emmet_language_server.setup{}
require'lspconfig'.cssls.setup{}
require("mason-lspconfig").setup()
require("mason").setup()
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
         { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })
  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
    
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  
  require'lspconfig'.cssls.setup {
    capabilities = capabilities,
  }

  require('gitsigns').setup()
