(fn do-req [mod key ...]
  `(let [name# (require ,mod)
         fun# (. name# ,key)]
     (fun# ,...)))

(fn let-req [[name mod] expr]
  `(let [,name (require ,mod)]
      ,expr))

{: do-req
 : let-req}
