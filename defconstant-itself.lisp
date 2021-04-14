(defpackage #:y2q-cl-trash/defconstant-itself
  (:use :cl)
  (:export #:defconstant-itself))

(in-package #:y2q-cl-trash/defconstant-itself)

(defmacro defconstant-itself (name &optional docstring)
  "Defines a constant variable named by NAME and its value is set to NAME too.
This macro is intended to make a kind of package-local keywords."
  `(defconstant ,name ',name ,docstring))
