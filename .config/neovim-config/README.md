

# Neovim IDE Setup on Arch Linux
A complete Neovim setup IDE on Arch Linux.
Support languages : Python, Rust, Fortran, C/C++, and CUDA. 
It includes essential plugins and configurations for a DE features LSP, debugging, Git integration, fuzzy finding, completion, file exp, Terminal Lng and more.

## Table of Contents
1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Features Overview](#features-overview)
4. [Usage Guide](#usage-guide)
    - [File Explorer](#file-explorer)
    - [Fuzzy Finder](#fuzzy-finder)
    - [Code Completion](#code-completion)
    - [Git Integration](#git-integration)
    - [Debugger](#debugger)
    - [Terminal Integration](#terminal-integration)
5. [Keybindings](#keybindings)
6. [Additional Tips](#additional-tips)

---

## Installation

### Step 1: Install Neovim and Packer
Make sure to install Neovim and the required dependencies installed. Use `packer.nvim` as a plugin manager.

```bash
# Install Neovim and dependencies
sudo pacman -S neovim python-pynvim nodejs npm
# Clone packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### Step 2: Initialize Neovim Configuration
Create the `~/.config/nvim/init.lua` file and copy the configuration. Then, launch Neovim and run `:PackerSync` to install the plugins.

---

## Configuration

Add Configurations `~/.config/nvim/init.lua` file to configure Neovim and the plugins for IDE functionality:

```lua
-- Include setup for packer, LSP, code completion, file explorer, etc.
-- (See full configuration details in LUA FILE)
```

Refer to the [Configuration](#configuration) section of the main guide for more details on each plugin’s setup.

---

## Features Overview

| Feature            | Description                                        | Plugin Used              |
|--------------------|----------------------------------------------------|--------------------------|
| File Explorer      | Tree-style file navigation                         | `nvim-tree`              |
| Fuzzy Finder       | Quick file and text search                         | `telescope`              |
| Code Completion    | Autocomplete for code and snippets                 | `nvim-cmp` + `LuaSnip`   |
| Git Integration    | Inline Git information and management              | `gitsigns`               |
| Debugging          | Code debugging interface                           | `nvim-dap` + `dap-ui`    |
| Terminal           | Embedded terminal within Neovim                    | `toggleterm`             |
| Statusline/Tabline | Customizable status line and tab management        | `lualine`, `barbar`      |
| Syntax Highlighting| Language-specific syntax highlighting              | `treesitter`             |
| Auto Pairs         | Auto-close for brackets and quotes                 | `nvim-autopairs`         |

---

## Usage Guide

This section WILL covers the usage of each key feature in your Neovim setup.

### File Explorer
To open the file explorer, press `<C-n>`. Use the arrow keys or `j`/`k` to navigate and open files with `Enter`.

- **Toggle File Explorer**: `<C-n>`
- **Basic Navigation**: Arrow keys or `j`/`k`
- **Close Explorer**: `<C-n>`

### Fuzzy Finder
Press `<C-p>` to open Telescope, the fuzzy finder. From here, you can quickly search for files, text, and more.

- **Find Files**: `<C-p>`
- **Live Grep (text search)**: `<leader>fg`
- **Search Buffers**: `<leader>fb`
- **Help Tags**: `<leader>fh`

### Code Completion
Autocomplete is activated as you type. You can use the following keys for interaction:

- **Trigger Completion**: `<C-Space>`
- **Scroll Docs**: `<C-b>` (back) / `<C-f>` (forward)
- **Accept Suggestion**: `<CR>`
- **Navigate Snippet**: Tab or Shift+Tab

### Git Integration
Git signs provide visual feedback on changes in your code. To access more Git features:

- **Toggle Inline Git Status**: Commands are pre-mapped; hover on the sidebar to see additions, modifications, and deletions.
- **Git Navigation**: Use Telescope’s `find_files` with Git options or `gitsigns` commands for further actions.

### Debugger
To debug your code, use `nvim-dap` commands or keys to start, continue, and step through code.

- **Start Debugging**: `<F5>`
- **Step Over**: `<F10>`
- **Step Into**: `<F11>`
- **Step Out**: `<F12>`

Use `dap-ui` for an enhanced debugging interface.

### Terminal Integration
Press `<C-\>` to open the embedded terminal within Neovim. This can be used for running commands, accessing REPLs, and more.

- **Open Terminal**: `<C-\>`
- **Close Terminal**: `<C-\>` again (toggle)

---

## Keybindings

| Keybinding          | Action                        |
|---------------------|------------------------------|
| `<C-n>`             | Toggle File Explorer         |
| `<C-p>`             | Find Files (Telescope)       |
| `<leader>fg`        | Live Grep                    |
| `<leader>fb`        | Find Buffers                 |
| `<leader>fh`        | Help Tags                    |
| `<C-Space>`         | Trigger Autocomplete         |
| `<C-b>` / `<C-f>`   | Scroll Docs                  |
| `<CR>`              | Accept Completion            |
| `<F5>`              | Start Debugging              |
| `<F10>`             | Step Over                    |
| `<F11>`             | Step Into                    |
| `<F12>`             | Step Out                     |
| `<C-\>`             | Toggle Terminal              |

---

## Additional Configutarion

1. **Customizing Keybindings**: You can edit the `init.lua` file to remap keys based on your preferences.
2. **Adding More Plugins**: With `packer.nvim`, simply add more plugins to your `init.lua` configuration under `use` statements and run `:PackerSync` to install them.
3. **Updating Plugins**: Run `:PackerUpdate` periodically to keep your plugins updated.
4. **Troubleshooting**: For debugging any setup issues, you can run `:PackerSync` to ensure plugins are installed correctly and check for errors in the `init.lua` file.
