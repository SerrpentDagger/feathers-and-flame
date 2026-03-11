local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#17271c", -- Default Background
    base01 = "#26402e", -- Lighter Background (status bars)
    base02 = "#223a29", -- Selection Background
    base03 = "#5d7264", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#afb6b1", -- Dark Foreground (status bars)
    base05 = "#f2f3f2", -- Default Foreground
    base06 = "#f2f3f2", -- Light Foreground
    base07 = "#f2f3f2", -- Lightest Foreground
    -- Accent colors
    base08 = "#fd4663", -- Variables, XML Tags, Errors
    base09 = "#66accc", -- Integers, Constants
    base0A = "#5cd6c1", -- Classes, Search Background
    base0B = "#67e48e", -- Strings, Diff Inserted
    base0C = "#96cfe9", -- Regex, Escape Chars
    base0D = "#93ecaf", -- Functions, Methods
    base0E = "#96e9da", -- Keywords, Storage
    base0F = "#900017", -- Deprecated, Embedded Tags
  })
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    package.loaded["matugen"] = nil
    require("matugen").setup()
  end)
)

return M
