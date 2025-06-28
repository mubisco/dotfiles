local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<S-h>", "<C-w>h", opts)
keymap("n", "<S-j>", "<C-w>j", opts)
keymap("n", "<S-k>", "<C-w>k", opts)
keymap("n", "<S-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<C-j>", ":bnext<CR>", opts)
keymap("n", "<C-k>", ":bprevious<CR>", opts)
keymap("n", "<C-h>", "gT", opts)
keymap("n", "<C-l>", "gt", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Reload nvim config
keymap("n", "<Leader>sv", ":source $MYVIMRC<CR>", opts)

-- Edit snippets
keymap("n", "<Leader>se", ":lua require('luasnip.loaders').edit_snippet_files()<CR>", opts)

-- Insert --
-- Press jk fast to exit insert mode 
keymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Command
-- Expand current folder
keymap("c", "%%", [[getcmdtype() == ':' ? expand('%:h').'/' : '%%']], { noremap = true, silent = false, expr = true })

-- Telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files<CR>", opts)
-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>", opts)
keymap("n", "<C-t>", "<cmd>Telescope live_grep<CR>", opts)

-- NvimTree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- ToggleTerm
keymap("n", "<F12>", ":ToggleTerm <CR>", opts)
keymap("n", "<leader>g", ":lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Neotest
keymap("n", "<leader>tr", "<cmd>TextCaseOpenTelescope<cr>", opts)
keymap("n", "<leader>to", "<esc><cmd>lua require('neotest').output_panel.open()<cr>", opts)
keymap("n", "<leader>tc", "<esc><cmd>lua require('neotest').output_panel.close()<cr>", opts)
keymap("n", "<leader>te", "<esc><cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", opts)
keymap("n", "<leader>tm", "<esc><cmd>lua require('neotest').run.run()<cr>", opts)
-- To test a directory run lua require("neotest").run.run("path/to/directory")
-- To test the full test suite run lua require("neotest").run.run({ suite = true })

-- Phpactor
-- keymap("n", "<leader>cc", ":call phpactor#ClassNew()<CR>", opts) -- Generate a new class (replacing the current file)
keymap("n", "<leader>u", ":call phpactor#UseAdd()<CR>", opts) -- Include use statement
keymap("n", "<leader>mm", ":call phpactor#ContextMenu()<CR>", opts) -- Invoke the context menu
keymap("n", "<leader>nn", ":call phpactor#Navigate()<CR>", opts) -- Invoke the navigation menu
-- keymap("n", "<leader>o", ":call phpactor#GotoDefinition()<CR>", opts) -- Goto definition of class or class member under the cursor
-- keymap("n", "<leader>ov", "<cmd>PhpactorGotoDefinition vsplit<CR>", opts) -- Goto definition in vertical split
-- keymap("n", "<leader>oh", "<cmd>PhpactorGotoDefinition split<CR>", opts) -- Goto definition in horizontal split
-- keymap("n", "<leader>ff", ":call phpactor#FindReferences()<CR>", opts) -- Extract expression (normal mode)
-- keymap("n", "<leader>im", ":call phpactor#GotoImplementations()<CR>", opts)
-- keymap("n", "<leader>k", ":call phpactor#Hover()<CR>", opts) -- Show brief information about the symbol under the cursor
-- keymap("n", "<leader>tt", ":call phpactor#Transform()<CR>", opts) -- Transform the classes in the current file
keymap("n", "<leader>ee", ":call phpactor#ExtractExpression()<CR>", opts) -- Extract expression (normal mode)
keymap("v", "<leader>ee", ":call phpactor#ExtractExpression(v:true)<CR>", opts) -- Extract expression (visual mode)
keymap("v", "<leader>em", ":call <C-u>PhpactorExtractMethod<CR>", opts) -- Extract method (visual mode)
keymap("v", "<leader>ec", ":call <C-u>PhpactorExtractConstant<CR>", opts) -- Extract method (visual mode)

-- -------------------------------------------------------------------------------
-- nmap <S-F4> :execute "silent grep! -R " . expand("<cword>") . " ./**" <Bar> cw<CR>
-- inoremap <Leader>rt :RemoveTrail<CR>
-- cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

-- " Shortcut for :Files command
-- nmap <Leader>f :Files<CR>
-- "nmap <Leader>fv :vnew<CR>:Files<CR>
-- "nmap <Leader>fh :new<CR>:Files<CR>
-- "nmap <Leader>ft :tabnew<CR>:Files<CR>
--
-- Rest Nvim
-- keymap("n", "<leader>rr", "<cmd>lua require('rest-nvim').run()<cr>", opts)
-- keymap("n", "<leader>rl", "<cmd>lua require('rest-nvim').last()<cr>", opts)
-- keymap("n", "<leader>rt", "<cmd>lua require('rest-nvim').run(true)<cr>", opts)

-- LSP
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
