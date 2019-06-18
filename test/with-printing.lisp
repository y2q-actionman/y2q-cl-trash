(in-package #:y2q-cl-trash-test)

(test test-with-printing
  (let ((*trace-output* (make-broadcast-stream)))
    (is (= 3
           #1=(with-printing ()
                1
                (+ 1 2 3)
                3))))
  (is (equal (with-output-to-string (*trace-output*)
               #1#)
             "1
6
3"))
  (let ((output
         (with-output-to-string (out)
           (is (equal "hoge"
                      (with-printing (:stream out)
                        (floor 1 2)
                        (values "hoge" "fuga")))))))
    (is (equal
         output
         "0 1
hoge fuga"))))
