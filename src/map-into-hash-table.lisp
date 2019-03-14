(defpackage #:y2q-cl-trash/src/map-into-hash-table
  (:use :cl)
  (:import-from #:y2q-cl-trash/package)	; for saying a dependency to `package-inferred-system'.
  (:export))

(in-package #:y2q-cl-trash/src/map-into-hash-table)

(defun y2q-cl-trash:map-into-hash-table
    (list &key (key #'identity) (value #'identity) (hash-table (make-hash-table)))
  (loop for i in list
     as k = (funcall key i)
     as v = (funcall value i)
     do (push v (gethash k hash-table)))
  ;; This code reverses its order.
  ;; To preserve it, I should make a temporal hash-table, pushes into it, and merge two tables.
  ;; or -- make a parameter like :if-conflict ?
  #+ ()
  (loop for k being the hash-key of table hash-using (hash-value v)
     do (setf (gethash k hash-table) (nreverse v)))
  hash-table)
