local neo_tree = require('neo-tree')

neo_tree.setup {
  close_if_last_window = true,
  default_component_configs = {
    name = {
      trailing_slash = true,
    },
  },
  filesystem = {
    renderers = {
      file = {
        { "icon" },
        { "name", use_git_status_colors = true },
        { "diagnostics" },
        { "git_status", highlight = "NeoTreeDimText" },
      }
    }
  },
}
