(defmacro exe (cmd &rest args)
  `(ext:run-program ,cmd :arguments (list ,@args)))

(defvar *PREFIX*
  (let ((v (ext:getenv "PREFIX")))
    (when (not v) "/usr")))

(format T "Using prefix: ~a.~%" *PREFIX*)

(flet ((make-path (folder) (concatenate 'string *PREFIX* folder)))
  (let ((bin (make-path "/bin/"))
        (src (make-path "/src/")))
    (dolist (file (directory "./*.lisp"))
      (let ((f (namestring file)))
        (format T "Processing ~a...~%" f)
        (exe "cp" f src)))
    (let ((od (concatenate 'string src "neoclash.lisp"))
          (do_ (concatenate 'string bin "nch")))
      (format T "Linking ~a to ~a...~%" od do_)
      (exe "ln" "-s" od do_))))
