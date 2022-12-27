(import-macros {: opts!
                : sparse} :lib/table)

(fn lualine-config []
  (let [lualine (require :lualine)]
    (lualine.setup {:options {:icons_enabled true
                              :component_separators ["" ""]
                              :section_separators ["" ""]
                              :disabled_filetypes []}
                    :sections {:lualine_a [:mode]
                               :lualine_b [:branch]
                               :lualine_c ["%=" (opts! :filename {:path 1 :color { :fg "#fff"}}) (opts! :diff {:colored false})]
                               :lualine_x [:encoding :fileformat :filetype]
                               :lualine_y [:progress]
                               :lualine_z [:location]}
                    :inactive_sections {:lualine_a []
                                        :lualine_b []
                                        :lualine_c ["%=" (opts! :filename {:path 1})]
                                        :lualine_x []
                                        :lualine_y []
                                        :lualine_z []}
                    :tabline []
                    :extensions []})))

lualine-config
