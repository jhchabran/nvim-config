(local {: setup} (require :nvim-treesitter.configs))

(setup {:auto_install true
        :sync_install false
        :highlight {:enable true}
        :textobjects {:select {:enable true
                               :lookahead true
                               :keymaps {:if "@function.inner"
                                         :af "@function.outer"
                                         :ic "@class.inner"
                                         :ac "@class.outer"
                                         :ia "@parameter.inner"
                                         :aa "@parameter.outer"}}}
        :ensure_installed ["go"
                           "gomod"
                           "lua"
                           "fennel"
                           "clojure"
                           "zig"
                           "rust"
                           "scheme"
                           "c"
                           "typescript"
                           "sql"
                           "make"
                           "bash"
                           "dockerfile"
                           "javascript"
                           "vim"
                           "json"
                           "markdown"
                           "html"
                           "toml"
                           "yaml"]})
