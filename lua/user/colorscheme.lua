local groups = {
    all = {
        NormalFloat = {link = "Normal"},
        WhichKeyFloat = {link = "Normal"}
    }
}

require("nightfox").setup({ groups = groups })

vim.cmd [[
try
  colorscheme nordfox
  set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
