local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#291a14", -- Default Background
    base01 = "#452b21", -- Lighter Background (status bars)
    base02 = "#3e271e", -- Selection Background
    base03 = "#74655f", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#b6b1af", -- Dark Foreground (status bars)
    base05 = "#f3f2f2", -- Default Foreground
    base06 = "#f3f2f2", -- Light Foreground
    base07 = "#f3f2f2", -- Lightest Foreground
    -- Accent colors
    base08 = "#fd4663", -- Variables, XML Tags, Errors
    base09 = "#b3d35f", -- Integers, Constants
    base0A = "#d6bd5c", -- Classes, Search Background
    base0B = "#e48a67", -- Strings, Diff Inserted
    base0C = "#d2e996", -- Regex, Escape Chars
    base0D = "#ecac93", -- Functions, Methods
    base0E = "#e9d896", -- Keywords, Storage
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
