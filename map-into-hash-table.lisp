(defpackage #:y2q-cl-trash/map-into-hash-table
  (:use :cl)
  (:import-from #:y2q-cl-trash/package
		#:map-into-hash-table))	; The symbol to be defined.

(in-package #:y2q-cl-trash/map-into-hash-table)

(defun map-into-hash-table/overwrite (list key-fn value-fn hash-table)
  (loop for i in list
     do (setf (gethash (funcall key-fn i) hash-table)
	      (funcall value-fn i)))
  hash-table)

(defun map-into-hash-table/push (list key-fn value-fn hash-table)
  ;; This code reverses its order.
  (loop for i in list
     do (push (funcall value-fn i)
	      (gethash (funcall key-fn i) hash-table)))
  hash-table)

(defun map-into-hash-table/ignore-or-error (list key-fn value-fn hash-table errorp)
  (loop for i in list
     as k = (funcall key-fn i)
     if (nth-value 1 (gethash k hash-table)) ; looks present-p
     do (when errorp
	  (error "hash-table ~A already has a value on key ~A"
		 hash-table k))
     else
     do (setf (gethash k hash-table)
	      (funcall value-fn i)))
  hash-table)

(defun map-into-hash-table/merge (list key-fn value-fn hash-table merge-fn)
  (loop for i in list
     as k = (funcall key-fn i)
     as v = (funcall value-fn i)
     do (multiple-value-bind (old-val present-p)
	    (gethash k hash-table)
	  (setf (gethash k hash-table)
		(if present-p
		    ;; I follow `reduce' convention; (funcall <accumulator> <new value>)
		    (funcall merge-fn old-val v)
		    v))))
  hash-table)

(defun map-into-hash-table (list &key (key #'identity) (value #'identity)
				   (hash-table (make-hash-table))
				   (if-exists :overwrite))
  (case if-exists
    (:overwrite (map-into-hash-table/overwrite list key value hash-table))
    (:push (map-into-hash-table/push list key value hash-table))
    (:ignore (map-into-hash-table/ignore-or-error list key value hash-table nil))
    (:error (map-into-hash-table/ignore-or-error list key value hash-table t))
    (otherwise (map-into-hash-table/merge list key value hash-table if-exists))))
