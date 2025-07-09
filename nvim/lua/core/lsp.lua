local function executable_exists(cmd)
    return vim.fn.executable(cmd) == 1
end

-- Warn if language servers are missing
if not executable_exists("lua-language-server") then
    vim.schedule(function()
        vim.notify(
            "[LSP] Warning: 'lua-language-server' executable not found in PATH.\n" ..
            "Install it from https://github.com/LuaLS/lua-language-server/releases",
            vim.log.levels.WARN
        )
    end)
end

if not executable_exists("clangd") then
    vim.schedule(function()
        vim.notify(
            "[LSP] Warning: 'clangd' (C/C++ language server) not found in PATH.\n" ..
            "Install it using your package manager, e.g., 'sudo apt install clangd'",
            vim.log.levels.WARN
        )
    end)
end

-- Shared on_attach logic
local function on_attach(bufnr)
    -- Enable LSP completion
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Tab completion (without plugins)
    vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]],
        { expr = true, noremap = true, buffer = bufnr })
    vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<C-h>"]],
        { expr = true, noremap = true, buffer = bufnr })

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ async = false })
        end,
    })
end

-- Lua setup
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function(args)
        if not executable_exists("lua-language-server") then return end

        vim.lsp.start({
            name = "lua-language-server",
            cmd = { "lua-language-server" },
            filetypes = { "lua" },
            root_dir = vim.fs.dirname(
                vim.fs.find({ ".luarc.json", ".luarc.jsonc", ".git" }, { upward = true })[1]
            ),
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
            on_attach = on_attach,
        })
    end,
})

-- C setup
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function(args)
        if not executable_exists("clangd") then return end

        vim.lsp.start({
            name = "clangd",
            cmd = { "clangd" },
            filetypes = { "c", "cpp" },
            root_dir = vim.fs.dirname(
                vim.fs.find({ "compile_commands.json", ".git" }, { upward = true })[1]
            ),
            on_attach = on_attach,
        })
    end,
})

-- Global diagnostics config
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
})
