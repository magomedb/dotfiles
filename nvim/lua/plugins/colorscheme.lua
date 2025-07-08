return {
  "luisiacc/gruvbox-baby",
  lazy = false, -- load it immediately so you can set the colorscheme right away
  priority = 1000, -- make sure it loads before others if you have conflicting colorschemes
  config = function()
    vim.cmd.colorscheme("gruvbox-baby")
  end,
}
