;;    neoCLASH - CLASH taken to the next level
;;  Copyright (C) 2021  Wafelack <wafelack@riseup.net>
;;
;;  neoCLASH is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  neoCLASH is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU General Public License for more details.
;;
;;  You should have received a copy of the GNU General Public License
;;  along with neoCLASH.  If not, see <https://www.gnu.org/licenses/>.

(defvar *expansion-start* #\$)

(defun read-turn (stream)
  (setf (readtable-case *readtable*) :preserve)
  (let ((c (peek-char T stream)))
    (if (char= c #\})
      (progn
        (read-char stream T NIL T) ;; Consume #\}
        '())
      (if (char= c *expansion-start*)
        (progn
          (setf (readtable-case *readtable*) :upcase)
          (read-char stream T NIL T) ;; Consume *expansion-start*
          (let ((exp (read stream T NIL T)))
            (append (list exp) (read-turn stream))))
        (let ((v (read stream T NIL T)))
          (append (list (princ-to-string v)) (read-turn stream)))))))

(set-dispatch-macro-character #\# #\{
                              (lambda (stream char1 char2)
                                (declare (ignore char1 char2))
                                (setf (readtable-case *readtable*) :preserve)
                                (let ((cmd (read stream)))
                                  (setf (readtable-case *readtable*) :upcase)
                                  (list 'ext:run-program (princ-to-string cmd) :arguments (append '(list) (read-turn stream))))))
