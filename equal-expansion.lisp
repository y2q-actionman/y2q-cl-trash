(in-package :cl-scsu.test)

(declaim (inline uninterned-symbol-p))
(defun uninterned-symbol-p (x)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (and (symbolp x)
       (null (symbol-package x))))

;;; rove's `equal*' should written like this.
(defun equal-expansion (x y)
  (tree-equal x y
	      :test (lambda (x y)
		      ;; These are assumed thanks of `tree-equal'.
		      (declare (type atom x y))
		      (or (and (uninterned-symbol-p x)
			       (uninterned-symbol-p y))
			  (equal x y)))))
