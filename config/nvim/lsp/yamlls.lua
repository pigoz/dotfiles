return {
  settings = {
    yaml = {
      schemas = require('user.lsp.schemastore').yaml(),
      -- To use yamlls' built-in schemastore access:
      -- schemastore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
      -- validation = true,
      -- hover = true,
      -- completion = true,
    }
  },
}
