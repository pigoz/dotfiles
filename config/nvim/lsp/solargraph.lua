return {
  cmd = { vim.fn.expand("~/.rbenv/shims/solargraph"), 'stdio' },
  root_markers = { 'Gemfile', '.git' },
  settings = {
    solargraph = {
      autoformat = false,
      completion = true,
      diagnostic = false,
      folding = false,
      references = true,
      rename = true,
      symbols = true
    }
  },
}
