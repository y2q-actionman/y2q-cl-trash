(defpackage #:y2q-cl-trash/with-printing
  (:use :cl)
  (:import-from #:y2q-cl-trash/package
		#:with-printing)) ; This will be defined.

(in-package #:y2q-cl-trash/with-printing)

(defvar *with-printing-output-stream*
  *trace-output*
  "An output stream used by `with-printing'")

(defun print-and-return (&rest args)
  "Called by `with-printing' to print ARGS into STREAM and return ARGS as mutiple values."
  (format *with-printing-output-stream* "~&~{~A~^ ~}~%" args)
  (apply #'values args))

(defmacro with-printing ((&key (stream '*with-printing-output-stream* stream-supplied-p)
                               (print-function ''print-and-return))
                         &body body)
  ;; TODO: add docstring.
  (let ((func_ (gensym "func_")))
    `(let ((,func_ ,print-function)
           ,@(if stream-supplied-p
                 `((*with-printing-output-stream* ,stream))))
       ,@(loop for form in body
            collect `(multiple-value-call ,func_ ,form)))))
