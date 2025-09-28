return function()
  return require("lsp-progress").progress({
    max_size = 80,
    format = function(messages)
      local active_clients = vim.lsp.get_clients()
      if #messages > 0 then
        return table.concat(messages, " ")
      end
      local client_names = {}
      for _, client in ipairs(active_clients) do
        if client and client.name ~= "" then
          table.insert(client_names, 1, client.name)
        end
      end
      return table.concat(client_names, "")
    end,
  })
end
