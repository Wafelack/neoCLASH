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
(load (merge-pathnames "utils.lisp" *load-truename*))

(setq custom:*prompt-start*
      (lambda () (format NIL "(~c[1;32m~a~c[0m)~%" #\ESC (reduce-home (cd)) #\ESC)))

(setq custom:*prompt-body*
      (lambda () (setq ext:*command-index* (+ ext:*command-index* 1)) (format NIL "~c[34m<~c[1;36m~a~c[34m:" #\ESC #\ESC ext:*command-index* #\ESC)))

(setq custom:*prompt-finish*
      (lambda () (format NIL "~c[1;36m~a~c[34m>~c[0m " #\ESC (ext:package-shortest-name *package*) #\ESC #\ESC)))

(setq custom:*prompt-break*
      (lambda () (format NIL "~c[31m~a " #\ESC (ext:break-level))))
