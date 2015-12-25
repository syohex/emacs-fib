;;; fib.el --- fibonacci C and Emacs Lisp implementation

;; Copyright (C) 2015 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/syohex/
;; Version: 0.01

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'cl-lib)
(require 'fib-core)

(defun fib-elisp (n)
  (if (<= n 1)
      n
    (+ (fib-elisp (1- n)) (fib-elisp (- n 2)))))

(defun fib-elisp-loop (n)
  (cl-loop for a = 0 then b
           and b = 1 then (+ a b)
           repeat n
           finally return a))

;;;###autoload
(defun fib-bench (n count)
  (interactive
   (list (read-number "Fibonacci number: ")
         (read-number "Benchmark count: ")))
  (benchmark count `(fib-c ,n))
  (benchmark count `(fib-c-loop ,n))
  (benchmark count `(fib-elisp ,n))
  (benchmark count `(fib-elisp-loop ,n)))

(provide 'fib)

;;; fib.el ends here
