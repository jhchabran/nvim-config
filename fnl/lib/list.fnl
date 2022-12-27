(fn empty? [list]
  "Returns true if list is empty"
  (= 0 (length list)))

(fn car [list]
  "Returns the head of list"
  (. list 1))

(fn cdr [list]
  "Returns the tail of list" 
  (local l list)
  (table.remove l 1)
  l)

{: empty?
 : car
 : cdr}
