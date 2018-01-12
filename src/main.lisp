;;; main.lisp

(in-package #:hn-filter)



(defparameter *app* nil "Application instance.")



(defun main-handler (env)
  `(200
    (:content-type "text/plain")
    ("MAGIC.")))



(defun start (&key (port 5000))
  (when *app*
    (stop))
  (setf *app* (clack:clackup (lambda (env)
                               (funcall 'main-handler env))
                             :port port)))

(defun stop ()
  (clack:stop *app*)
  (setf *app* nil))

