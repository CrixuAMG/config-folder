local keymap = vim.keymap

keymap.set("n", "<leader>ide", ':AerialToggle!<CR> :Neotree toggle left  reveal_force_cwd<CR>', { desc = 'Start IDE mode' })

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {desc = "Clear search highlights and exit normal mode"})

keymap.set('n', '<leader>ta', ':lua toggle_arrows()<CR>', { noremap = true, silent = true, desc = "Toggle arrow keys ON/OFF" }) 

arrow_keys_enabled = true

function toggle_arrows()
  local opts = { noremap = true }
  if arrow_keys_enabled then
    -- Disable arrow keys
    keymap.set('', '<Up>', '<Nop>', opts)
    keymap.set('', '<Down>', '<Nop>', opts)
    keymap.set('', '<Left>', '<Nop>', opts)
    keymap.set('', '<Right>', '<Nop>', opts)
  else
    -- Enable arrow keys
    keymap.set('', '<Up>', '<Up>', opts)
    keymap.set('', '<Down>', '<Down>', opts)
    keymap.set('', '<Left>', '<Left>', opts)
    keymap.set('', '<Right>', '<Right>', opts)
  end
  arrow_keys_enabled = not arrow_keys_enabled
end

