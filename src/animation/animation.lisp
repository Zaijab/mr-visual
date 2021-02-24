;;;; animation.lisp
;;; Creates animations using a scene
;;; This file will handle the task of moving objects within a scene, timing the objects, and saving video files after recording.

(defclass mobject ()
  ((place :initform 0)
   (color :initform 0)))

(defparameter *bruh* (make-instance 'mobject))
(print (slot-value *bruh* 'place))

(setf (slot-value *bruh* 'place) '(100 100))
