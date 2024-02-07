return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "work",
        path = "/home/luka/Dokumente/vault",
      }
    },
    daily_notes = {
      -- this requires english locale
      date_format = "%Y/%m-%B/%Y-%m-%d-%a",
      --date_format = "%Y/%m-%mmmmm/%YYYY-%MM-%DD-%dddd",
      alias_format = "%B %-d, %Y",
    },
    templates = {
      subdir = "my-templates-folder",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
      new_notes_location = "current_dir",
      prepend_note_id = false,
      prepend_note_path = false,
      use_path_only = true,
    }
    -- see below for full list of options 👇
  },
}
