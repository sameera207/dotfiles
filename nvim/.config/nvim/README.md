# Neovim Configuration

This Neovim configuration uses **vim-plug** as the plugin manager with 52 plugins.

## Plugin Manager

vim-plug will be automatically installed by the bootstrap script.

## Plugin Installation

After symlinking this configuration, install all plugins:

```bash
nvim +PlugInstall +qall
```

## Plugins Included

- **Language Support**: Ruby, Rails, Elixir, TypeScript, JavaScript, HTML
- **LSP & Completion**: coc.nvim (Language Server Protocol)
- **AI Integration**: GitHub Copilot, CopilotChat, Claude Code
- **File Navigation**: NERDTree, Telescope, BufExplorer
- **Git Integration**: vim-fugitive, blamer.nvim
- **Testing**: vim-test with vim-dispatch
- **Code Quality**: ALE (linting), Neoformat (formatting)
- **UI**: vim-airline with themes, vim-devicons

## Key Bindings

See `init.vim` for full keybinding documentation. Leader key is `,`.

## Note

Plugins are NOT tracked in git (`.gitignore` excludes them). They will be installed automatically when running the bootstrap script.
