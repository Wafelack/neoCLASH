(defmacro exe (cmd &rest args)
  `(ext:run-program ,cmd :arguments (list ,@args)))

(exe "echo" "Hello, World !")
