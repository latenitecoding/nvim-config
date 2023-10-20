return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- ensure_installed = { "lua" },
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "c_sharp",
      "go",
      "java",
      "julia",
      -- "lean", -- not available
      "lua",
      "ocaml",
      "python",
      "rust",
      "toml",
      "typescript",
      "yaml",
      "zig"
    }
  },
}
