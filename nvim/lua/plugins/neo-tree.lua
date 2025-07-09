return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,  -- load at startup (or change to true for lazy loading)
  keys = {
    { "\\", ":Neotree toggle<CR>", desc = "NeoTree toggle", silent = true },
  },
  opts = {
    -- your neo-tree options here, or leave empty
  },
  config = function(_, opts)
    require("nvim-web-devicons").setup()
    require("neo-tree").setup(opts)
  end,
}

