---@type LazyPluginSpec
return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    require("luasnip.loaders.from_lua").lazy_load()
    local function load_local_snips()
      require("luasnip.loaders.from_lua").load({
        paths = { vim.fn.getcwd() },
      })
    end
    -- declare a LoadSnips command to load from current directory
    vim.api.nvim_create_user_command("LoadSnips", load_local_snips, {
      desc = "Load LuaSnip snippets from current working directory",
      register = true,
    })

    vim.api.nvim_create_autocmd("DirChanged", {
      callback = load_local_snips,
    })
  end,
}
