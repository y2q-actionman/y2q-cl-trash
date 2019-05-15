(defpackage #:y2q-cl-trash/^o^
  (:use :cl)
  (:import-from #:y2q-cl-trash/package
		#:^o^)) ; This will be defined.

(in-package #:y2q-cl-trash/^o^)

(defun ^o^ ()
  "Makes a function behaves same as `cl:identity'
  (This function is intended to show a smile '(^o^)' in your code.)"
  (lambda (^o^) ^o^))

;;; (funcall (^o^) "I do not export symbols below.")

(defun ^ (o ^)
  "Hmm.. what is this?
  (This function is intended to show a smile '(^ o ^)' in the slime-autodoc.)"
  (/ ^ o ^))

(defparameter *quine*
  ((lambda (^o^) `(,^o^ ,`',^o^))
   '(lambda (^o^) `(,^o^ ,`',^o^)))
  "The famous quine.")

(defun Y (w)
  "The famous Y combinator."
  ((lambda (^o^) (funcall ^o^ ^o^))
   (lambda (^o^)
     (funcall w (lambda (&rest orz)
		  (apply (funcall ^o^ ^o^) orz))))))
