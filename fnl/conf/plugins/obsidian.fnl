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
    (obsidian.setup {:workspaces [{:name "work" :path "~/notes/work"}]})))
  
obsidian-config
