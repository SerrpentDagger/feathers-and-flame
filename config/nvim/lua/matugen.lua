local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#142829", -- Default Background
    base01 = "#214345", -- Lighter Background (status bars)
    base02 = "#1e3c3e", -- Selection Background
    base03 = "#5d726f", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#afb6b5", -- Dark Foreground (status bars)
    base05 = "#f2f3f3", -- Default Foreground
    base06 = "#f2f3f3", -- Light Foreground
    base07 = "#f2f3f3", -- Lightest Foreground
    -- Accent colors
    base08 = "#fd4663", -- Variables, XML Tags, Errors
    base09 = "#a2cc66", -- Integers, Constants
    base0A = "#5ca8d6", -- Classes, Search Background
    base0B = "#67e4d5", -- Strings, Diff Inserted
    base0C = "#c7e996", -- Regex, Escape Chars
    base0D = "#93ece1", -- Functions, Methods
    base0E = "#96c9e9", -- Keywords, Storage
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
