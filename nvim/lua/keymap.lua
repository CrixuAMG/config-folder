local keymap = vim.keymap

keymap.set("n", "<leader>ide", ':AerialToggle!<CR> :Neotree toggle left  reveal_force_cwd<CR>', { desc = 'Start IDE mode' })

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {desc = "Clear search highlights and exit normal mode"})

