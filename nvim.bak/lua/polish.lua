-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Transparent background configuration
vim.cmd [[
colorscheme wildcharm
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight EndOfBuffer guibg=NONE ctermbg=NONE
highlight EndOfBuffer guifg=NONE ctermfg=NONE
set pumblend=1000  " Adjust as needed for popup transparency
highlight VertSplit guibg=NONE
highlight SignColumn guibg=NONE
]]
