local neo_tree = require('neo-tree')

neo_tree.setup {
  close_if_last_window = true,
  default_component_configs = {
    name = {
      trailing_slash = true,
    },
    icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "ﰊ",
        folder_empty_open = "ﰊ",
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = "*",
        highlight = "NeoTreeFileIcon",
    },
  },
}
