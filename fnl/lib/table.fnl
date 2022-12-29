(fn sparse [...]
  (let [args [...]
        t {}]
    (var j 0)
    (each [i x (ipairs args) :until (= x '&)]
      (set j i)
      (table.insert t x))
    (for [i (+ j 2) (length args) 2]
      (tset t (. args i) (. args (+ i 1))))
    t))

(fn opts! [subject ...]
  `(sparse ,subject & ,...))

(fn set! [table key value]
  "Sets a value in a table and returns the table itself"
  (do (tset table key value)
      table))

(fn all [iterator]
  "Returns a list of values taken from the `iterator`"
  (icollect [_ v iterator] v))

{: sparse
 : opts!
 : set!
 : all}
