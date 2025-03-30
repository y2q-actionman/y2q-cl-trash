(defpackage #:y2q-cl-trash/equal-expansion-p
  (:use :cl)
  (:export #:uninterned-symbol-p
	   #:equal-or-both-uninterned-symbol-p
	   #:equal-expansion-p))

(in-package #:y2q-cl-trash/equal-expansion-p)

(declaim (inline uninterned-symbol-p))
(defun uninterned-symbol-p (x)
  (declare (optimize (speed 3) (safety 0)))
  (and (symbolp x)
       (null (symbol-package x))))

(declaim (inline equal-or-both-uninterned-symbol))
(defun equal-or-both-uninterned-symbol-p (x y)
  (declare (optimize (speed 3) (safety 0)))
  (declare (type atom x y)) ; These are assumed thanks of `tree-equal'.
  (or (and (uninterned-symbol-p x)
	   (uninterned-symbol-p y))
      (equal x y)))

;;; same functionality with rove's `equal*'.
(defun equal-expansion-p (x y)
  (declare (optimize (speed 3)))
  (tree-equal x y :test #'equal-or-both-uninterned-symbol-p))
