;;;; graphics.asd

(asdf:defsystem #:graphics
  :description "Math Graphics Built on CEPL"
  :author "Zain Jabbar <zaijab2000@gmail.com>"
  :license  "GPL"
  :version "0.0.1"
  :serial t
  :depends-on (#:cepl #:rtg-math.vari #:cepl.sdl2 #:swank #:livesupport #:cepl.skitter.sdl2 #:dirt)
  :components ((:file "package")
	       (:file "graphics")))
