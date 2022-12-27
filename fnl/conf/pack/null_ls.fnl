(local ls (require :null-ls))

(ls.setup {:sources [ls.builtins.formatting.stylua
                     ls.builtins.completion.spell
                     ls.builtins.code_actions.proselint
                     ls.builtins.diagnostics.actionlint
                     ls.builtins.diagnostics.checkmake
                     ls.builtins.diagnostics.golangci_lint
                     ls.builtins.diagnostics.shellcheck
                     ls.builtins.formatting.goimports]})
