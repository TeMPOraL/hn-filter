;;;; hn-filter.asd

(asdf:defsystem #:hn-filter
  :description "HN-related magic"
  :author "Jacek \"TeMPOraL\" Złydach <temporal.pl@gmail.com>"
  :license "MIT"
  :depends-on (#:log4cl
               #:hunchentoot
               #:clack
               #:spinneret
               #:lass
               #:parenscript
               #:local-time
               #:dexador
               #:jsown
               ;; TODO something for sqlite
               ;; TODO cl-pushover
               ;; TODO something for testing?
               )
  :serial t
  :components ((:module "src"
                        :components ((:file "package")
                                     (:file "hn-api")
                                     (:file "hn-processor")
                                     (:file "main")))))


