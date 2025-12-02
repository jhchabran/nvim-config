(local nvim (require :lib/nvim))

;; set leader to space early
(nvim.g :mapleader " ")

(local indent 2)

(nvim.opt :expandtab true) ;; use spaces instead of tabs (unless asked otherwise)
(nvim.opt :shiftwidth indent) ;; size of an indent
(nvim.opt :smartindent  true) ;; Insert indents automatically
(nvim.opt :tabstop  indent) ;; Number of spaces tabs count for
(nvim.opt :mouse "a") ;; Useful when browsing
(nvim.opt :clipboard "unnamedplus") ;; Put those yanks in my os clipboards
(nvim.opt :completeopt "menu,menuone,noselect") ;; Completion options (for compe)
(nvim.opt :hidden true) ;; Enable modified buffers in background
(nvim.opt :ignorecase true) ;; Ignore case
(nvim.opt :incsearch true) ;; Make search behave like modern browsers
(nvim.opt :cursorline true) ;; Display the current line
(nvim.opt :joinspaces false) ;; No double spaces with join after a dot
(nvim.opt :scrolloff 10) ;; Lines of context
(nvim.opt :shiftround true) ;; Round indent
(nvim.opt :sidescrolloff 8) ;; Columns of context
(nvim.opt :smartcase true) ;; Don't ignore case with capitals
(nvim.opt :splitbelow true) ;; Put new windows below current
(nvim.opt :splitright true) ;; Put new windows right of current
(nvim.opt :termguicolors true) ;; True color support
(nvim.opt :wildmode "list:longest") ;; Command-line completion mode
(nvim.opt :list false) ;; Show some invisible characters (tabs...)
(nvim.opt :number true) ;; Print line number
(nvim.opt :relativenumber false) ;; Relative line numbers
(nvim.opt :wrap true) ;; Enable line wrap
(nvim.opt :cmdheight 2) ;; More space to display messages
(nvim.opt :timeoutlen 400) ;; Don't wait more that 400ms for normal mode commands
(nvim.opt :updatetime 700) ;; CursorHold use this value to known for how long the cursor is being held
(nvim.opt :sessionoptions "blank,buffers,curdir,folds,help,tabpages,winsize,resize,winpos,terminal")
(nvim.opt :foldlevelstart 0)
(nvim.opt :shada ["!" "'1000" "<50" "s10" "h"]) ;; remember stuff across sessions
(vim.api.nvim_command "set noswapfile") ;; I have OCD file saving issues anyway
(nvim.opt :cmdheight  1)

(require :conf.globals)
(require :conf.plugins)
(require :conf.mappings)
(require :conf.lsp)

(nvim.colorscheme :terafox)
; (nvim.colorscheme :terafox)
; (nvim.opt :background :light)
; (nvim.colorscheme :dayfox)

;; I like to use a different theme for some different projects, so 
;; it's faster to understand to which term tab I'm looking at.
(let [home (os.getenv "HOME")]
  (if (= (vim.fn.getcwd) (string.format "%s/work/other" home))
      (nvim.colorscheme :kanagawa))
  (if (= (vim.fn.getcwd) (string.format "%s/work/scratch" home))
      (nvim.colorscheme :habamax)))
