;;;; mr-visual.asd

(asdf:defsystem #:mr-visual
  :description "Math Graphics Built on CEPL"
  :author "Zain Jabbar <zaijab2000@gmail.com>"
  :license  "GPL"
  :version "0.0.1"
  :serial t
  :depends-on (#:cepl #:rtg-math.vari #:cepl.sdl2 #:swank #:livesupport #:cepl.skitter.sdl2 #:dirt)
  :components ((:file "package")
	       (:file "mr-visual")))
