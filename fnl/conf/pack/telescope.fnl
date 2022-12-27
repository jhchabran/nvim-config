(local {: setup} (require "telescope"))
(local actions (require "telescope.actions"))

(fn load-ext [name]
  "Small helper fn to load a telescope extension." 
  (let [{: load_extension} (require "telescope")]
    (load_extension name)))

(setup {:defaults {:layout_config {:prompt_position "top"}
                   :sorting_strategy "ascending"
                   :mappings {:i {"<C-g>" actions.close}
                              :n {"<C-g>" actions.close}}}
        :pickers {:buffers {:mappings {:n {"d"  actions.delete_buffer}}}}
        :extensions {:frecency {:default_workspace ":CWD:"}
                                :workspaces {:work "~/work"
                                             :perso "~/perso"
                                             :play "~/play"}
                     :project {:base_dirs ["~/work"
                                           "~/play"
                                           "~/perso"]}}})

(load-ext "file_browser")
(load-ext "ui-select")
(load-ext "live_grep_args")
(load-ext "gh")
(load-ext "frecency")
(load-ext "project")
