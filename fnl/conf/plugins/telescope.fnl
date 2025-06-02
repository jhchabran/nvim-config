(fn telescope-config []
  (let [actions (require :telescope.actions)
        telescope (require :telescope)]
    (telescope.setup {:defaults {:layout_config {:prompt_position :top}
                                 :sorting_strategy :ascending
                                 :mappings {:i {"<C-g>" actions.close}
                                            :n {"<C-g>" actions.close}}}
                      :pickers {:buffers {:mappings {:n {"d" actions.delete_buffer}}}
                                :find_files {:hidden true
                                             :file_ignore_patterns [".git"]}}
                      :extensions {:frecency {:default_workspace ":CWD:"
                                              :workspaces {:work "~/work"}
                                                          {:perso "~/perso"}
                                                          {:play "~/play"}}
                                    :file_browser {:hidden { :file_browser true :folder_browser true }}}})))
telescope-config
