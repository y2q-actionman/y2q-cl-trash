(defpackage #:y2q-cl-trash/map-into-hash-table
  (:use :cl)
  (:import-from #:y2q-cl-trash/package
		#:map-into-hash-table))	; This symbol is defined.

(in-package #:y2q-cl-trash/map-into-hash-table)

(declaim (inline use-new))
(defun use-new (_old-value new-value)
  (declare (ignore _old-value))
  new-value)

(declaim (inline keep-old))
(defun keep-old (old-value _new-value)
  (declare (ignore _new-value))
  old-value)

(defun merge-push (old-value new-value)
  (list* new-value
	 (if (listp old-value)
	     old-value
	     (list old-value))))

(defun raise-error (old-value new-value)
  (error "hash-table already has a value ~A when adding ~A"
	 old-value new-value))

(defun map-into-hash-table (list &key (key #'identity) (value #'identity)
				   (hash-table (make-hash-table))
				   (if-exists :overwrite))
  (loop with merge-fn = (case if-exists
			  (:overwrite #'use-new)
			  (:keep-old #'keep-old)
			  (:push #'merge-push)
			  (:error #'raise-error)
			  (otherwise if-exists))
     for i in list
     as k = (funcall key i)
     as v = (funcall value i)
     do (multiple-value-bind (old-val present-p)
	    (gethash k hash-table)
	  (setf (gethash k hash-table)
		(if present-p
		    ;; I follow `reduce' convention; (funcall <accumulator> <new value>)
		    (funcall merge-fn old-val v)
		    v))))
  hash-table)
