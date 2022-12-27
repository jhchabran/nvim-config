;; (import-macros {: pack
;;                 : pack!
;;                 : unpack!} :lib.pack)

;; TODO move to utils
(tset _G :dump (fn [...]
                 (let [objects (vim.tbl_map vim.inspect  [...])]
                   (print (unpack objects)))))

;; set leader to space early
(set vim.g.mapleader " ")

(require :conf.plugins)
;; (require "conf.mapping")
