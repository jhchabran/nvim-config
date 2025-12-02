(import-macros {: do-req
                : let-req} :lib/require)

(fn codecompanion-config []
  (let [cc (require :codecompanion)
        vibe-adapter (fn []
                      (let [helpers (require :codecompanion.adapters.acp.helpers)]
                        {:name "vibe"
                         :formatted_name "Vibe"
                         :type "acp"
                         :roles {:llm "assistant"
                                 :user "user"}
                         :opts {:vision true}
                         :commands {:default ["vibe-acp"]}
                         :defaults {:mcpServers {} :timeout 20000}
                         :env {:MISTRAL_API_KEY "MISTRAL_API_KEY"}
                         :parameters {:protocolVersion 1
                                      :clientCapabilities {:fs {:readTextFile true :writeTextFile true}}
                                      :clientInfo {:name "CodeCompanion.nvim"
                                                   :version "1.0.0"}}
                         :handlers {:setup (fn [] true)
                                    :form_messages (fn [self messages capabilities]
                                                     (helpers.form_messages self messages capabilities))
                                    :on_exit (fn [self code])}}))] 
                       
    (cc.setup {:adapters {:acp {:vibe vibe-adapter}}
               ; :opts {:log_level "TRACE" :send_code true :use_default_actions true :use_default_prompts true} 
               :strategies {:agent {:adapter :vibe :model "devstral-latest"}
                            :chat {:adapter :vibe :model "devstral-latest"}
                            :inline {:adapter :vibe :model "devstral-latest"}
                            :cmd {:adapter :vibe :model "devstral-latest"}}})))

                          
  
codecompanion-config
