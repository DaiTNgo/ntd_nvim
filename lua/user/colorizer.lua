require("colorizer").setup({
  --html = { mode = 'background' };
  --'!vim'
  "*", -- Highlight all files, but customize some others.
  css = { rgb_fn = true, css = true, css_fn = true }, -- Enable parsing rgb(...) functions in css.
  html = { names = true }, -- Disable parsing "names" like Blue or Gray
}, { mode = "foreground" })
