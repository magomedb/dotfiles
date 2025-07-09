local function executable_exists(cmd)
  return vim.fn.executable(cmd) == 1
end

-- Notify if lua-language-server is missing
if not executable_exists("lua-language-server") then
  vim.schedule(function()
    vim.notify(
      "[LSP] Warning: 'lua-language-server' not found in PATH.\n" ..
      "Install it from https://github.com/LuaLS/lua-language-server/releases",
      vim.log.levels.WARN
    )
  end)
end

-- Notify if clangd is missing
if not executable_exists("clangd") then
  vim.schedule(function()
    vim.notify(
      "[LSP] Warning: 'clangd' not found in PATH.\n" ..
      "Install it via your system package manager (e.g. apt, brew, pacman).",
      vim.log.levels.WARN
    )
  end)
end

-- Common on_attach behavior
local function setup_buffer(bufnr)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })

  -- Tab completion with <Tab> and <S-Tab>
  vim.api.nvim_buf_set_keymap(bufnr, "i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, "i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<C-h>"]], { expr = true, noremap = true })
end

-- Lua LSP
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    if not executable_exists("lua-language-server") then return end
    local bufnr = vim.api.nvim_get_current_buf()

    vim.lsp.start({
      name = "lua-language-server",
      cmd = { "lua-language-server" },
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
    })

    setup_buffer(bufnr)
  end,
})

-- C/C++ (clangd)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    if not executable_exists("clangd") then return end
    local bufnr = vim.api.nvim_get_current_buf()

    vim.lsp.start({
      name = "clangd",
      cmd = { "clangd" },
      root_dir = vim.fs.dirname(
        vim.fs.find({ ".clangd", ".git" }, { upward = true })[1]
      ),
    })

    setup_buffer(bufnr)
  end,
})

-- LSP diagnostics config
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})
