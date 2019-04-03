(in-package #:y2q-cl-trash-test)

(defconstant-itself +itself+)

(test defconstant-itself-no-doc
  (is (constantp '+itself+))
  (is (eq +itself+ '+itself+))
  (is (eq +itself+ +itself+))
  (is (null (documentation '+itself+ 'variable))))

(defconstant-itself +itself-with-doc+
    "The docstring of +itself-with-doc+")

(test defconstant-itself-with-doc
  (is (constantp '+itself-with-doc+))
  (is (eq +itself-with-doc+ '+itself-with-doc+))
  (is (eq +itself-with-doc+ +itself-with-doc+))
  (is (string= (documentation '+itself-with-doc+ 'variable)
	       "The docstring of +itself-with-doc+")))
