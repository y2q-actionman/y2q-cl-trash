(defpackage #:y2q-cl-trash/slots-boundp
  (:use :cl)
  (:import-from #:y2q-cl-trash/package
		#:slots-boundp))

(in-package #:y2q-cl-trash/slots-boundp)

(defun slots-boundp (obj &rest slot-specs)
  "Checks one or more slots of OBJ are bound or unbound.
If a symbol specified, the symbol used for `slot-boundp' as-is.
If a list forms (not <symbol>) specified, means (not (slot-boundp OBJ <symbol>))."
  (loop for slot-spec in slot-specs
        always
        (etypecase slot-spec
          (symbol (slot-boundp obj slot-spec))
          (list
           (unless (eq (first slot-spec) 'not)
             (error "~A cannot be used for slots-boundp" slot-spec))
           (not (apply #'slot-boundp obj (rest slot-spec)))))))
