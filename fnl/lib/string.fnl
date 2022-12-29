(fn gsub [s pattern replacement]
  "Returns a new string where `pattern` has been replaced by `replacement`"
  (let [(res _) (string.gsub s pattern replacement)]
    res))

(fn split [s pattern]
  "Returns an split finding iterator"
  (string.gmatch s pattern))

(fn split! [s pattern]
  "Returns a list of each elements found when splitting `s` with `pattern`"
  (icollect [k _ (split s pattern)] k))

{: gsub
 : split
 : split!}
