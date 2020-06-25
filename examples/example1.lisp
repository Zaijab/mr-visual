(eval-when (:compile-toplevel :load-toplevel :execute) (ql:quickload "graphics"))
(in-package #:graphics)

(defparameter *array* nil)
(defparameter *stream* nil)
(defparameter *running* nil)

;; Lisp data for triangle vertices
(defparameter *triangle-data*
   (list (list (rtg-math:v!  0.5 -0.36 0) (rtg-math:v! 0 1 0 0))
         (list (rtg-math:v!    0   0.5 0) (rtg-math:v! 1 0 0 0))
         (list (rtg-math:v! -0.5 -0.36 0) (rtg-math:v! 0 0 1 0))))

;; A struct that works on gpu and cpu
(defstruct-g pos-col
  (position :vec3 :accessor pos)
  (color :vec4 :accessor col))

;; A GPU vertex shader using a Lisp syntax (see Varjo)
(defun-g vert ((vert pos-col))
  (values (rtg-math:v! (pos vert) 1.0)
          (col vert)))

;; A GPU fragment shader
(defun-g frag ((color :vec4))
  color)

;; Composing those gpu functions into a pipeline
(defpipeline-g prog-1 ()
  (vert pos-col)
  (frag :vec4))

;; Here is what we do each frame:
(defun step-demo ()
  (step-host)        ;; Advance the host environment frame
  (livesupport:update-repl-link) ;; Keep the REPL responsive while running
  (clear)            ;; Clear the drawing buffer
  (map-g #'prog-1 *stream*) ;; Render data from GPU datastream
  (swap))            ;; Display newly rendered buffer


(defun run-loop ()
  (setf *running* t
    ;; Create a gpu array from our Lisp vertex data
        *array* (make-gpu-array *triangle-data* :element-type 'pos-col)
    ;; Create a GPU datastream
        *stream* (make-buffer-stream *array*))
  ;; continue rendering frames until *running* is set to nil
  (loop :while (and  *running*
             (not (shutting-down-p))) :do
	       (livesupport:continuable (step-demo))))

(defun stop-loop ()
  (setf *running* nil))
