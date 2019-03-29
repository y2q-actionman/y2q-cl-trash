(defsystem #:y2q-cl-trash
  :description "Some Common Lisp codes I've wrote as a 'utility' but rarely used even by myself."
  :license "WTFPL"
  :author "YOKOTA Yuki <y2q.actionman@gmail.com>"
  :class :package-inferred-system
  :defsystem-depends-on (:asdf-package-system)
  :depends-on (#:y2q-cl-trash/package
	       #:y2q-cl-trash/defconstant-itself
	       #:y2q-cl-trash/equal-expansion-p
	       #:y2q-cl-trash/reduce-into-hash-table))
