;; (macro mapping [...]
;;   (let [args [...]
;;         len (length args)]
;;     (if (= 0 (% len 2))
;;         (let [t []]
;;           (for [i 1 len 2]
;;             (tset t (tostring (. args i)) (. args (+ i 1))))
;;           t))))

;; (macro rfn [[mod sym] body]
;;   `(let [,sym (require ,mod)]
;;      (fn [] ,body)))
;;
;; (macrodebug
;;   (rfn [:FTerm m] (m.toggle)))

; What it want it to expand to 
; (let [m (require :FTerm)] (m.toggle))

;; {: rfn}
