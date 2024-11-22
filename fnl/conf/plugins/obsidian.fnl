(local nvim (require :lib/nvim))

(fn obsidian-config []
  ;; Set conceallevel to 2 just for markdown files
  (let [group (vim.api.nvim_create_augroup "obsidian" {:clear true})
        obsidian (require :obsidian)]
    (vim.api.nvim_create_autocmd "FileType" {:group group
                                             :pattern "markdown"
                                             :callback (fn [] (tset vim.opt_local :conceallevel 2))})
    ; gf passthrough
    (vim.keymap.set 
      "n" 
      "gf" 
      (fn [] 
         (if (obsidian.util.cursor_on_markdown_link) "<cmd>ObsidianFollowLink<CR>" "gf")))

    ;; Setup.
    (obsidian.setup {:workspaces [{:name "work" :path "~/notes/work"}
                                  {:name "brain" :path "~/perso/braincache"}]
                     :note_id_func (fn [title] ;; TODO rewrite in less imperative style, this is a rough translation of of the obsidian README
                                     (var suffix "")
                                     (if (~= title nil)
                                         (set suffix (-> title 
                                                         (: :gsub " " "-")
                                                         (: :gsub "[^A-Za-z0-9-]" "")
                                                         (: :lower)))
                                         (set suffix (.. suffix (string.char (math.random 69 90)))))
                                     (tostring (.. (os.time) "-" suffix)))})))
  
obsidian-config
