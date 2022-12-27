(local {: setup} (require "lualine"))

(lua "local active_c = {'%=', {'filename', path = 1, color = { fg = '#fff' }}, {'diff', colored = false }}")
(lua "local inactive_c = {'%=', {'filename', path = 1}}")

(setup {:options {:icons_enabled true
                  :theme (require "lumona.lualine")
                  :component_separators [""  ""]
                  :section_separators ["" ""]
                  :disabled_filetypes  {}}
        :sections {:lualine_a  ["mode"]
                   :lualine_b ["branch"]
                   :lualine_c active_c
                   :lualine_x ["encoding"  "fileformat"  "filetype"]
                   :lualine_y ["progress"]
                   :lualine_z ["location"]}
        :inactive_sections {:lualine_a []
                            :lualine_b []
                            :lualine_c inactive_c
                            :lualine_x ["location"]
                            :lualine_y []
                            :lualine_z []}
        :tabline {}
        :extensions {}})
