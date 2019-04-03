(in-package :cl-user)

(setf ^ 'lambda)
(defun ^o^ () (lambda (^o^) ^o^))
(defun ^ (o ^) (lambda (^o^) `(,(funcall o ^) ,^o^)))


(setf ^ '^)
(defun ^o^ () (lambda (^o^) `(,^o^ (^o^) ,^o^)))
(defun ^ (o ^) (lambda (^o^) `(,^o^ ,(funcall o ^) ,^o^)))


((lambda (x) (list x (list (quote quote) x)))
 (quote (lambda (x) (list x (list (quote quote) x)))))

((lambda (^o^) `(,^o^ ,`',^o^))
 '(lambda (^o^) `(,^o^ ,`',^o^)))
