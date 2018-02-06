;;; TODO
(in-package #:hn-filter)

;;; NOTE IDs are treated as opaque strings.

;;; OK, so the goal of everything here is the following:
;;; - use an API to get all the interesting stories and comments
;;; -- not sure about definition of "interesting" - just top stories and top comments?
;;; - store them in a database
;;; - throw them through a filter
;;; - display a customized front page from them

;;; We'll probably need a queue to run requests over.
;;; Results get processed and later shoved into the database maybe.
;;; We can keep an in-memory database for a single story.
;;; We can run each request synchronously, giving a relatively natural rate limiting.

;;; The question is, when to reprocess stories?
;;; If no. descendants changed, means it might be worth it to recursively reprocess.

;;; We do however need a database so that we can view the interesting things on the site
;;; without hitting HN.

;;; We can actually trigger HN rescanning every hour or something; should be enough time to process
;;; 20 stories.
;;; On Galactica we get ~15 seconds per 100 items.



(defparameter *last-processed-item-no* 0) ;XXX do we even need this?


;;; HN processing API

(defun process-hn ()
  "Entry point to the processing chain."

  (log:info "HN processing task starting.")

  ;; TODO error handling.
  (let ((top-stories (hn/get-top-stories-ids))
        (top-asks (hn/get-latest-ask-stories-ids))
        (top-shows (hn/get-latest-show-stories-ids))))

  (log:info "HN processing task complete.")
  
  )
