local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'

Plug 'tpope/vim-surround'

Plug 'sheerun/vim-polyglot'
Plug 'vim-latex/vim-latex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', {tag = '0.1.3'})
Plug 'BurntSushi/ripgrep'

--Plug('neoclide/coc.nvim', {branch = 'release'})

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'windwp/nvim-autopairs'

vim.call('plug#end')

--vim.cmd([[
--let g:seoul256_background = 235
--colo seoul256
--]])
vim.cmd('autocmd vimenter * ++nested colorscheme gruvbox')

-- lsp stuff

require('nvim-autopairs').setup {}

vim.cmd('set updatetime=200')
vim.cmd('set signcolumn=no')
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
      { name = 'ultisnips' },
    }, {
      { name = 'buffer' },
    })
  })

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['pyright'].setup {
    capabilities = capabilities
}
require('lspconfig')['texlab'].setup {
    capabilities = capabilities
}
require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
}

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
    )

-- latex stuff
vim.g.tex_flavor='latex'
vim.g.Tex_FoldedSections='preamble'
vim.g.Tex_ViewRule_pdf='skim'


-- mappings
local map = vim.api.nvim_set_keymap
local options = { noremap = true }
vim.g.mapleader="\\"


map("i", "{<CR>", "{<CR>}<Esc>ko", options)
map("i", "[", "[]<Esc>i", options)
map("i", "(", "()<Esc>i", options)
map("i", "<C-e>", "<C-o>A", options)

vim.cmd([[
map <Leader>c :w<CR><Leader>ll
map <Leader>v :w<CR><Leader>ll<Leader>lv
map <Leader>h :noh<CR>
map <Leader>p <Plug>(pydocstring)
map <Leader>w :w<CR>
map <Leader>q :wq<CR>
map <Leader>ff <cmd>Telescope find_files<cr>
]])

vim.wo.number=true
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.backspace={'indent','eol','start'}

vim.g.python_highlight_space_errors=0


vim.opt.modeline=true

vim.cmd('set statusline=%f%m%r%h\\ [%L]\\ [%{&ff}]\\ %y%=[%p%%]\\ [line:%05l,col:%02v]')

-- Ensures that vim surround doesnt add new lines
vim.g.surround_no_insert_mappings=1


