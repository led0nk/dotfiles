return {
  "nosduco/remote-sshfs.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {},
  config = function()
    require("remote-sshfs").setup({
      connections = {
        ssh_configs = { -- which ssh configs to parse for hosts list
          vim.fn.expand("$HOME") .. "/.ssh/config",
          "/etc/ssh/ssh_config",
          -- "/path/to/custom/ssh_config"
        },
        -- NOTE: Can define ssh_configs similarly to include all configs in a folder
        -- ssh_configs = vim.split(vim.fn.globpath(vim.fn.expand "$HOME" .. "/.ssh/configs", "*"), "\n")
        sshfs_args = { -- arguments to pass to the sshfs command
          "-o reconnect",
          "-o ConnectTimeout=5",
        },
      },
      mounts = {
        base_dir = vim.fn.expand("$HOME") .. "/.sshfs/", -- base directory for mount points
        unmount_on_exit = true,                      -- run sshfs as foreground, will unmount on vim exit
      },
      handlers = {
        on_connect = {
          change_dir = true, -- when connected change vim working directory to mount point
        },
        on_disconnect = {
          clean_mount_folders = false, -- remove mount point folder on disconnect/unmount
        },
        on_edit = {},             -- not yet implemented
      },
      ui = {
        select_prompts = false, -- not yet implemented
        confirm = {
          connect = true,   -- prompt y/n when host is selected to connect to
          change_dir = false, -- prompt y/n to change working directory on connection (only applicable if handlers.on_connect.change_dir is enabled)
        },
      },
      log = {
        enable = false, -- enable logging
        truncate = false, -- truncate logs
        types = {     -- enabled log types
          all = false,
          util = false,
          handler = false,
          sshfs = false,
        },
      },
    })

    local api = require("remote-sshfs.api")
    local connections = require("remote-sshfs.connections")
    local builtin = require("telescope.builtin")

    -- Basic connect/disconnect/edit mappings
    vim.keymap.set("n", "<leader>rc", api.connect, { desc = "Remote SSHFS connect" })
    vim.keymap.set("n", "<leader>rd", api.disconnect, { desc = "Remote SSHFS disconnect" })
    vim.keymap.set("n", "<leader>re", api.edit, { desc = "Remote SSHFS edit ssh config" })

    -- Dynamically choose between local or remote telescope actions
    vim.keymap.set("n", "<leader>fsshf", function()
      if connections.is_connected then
        api.find_files() -- remote
      else
        builtin.find_files() -- local
      end
    end, { desc = "Find files (local or remote)" })

    vim.keymap.set("n", "<leader>fsshg", function()
      if connections.is_connected then
        api.live_grep() -- remote
      else
        builtin.live_grep() -- local
      end
    end, { desc = "Live grep (local or remote)" })
  end,
}
