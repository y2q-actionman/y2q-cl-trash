(defpackage #:y2q-cl-trash/reduce-into-hash-table
  (:use :cl :alexandria)
  (:import-from #:y2q-cl-trash/package
		#:reduce-into-hash-table)) ; This will be defined.

(in-package #:y2q-cl-trash/reduce-into-hash-table)

(declaim (notinline raise-error))
(defun raise-error (old-value new-value)
  "See `reduce-into-hash-table'"
  (error "hash-table already has a value ~A when adding ~A"
	 old-value new-value))

(defun reduce-into-hash-table (sequence &key (key #'identity) (value #'identity)
					  (hash-table (make-hash-table))
					  (if-exists :overwrite))
  "Sets each element in SEQUENCE into HASH-TABLE where its key and
value are calculated with KEY and VALUE respectively, and returns
HASH-TABLE.

IF-EXISTS controls what to do when there is a duplicated key:

- :overwrite :: overwrites with a new element.
- :keep-old :: keeps old one.
- :push :: uses `cl:push'.
- :error :: raises an error.
- a function :: calls it with two arguments; the old element and a new one,
                and its return value is set into HASH-TABLE.

Examples:
 (alexandria:hash-table-alist
  (reduce-into-hash-table '(1 2 3 4 5) :key #'1- :value #'princ-to-string))
  => ((2 . \"3\") (3 . \"4\") (4 . \"5\") (1 . \"2\") (0 . \"1\")) ; this ordering is unknown.

 (reduce-into-hash-table * :key #'car :value #'cdr) ; same as the `alist-hash-table'."
  (ensure-functionf key value)
  (macrolet ((reducer-lambda ((k v &optional old-val (present-p (gensym)))
			      &body body
			      &aux (obj (gensym)))
	       `(lambda (,obj)
		  (let ((,k (funcall key ,obj))
			(,v (funcall value ,obj)))
		    ,(if old-val
			 `(multiple-value-bind (,old-val ,present-p)
			      (gethash ,k hash-table)
			    ,@body)
			 `(progn ,@body)))
		  (values))))
    (let* ((rdc-overwrite
	    (reducer-lambda (k v)
	      (setf (gethash k hash-table) v)))
	   (rdc-keep-old
	    (reducer-lambda (k v)
	      (ensure-gethash k hash-table v)))
	   (rdc-push
	    (reducer-lambda (k v)
	      (push v (gethash k hash-table))))
	   (rdc-error
	    (reducer-lambda (k v old-val present-p)
	      (when present-p
		(raise-error old-val v))
	      (setf (gethash k hash-table) v)))
	   (reduce-fn
	    (case if-exists
	      (:overwrite rdc-overwrite)
	      (:keep-old rdc-keep-old)
	      (:push rdc-push)
	      (:error rdc-error)
	      (otherwise
	       (let ((merge-fn (ensure-function if-exists)))
		 (reducer-lambda (k v old-val present-p)
		   (setf (gethash k hash-table)
			 (if present-p
			     ;; I follow `reduce' convention; (funcall <accumulator> <new value>)
			     (funcall merge-fn old-val v)
			     v))))))))
      (declare (dynamic-extent . #1=(rdc-overwrite rdc-keep-old rdc-push rdc-error reduce-fn))
	       (type (function (t) t) . #1#))
      (map nil reduce-fn sequence)
      hash-table)))
