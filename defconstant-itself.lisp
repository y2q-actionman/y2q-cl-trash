(defpackage #:y2q-cl-trash/defconstant-itself
  (:use :cl)
  (:import-from #:y2q-cl-trash/package
		#:defconstant-itself)) ; This symbol will be defined.

(in-package #:y2q-cl-trash/defconstant-itself)

(defmacro defconstant-itself (name &optional docstring)
  "Defines a constant variable named by NAME and its value is set to NAME too.

This macro is intended to make a kind of a package-local keyword."
  `(defconstant ,name ',name ,docstring))
