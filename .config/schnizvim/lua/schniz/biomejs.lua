---@param bufnr number
---@return boolean
local function is_biome_project(bufnr)
  local biome_json = vim.fs.find({ "biome.json", "biome.jsonc" }, {
    upward = true,
    stop = vim.loop.os_homedir(),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })[1]

  return biome_json ~= nil
end

return {
  is_biome_project = is_biome_project,
}
