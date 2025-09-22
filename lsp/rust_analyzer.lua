return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = {
    'Cargo.toml',
    'Cargo.lock',
  },
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = 'clippy',
      },
    },
  },
}