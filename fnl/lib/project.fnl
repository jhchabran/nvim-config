(local job (require :plenary.job))
(local str (require :lib/string))

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
  (if (= "/" (string.sub path -1)) ;; TODO check if the last element is a directory instead
    path
    (path:match (.. "(.*" "/" ")"))))

(fn current-buffer-path []
  "Returns path of the current buffer"
  (vim.fn.expand "%:p:h"))

(fn current-buffer-dir-path []
  "Returns path of the current buffer enclosing folder"
  (dirname (current-buffer-path)))

(fn git-remote-url [remote-name?]
  (let [remote (or remote-name? "origin")
        j (job:new {:command "git"
                    :args ["remote" "get-url" remote]
                    :cwd (find-git-root (current-buffer-dir-path))
                    :on_stderr (fn [_ data] (error data))})]
    (j:sync)
    (. (. (j:result 1) 1))))

(fn git-current-branch []
  (let [j (job:new {:command "git"
                    :args ["branch" "--show-current"]
                    :cwd (find-git-root (current-buffer-dir-path))
                    :on_stderr (fn [_ data] (error data))})]
    (j:sync)
    (. (. (j:result 1) 1))))

(fn git-remote-to-forge-url [url]
  "Converts a git remote url into a browser url"
  (let [elems (str.split! url "([^:]+)")]
    (match elems
      ["https"] (str.gsub url "%.git$" "")
      [userhost path] (.. "https://" (str.gsub userhost "(git@)" "") "/" (str.gsub path "(%.git)" "")))))

(fn os-open-url [url]
  (if (vim.fn.has "macunix")
      (vim.api.nvim_exec (.. ":! open '" url "'") {})
      (vim.api.nvim_exec (.. ":! xdg-open '" url "'") {})))

(fn parse-github-url-kind [url]
  (string.match url "https://github%.com/[^/]+/[^/]+/([^/]+)"))

(fn github-url [path branch?]
  (let [root (find-git-root (dirname path))
        branch (or branch? (git-current-branch))
        relpath (str.gsub path (str.gsub root "%-" "%%-") "")
        repo (git-remote-to-forge-url (git-remote-url branch?))]
    (.. repo "/blob/" branch "/" relpath)))

(fn forge-to-sourcegraph-url [forge-url]
  (match (parse-github-url-kind forge-url)
    "blob" (let [(repo branch blob) (string.match forge-url "https://([^/]+/[^/]+/[^/]+)/blob/([^/]+)/(.*)")]
              (.. "https://sourcegraph.com/" repo "@" branch "/-/blob/" blob))))

{: find-git-root
 : dirname
 : current-buffer-path
 : current-buffer-dir-path
 : git-remote-url
 : git-remote-to-forge-url
 : os-open-url
 : parse-github-url-kind
 : github-url
 : forge-to-sourcegraph-url}
