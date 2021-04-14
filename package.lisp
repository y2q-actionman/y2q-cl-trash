(uiop:define-package #:y2q-cl-trash/package
  (:use)
  (:nicknames #:y2q-cl-trash)
  (:documentation "The main package of y2q-cl-trash")
  (:reexport
   #:y2q-cl-trash/^o^
   #:y2q-cl-trash/defconstant-itself
   #:y2q-cl-trash/reduce-into-hash-table
   #:y2q-cl-trash/with-printing))
