;;; main.lisp

(in-package #:hn-filter)



(defparameter *app* nil "Application instance.")



(defun main-handler (env)
  `(200
    (:content-type "text/plain")
    ("MAGIC.")))

(defun start-web-server (&key (port 5000))
  (log:info "Starting web server on port ~A..." port)
  (when *app*
    (stop-web-server))
  (setf *app* (clack:clackup (lambda (env)
                               (funcall 'main-handler env))
                             :port port)))
(defun stop-web-server ()
  (log:info "Stopping web server...")
  (if *app*
      (clack:stop *app*)
      (log:warn "Web server wasn't running."))
  (setf *app* nil))


(defun online-update-task ()
  (log:info "Running update task.")

  ;; I want to have a task that, every now and then, pulls in HN data and launches
  ;; its analysis; potentially firing triggers like Pushover notifications.
  )

(defun start-cron ()
  (log:info "Starting internal cron...")
  ;; NOTE have a separate thread for that, or sth?
  )

(defun stop-cron ()
  (log:info "Stopping internal cron..."))


;;; Public REPL API.
(defun start (&key (port 5000))
  (start-web-server :port port))

(defun stop ()
  (stop-web-server))

