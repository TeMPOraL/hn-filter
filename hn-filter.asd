;;;; hn-filter.asd

(asdf:defsystem #:hn-filter
  :description "HN-related magic"
  :author "Jacek \"TeMPOraL\" Złydach <temporal.pl@gmail.com>"
  :license "MIT"
  :depends-on (#:hunchentoot
               #:clack
               #:spinneret
               #:lass
               #:parenscript
               #:local-time
               ;; TODO something for sqlite
               ;; TODO cl-pushover
               ;; TODO something drakma-like, but better
               )
  :serial t
  :components ((:module "src"
                        :components ((:file "package")
                                     (:file "main")))))


