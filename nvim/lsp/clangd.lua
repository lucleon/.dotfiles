return {
  cmd = {'clangd'},
  filetypes = {'cpp', 'c', 'hpp', 'h'},
  root_markers =  { '.clangd', '.compile_commands.json' },
  capabilities = {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true
      }
    }
  }
}

