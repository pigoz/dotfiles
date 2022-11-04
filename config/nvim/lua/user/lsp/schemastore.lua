local M = {}

function M.yaml()
  local versions = {
    -- override openapi schema with version 3.0
    ["openapi.json"] = "3.0",
  }

  return require('user.utils.table').from_array(M.json(), function(schema)
    if versions[schema.name] then
      local version = versions[schema.name]
      return schema.versions[version], schema.fileMatch
    else
      return schema.url, schema.fileMatch
    end
  end)
end

function M.json()
  -- https://github.com/b0o/SchemaStore.nvim/blob/main/lua/schemastore/catalog.lua
  return require('schemastore').json.schemas {}
end

return M
