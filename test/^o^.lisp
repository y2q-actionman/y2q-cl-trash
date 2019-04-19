(in-package #:y2q-cl-trash-test)

(test test-^o^
  (is (string= (funcall (^o^) "Owata")
	       "Owata"))
  (is (funcall (^o^) (< 1 2 3 4))))
