local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "{{colors.surface.default.hex | darken 2}}", -- Default Background
    base01 = "{{colors.surface_container.default.hex}}", -- Lighter Background (status bars)
    base02 = "{{colors.surface_container_high.default.hex}}", -- Selection Background
    base03 = "{{colors.outline.default.hex}}", -- Comments, Invisibles
    -- Foreground tones
    base04 = "{{colors.on_surface_variant.default.hex}}", -- Dark Foreground (status bars)
    base05 = "{{colors.on_surface.default.hex}}", -- Default Foreground
    base06 = "{{colors.on_surface.default.hex}}", -- Light Foreground
    base07 = "{{colors.on_background.default.hex}}", -- Lightest Foreground
    -- Accent colors
    base08 = "{{colors.error.default.hex}}", -- Variables, XML Tags, Errors
    base09 = "{{colors.primary_container.default.hex | invert | darken 5}}", -- Integers, Constants
    base0A = "{{colors.secondary.default.hex}}", -- Classes, Search Background
    base0B = "{{colors.secondary_container.default.hex | invert | darken 5}}", -- Strings, Diff Inserted
    base0C = "{{colors.tertiary_container.default.hex | invert | darken 5}}", -- Regex, Escape Chars
    base0D = "{{colors.tertiary.default.hex}}", -- Functions, Methods
    base0E = "{{colors.primary.default.hex}}", -- Keywords, Storage
    base0F = "{{colors.error_container.default.hex | invert | darken 20}}", -- Deprecated, Embedded Tags
  })
end
--[[
primary: {{colors.primary.default.hex}}
on_primary: {{colors.on_primary.default.hex}}
primary_container: {{colors.primary_container.default.hex}}
on_primary_container: {{colors.on_primary_container.default.hex}}
primary_fixed: {{colors.primary_fixed.default.hex}}
primary_fixed_dim: {{colors.primary_fixed_dim.default.hex}}
on_primary_fixed: {{colors.on_primary_fixed.default.hex}}
on_primary_fixed_variant: {{colors.on_primary_fixed_variant.default.hex}}

secondary: {{colors.secondary.default.hex}}
on_secondary: {{colors.on_secondary.default.hex}}
secondary_container: {{colors.secondary_container.default.hex}}
on_secondary_container: {{colors.on_secondary_container.default.hex}}
secondary_fixed: {{colors.secondary_fixed.default.hex}}
secondary_fixed_dim: {{colors.secondary_fixed_dim.default.hex}}
on_secondary_fixed: {{colors.on_secondary_fixed.default.hex}}
on_secondary_fixed_variant: {{colors.on_secondary_fixed_variant.default.hex}}

tertiary: {{colors.tertiary.default.hex}}
on_tertiary: {{colors.on_tertiary.default.hex}}
tertiary_container: {{colors.tertiary_container.default.hex}}
on_tertiary_container: {{colors.on_tertiary_container.default.hex}}
tertiary_fixed: {{colors.tertiary_fixed.default.hex}}
tertiary_fixed_dim: {{colors.tertiary_fixed_dim.default.hex}}
on_tertiary_fixed: {{colors.on_tertiary_fixed.default.hex}}
on_tertiary_fixed_variant: {{colors.on_tertiary_fixed_variant.default.hex}}

error: {{colors.error.default.hex}}
on_error: {{colors.on_error.default.hex}}
error_container: {{colors.error_container.default.hex}}
on_error_container: {{colors.on_error_container.default.hex}}

surface: {{colors.surface.default.hex}}
on_surface: {{colors.on_surface.default.hex}}
surface_variant: {{colors.surface_variant.default.hex}}
on_surface_variant: {{colors.on_surface_variant.default.hex}}
surface_dim: {{colors.surface_dim.default.hex}}
surface_bright: {{colors.surface_bright.default.hex}}
surface_container_lowest: {{colors.surface_container_lowest.default.hex}}
surface_container_low: {{colors.surface_container_low.default.hex}}
surface_container: {{colors.surface_container.default.hex}}
surface_container_high: {{colors.surface_container_high.default.hex}}
surface_container_highest: {{colors.surface_container_highest.default.hex}}

outline: {{colors.outline.default.hex}}
outline_variant: {{colors.outline_variant.default.hex}}
shadow: {{colors.shadow.default.hex}}
scrim: {{colors.scrim.default.hex}}

inverse_surface: {{colors.inverse_surface.default.hex}}
inverse_on_surface: {{colors.inverse_on_surface.default.hex}}
inverse_primary: {{colors.inverse_primary.default.hex}}

background: {{colors.background.default.hex}}
on_background: {{colors.on_background.default.hex}}

hued: {{colors.primary.default.hex | set_hue 50}}
invert: {{colors.primary.default.hex | invert}}
invert: {{colors.secondary.default.hex | invert}}
invert: {{colors.tertiary.default.hex | invert}}
--]]

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
