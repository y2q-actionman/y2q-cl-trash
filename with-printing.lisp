(defpackage #:y2q-cl-trash/with-printing
  (:use :cl)
  (:export #:with-printing))

(in-package #:y2q-cl-trash/with-printing)

(defmacro with-printing ((&key (stream '*trace-output*)) &body body)
  "Do like `progn' except printing the result of each form in BODY to STREAM."
  (let ((stream_ (gensym "stream_"))
        (print-and-return_ (gensym "print-and-return")))
    `(let ((,stream_ ,stream))
       (declare (type stream ,stream_))
       (flet ((,print-and-return_ (&rest args)
                (declare (type list args)
                         (dynamic-extent args))
                (format ,stream_ "~&~{~A~^ ~}" args)
                (apply #'values args)))
         (declare (dynamic-extent (function ,print-and-return_))
                  (ignorable (function ,print-and-return_)))
         ,@(loop for form in body
              collect `(multiple-value-call #',print-and-return_ ,form))))))
