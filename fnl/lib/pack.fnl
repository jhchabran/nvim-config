; Taken from https://github.com/datwaft/myconf.nvim/blob/main/fnl/myconf/pack.fnl
(local {: str? : nil? : tbl? } (require :lib.types))

(tset _G :myconf/pack [])
(tset _G :myconf/rock [])

(lambda pack [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element and
  options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options.
  Additional to those options you can use 'require*' and 'setup*' to use the
  'config' options with `require(%s)` and `require(%s).setup() respectively.`"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (match k
                    :require* (values :config (string.format "require(\"%s\")" v))
                    :setup* (values :config (string.format "require(\"%s\").setup()" v))
                    :config* (values :config (string.format "require(\"%s\").setup(%s)" (. v 1) (. v 2)))
                    _ (values k v)))]
    (doto options (tset 1 identifier))))

(lambda rock [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element and
  options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (let [options (or ?options {})]
    (doto options (tset 1 identifier))))

(lambda pack! [identifier ?options]
  "Declares a plugin with its options. This macro adds it to the myconf/pack
  global table to later be used in the `unpack!` macro.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (table.insert _G.myconf/pack (pack identifier ?options)))

(lambda rock! [identifier ?options]
  "Declares a rock with its options. This macro adds it to the myconf/rock
  global table to later be used in the `unpack!` macro.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (if (not (nil? ?options)) (assert-compile (tbl? ?options) "expected table for options" ?options))
  (table.insert _G.myconf/rock (rock identifier ?options)))

(lambda unpack! []
  "Initializes the plugin manager with the plugins previously declared and
  their respective options."
  (let [packs (icollect [_ v (ipairs _G.myconf/pack)] `(use ,v))
        rocks (icollect [_ v (ipairs _G.myconf/rock)] `(use_rocks ,v))]
    (tset _G :myconf/pack [])
    (tset _G :myconf/rock [])
    `((. (require :packer) :startup)
      (fn []
        ,(unpack (icollect [_ v (ipairs packs) :into rocks] v))))))

{: pack
 : rock
 : pack!
 : rock!
 : unpack!}
