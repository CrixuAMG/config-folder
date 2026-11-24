local source = debug.getinfo(1, "S").source:sub(2)
local nvim_dir = vim.fs.dirname(vim.fs.dirname(source))

local function load_plugin(name)
    return dofile(vim.fs.joinpath(nvim_dir, "lua", "plugins", name))
end

local function assert_contains(values, expected)
    assert(vim.tbl_contains(values, expected), "Expected list to contain " .. expected)
end

local setup_options
local installed_languages
package.loaded["nvim-treesitter"] = {
    setup = function(opts)
        setup_options = opts
    end,
    install = function(languages)
        installed_languages = languages
    end,
}

local treesitter_spec
for _, spec in ipairs(load_plugin("treesitter.lua")) do
    if spec[1] == "nvim-treesitter/nvim-treesitter" then
        treesitter_spec = spec
        break
    end
end

assert(treesitter_spec, "Missing nvim-treesitter plugin spec")
assert(treesitter_spec.lazy == false, "nvim-treesitter must not be lazy-loaded")
assert(treesitter_spec.build == ":TSUpdate", "nvim-treesitter should update parsers after plugin updates")
treesitter_spec.config()
assert(setup_options, "nvim-treesitter setup was not called")
assert(setup_options.install_dir == vim.fn.stdpath("data") .. "/site", "Unexpected parser install directory")
assert(installed_languages, "Parser installation was not requested")
assert_contains(installed_languages, "go")

local original_start = vim.treesitter.start
local started_buffers = {}
vim.treesitter.start = function(bufnr)
    table.insert(started_buffers, bufnr)
end
vim.api.nvim_exec_autocmds("FileType", { pattern = "go" })
vim.treesitter.start = original_start
assert(started_buffers[1] == vim.api.nvim_get_current_buf(), "Go buffers should start Tree-sitter")

local capabilities = { textDocument = { completion = {} } }
package.loaded["cmp_nvim_lsp"] = {
    default_capabilities = function()
        return capabilities
    end,
}

local lsp_configs = {}
local enabled_servers = {}
local original_lsp_config = vim.lsp.config
local original_lsp_enable = vim.lsp.enable
vim.lsp.config = function(name, config)
    lsp_configs[name] = config
end
vim.lsp.enable = function(name)
    enabled_servers[name] = true
end

local lsp_specs = load_plugin("lsp.lua")
lsp_specs[3].config()
vim.lsp.config = original_lsp_config
vim.lsp.enable = original_lsp_enable

assert(lsp_configs.gopls, "Missing gopls LSP configuration")
assert(lsp_configs.gopls.capabilities == capabilities, "gopls should receive nvim-cmp capabilities")
assert(enabled_servers.gopls, "gopls should be enabled")

local mason_options
package.loaded["mason-lspconfig"] = {
    setup = function(opts)
        mason_options = opts
    end,
}
lsp_specs[2].config()
assert(mason_options, "mason-lspconfig setup was not called")
assert_contains(mason_options.ensure_installed, "gopls")

print("Go support config tests passed")
