(in-package :cl-scsu.test)

(declaim (inline uninterned-symbol-p))
(defun uninterned-symbol-p (x)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (and (symbolp x)
       (null (symbol-package x))))

;;; rove's `equal*' should written like this.
(defun equal-expansion (x y)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (flet ((equal-or-uninterned-symbol (x y)
	   (declare (type atom x y)) ; These are assumed thanks of `tree-equal'.
	   (or (and (uninterned-symbol-p x)
		    (uninterned-symbol-p y))
	       (equal x y))))
    (declare (dynamic-extent (function equal-or-uninterned-symbol)))
    (tree-equal x y :test #'equal-or-uninterned-symbol)))
