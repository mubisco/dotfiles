local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

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
-- nnoremap <leader>sv :source $MYVIMRC<CR>

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
-- keymap("c", "<expr> %%", "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", opts)

-- Telescope
-- keymap("n", "<leader>f", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>", opts)
keymap("n", "<C-t>", "<cmd>Telescope live_grep<CR>", opts)

-- -------------------------------------------------------------------------------
-- nmap <S-F4> :execute "silent grep! -R " . expand("<cword>") . " ./**" <Bar> cw<CR>
-- nnoremap <leader>sv :source $MYVIMRC<CR>
-- inoremap <Leader>rt :RemoveTrail<CR>
-- cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
-- " Include use statement
-- nmap <Leader>u :call phpactor#UseAdd()<CR>

-- " Invoke the context menu
-- nmap <Leader>mm :call phpactor#ContextMenu()<CR>

-- " Invoke the navigation menu
-- nmap <Leader>nn :call phpactor#Navigate()<CR>

-- " Goto definition of class or class member under the cursor
-- nmap <Leader>o :call phpactor#GotoDefinition()<CR>

-- " Show brief information about the symbol under the cursor
-- nmap <Leader>K :call phpactor#Hover()<CR>

-- " Transform the classes in the current file
-- nmap <Leader>tt :call phpactor#Transform()<CR>

-- " Generate a new class (replacing the current file)
-- nmap <Leader>cc :call phpactor#ClassNew()<CR>

-- " Extract expression (normal mode)
-- nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>

-- " Extract expression from selection
-- vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>

-- " Extract method from selection
-- vmap <silent><Leader>eem :<C-U>call phpactor#ExtractMethod()<CR>
-- " Extract constant from selection
-- vmap <silent><Leader>eec :<C-U>call phpactor#ExtractConstant()<CR>

-- " Shortcut for :Files command
-- nmap <Leader>f :Files<CR>
-- "nmap <Leader>fv :vnew<CR>:Files<CR>
-- "nmap <Leader>fh :new<CR>:Files<CR>
-- "nmap <Leader>ft :tabnew<CR>:Files<CR>

-- " Shortcut  for ALEFix
-- nmap  <Leader>af :ALEFix

-- " Coc-config {{
-- inoremap <silent><expr> <TAB>
      -- \ coc#pum#visible() ? coc#pum#next(1) :
      -- \ CheckBackspace() ? "\<Tab>" :
      -- \ coc#refresh()
-- inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
-- inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              -- \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
-- inoremap <silent><expr> <c-space> coc#refresh()

