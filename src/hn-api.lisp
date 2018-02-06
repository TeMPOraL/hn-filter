;;;; Wrapping up of HN's REST API to into Lisp functions.

(in-package #:hn-filter)



(defparameter +api-endpoint+ "https://hacker-news.firebaseio.com/v0/")


;;; Item model

(defmacro define-item-accessors (&body accessors)
  (flet ((descriptor-to-definition (descriptor)
           (let ((fun-name (if (consp descriptor) (car descriptor) descriptor))
                 (prop-name (if (consp descriptor) (cadr descriptor) descriptor)))
             `(defun ,(alexandria:symbolicate 'item '- fun-name) (item)
                (cdr (assoc ,(string-downcase prop-name) (cdr item) :test #'equal))))))
    `(progn
       ,@(mapcar #'descriptor-to-definition accessors))))

(define-item-accessors
  (author "by")
  (total-descendant-count "descendants")
  (children "kids")
  text
  time
  url
  type)

(defun itemp (item)
  (and (consp item)
       (eq (car item)
           :obj)))

(defun item-story-p (item)
  (equal (item-type item) "story"))

(defun item-comment-p (item)
  (equal (item-type item) "comment"))

(defun item-selfpost-p (item)
  (and (item-text item)
       (not (item-url item))
       (item-story-p item)))

(defun item-regular-story-p (item)
  (and (not (item-text item))
       (item-url item)
       (item-story-p item)))


;;; HN network API

(defun hn/get-top-item-id ()
  "Get the ID of the current top item on HN."
  (parse-integer (hn/impl/get "maxitem")))

(defun hn/get-top-stories-ids ()
  (jsown:parse (hn/impl/get "topstories")))

(defun hn/get-latest-ask-stories-ids ()
  (jsown:parse (hn/impl/get "askstories")))

(defun hn/get-latest-show-stories-ids ()
  (jsown:parse (hn/impl/get "showstories")))

(defun hn/get-item-details (item-id)
  (jsown:parse (hn/impl/get (concatenate 'string "item/" (princ-to-string item-id)))))


;;; Lower-level functions

(defun hn/impl/get (resource)
  (dexador:get (concatenate 'string +api-endpoint+ resource ".json")))

