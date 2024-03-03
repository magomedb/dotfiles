return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = {
        view = {
            adaptive_size = true,
            float = {
                enable = true
            }
        },
        actions = {
            open_file = {
                quit_on_open = true
            }
        }
    }
}
