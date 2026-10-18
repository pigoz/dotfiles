-- TypeScript 7 is native and is its own language server, so no
-- typescript-language-server (which needs the old JS tsserver)
return {
  cmd = { 'tsc', '--lsp', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
}
