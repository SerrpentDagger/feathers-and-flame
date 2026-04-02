local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#111123", -- Default Background
    base01 = "#212245", -- Lighter Background (status bars)
    base02 = "#1e1f3e", -- Selection Background
    base03 = "#626277", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#afafb6", -- Dark Foreground (status bars)
    base05 = "#f2f2f3", -- Default Foreground
    base06 = "#f2f2f3", -- Light Foreground
    base07 = "#f2f2f3", -- Lightest Foreground
    -- Accent colors
    base08 = "#fd4663", -- Variables, XML Tags, Errors
    base09 = "#f1ec5a", -- Integers, Constants
    base0A = "#955cd6", -- Classes, Search Background
    base0B = "#b6ec7a", -- Strings, Diff Inserted
    base0C = "#83e581", -- Regex, Escape Chars
    base0D = "#c966cc", -- Functions, Methods
    base0E = "#676be4", -- Keywords, Storage
    base0F = "#900017", -- Deprecated, Embedded Tags
  })
end
--[[
primary: #676be4
on_primary: #181925
primary_container: #0c108d
on_primary_container: #dcddef
primary_fixed: #bec0f4
primary_fixed_dim: #9396ec
on_primary_fixed: #21212c
on_primary_fixed_variant: #2b2c3b

secondary: #955cd6
on_secondary: #181925
secondary_container: #3d106f
on_secondary_container: #e5dcef
secondary_fixed: #d7bef4
secondary_fixed_dim: #bd96e9
on_secondary_fixed: #26212c
on_secondary_fixed_variant: #322b3b

tertiary: #c966cc
on_tertiary: #181925
tertiary_container: #671669
on_tertiary_container: #eedcef
tertiary_fixed: #f2bef4
tertiary_fixed_dim: #e696e9
on_tertiary_fixed: #2c212c
on_tertiary_fixed_variant: #3a2b3b

error: #fd4663
on_error: #181925
error_container: #900017
on_error_container: #fecdd4

surface: #14142a
on_surface: #f2f2f3
surface_variant: #1a1b37
on_surface_variant: #afafb6
surface_dim: #0d0e1c
surface_bright: #272953
surface_container_lowest: #0a0a15
surface_container_low: #101123
surface_container: #212245
surface_container_high: #1e1f3e
surface_container_highest: #24254c

outline: #626277
outline_variant: #626277
shadow: #14142a
scrim: #000000

inverse_surface: #e3e4e8
inverse_on_surface: #242428
inverse_primary: #333699

background: #14142a
on_background: #f2f2f3

hued: #e4cf67
invert: #98941b
invert: #6aa329
invert: #369933
--]]
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
