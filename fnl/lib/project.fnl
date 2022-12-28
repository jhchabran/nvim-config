(local job (require :plenary.job))

(fn find-git-root [dir]
  "Finds the root directory, i.e the one containing the `.git` folder"
  (let [j (job:new {:command "git" 
                    :args ["rev-parse" "--show-toplevel"]
                    :cwd dir
                    :on_stderr (fn [_ data] (error data))})]
    (j:sync)
    (. (j:result) 1)))

(fn dirname [path]
  "Returns the path to `path` enclosing folder"
  (path:match (.. "(.*" "/" ")")))

(fn current-buffer-path []
  "Returns path of the current buffer"
  (vim.fn.expand "%:p:h"))

(fn current-buffer-dir-path []
  "Returns path of the current buffer enclosing folder"
  (dirname (current-buffer-path)))

{: find-git-root
 : dirname
 : current-buffer-path
 : current-buffer-dir-path}
