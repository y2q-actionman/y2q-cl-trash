(defsystem :y2q-cl-trash-test
  :description "Tests for y2q-cl-trash"
  :license "WTFPL"
  :author "YOKOTA Yuki <y2q.actionman@gmail.com>"
  :depends-on (#:y2q-cl-trash #:1am)
  :pathname #. (make-pathname :directory '(:relative "test"))
  :components ((:file "package")
	       (:module "tests"
		:pathname ""
		:depends-on ("package")
		:serial nil
		:components
		((:file "^o^")
		 (:file "defconstant-itself")
                 (:file "with-printing"))))
  :perform (prepare-op :before (o c)
             (set (find-symbol* :*tests* '#:1am) '()))
  :perform (test-op (o s)
		    (symbol-call '#:1am '#:run)))
