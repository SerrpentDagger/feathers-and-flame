local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#252e0f", -- Default Background
    base01 = "#3e4c1a", -- Lighter Background (status bars)
    base02 = "#384517", -- Selection Background
    base03 = "#707661", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#b4b6af", -- Dark Foreground (status bars)
    base05 = "#f3f3f2", -- Default Foreground
    base06 = "#f3f3f2", -- Light Foreground
    base07 = "#f3f3f2", -- Lightest Foreground
    -- Accent colors
    base08 = "#fd4663", -- Variables, XML Tags, Errors
    base09 = "#51e179", -- Integers, Constants
    base0A = "#71e151", -- Classes, Search Background
    base0B = "#c2e567", -- Strings, Diff Inserted
    base0C = "#92ecab", -- Regex, Escape Chars
    base0D = "#d3ec92", -- Functions, Methods
    base0E = "#a6ec92", -- Keywords, Storage
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
