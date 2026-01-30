# Minimalist Neovim Configuration

This config only installs six plugins by default. These plugins are managed by
lazy.nvim, a popular plugin manager. Run `:Lazy` to access lazy.nvim's menu.
Also, make sure these plugins' prerequisites have been installed, such as
`tree-sitter-cli` for Nvim-Treesitter.

1. Mason (Installs LSPs, Formatters, and more!)
2. Nvim-Treesitter (Syntax Highlighting)
3. Conform (Uses Mason's formatters to format on save)
4. Blink.cmp (Uses Mason's LSPs to provide autocomplete)
4. Nvim-Autopairs (Autoclose brackets, parentheses, etc.)
5. Catppuccin (Dark theme for Neovim)

When installing languages, the first four plugins must be configured in order
to support it.

1. Mason
    - Run `:Mason` to open the menu.
    - `<C-f>` to filter by a language.
    - Hover and press `i` to install the packages you want.
2. Nvim-Treesitter
    - Run `:TSInstall <language>` to install treesitter's parser for that
    language.
    - List the language the parser was just installed for at the
    `vim.treesitter.start()` autocmd.
3. Conform
    - To connect conform to the formatter installed by Mason, add
    `<language> = "formatter"` at the `formatters_by_ft` option.
    - Example: `java = "google-java-format"`
4. LSP Configuration
    - Write the configuration for your language server.
    - Example:

```lua
{
    cmd = { "jdtls" },
    filetypes = { "java" },
    root_marker = { "pom.xml", "build.gradle", ".git", "mvnw", "gradlew" },
}
```

5. Blink and LSP Enabling
    - Option 1: Create a `lsp` folder inside the `.config/nvim/` folder.
    Inside `lsp`, create a `.lua` file with the configuration.
    - Option 2: Use `vim.lsp.config()` and put your configuration inside.
    This happens at the bottom of `init.lua`.
    - After either option 1 or 2, go to the bottom of `init.lua` and add
    `vim.lsp.enable()` for the installed language server.
    - This step allows blink.cmp to work as well.

Use `:checkhealth` to check that all plugins are working properly.

