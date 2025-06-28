return {
  {
    "mrcjkb/rustaceanvim",
    -- version = "^4", -- optional: pin to version 4.x
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            -- Add your on_attach logic here
          end,
          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy"
              },
            },
          },
        },
      }
    end,
  },
}
