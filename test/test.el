;;; test.el --- fibonacci test

;; Copyright (C) 2015 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>

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

(require 'ert)
(require 'fib)

(ert-deftest zero ()
  "input 0"
  (should (= (fib-elisp 0) (fib-elisp-loop 0)
             (fib-c 0) (fib-c-loop 0)
             0)))

(ert-deftest one ()
  "input 1"
  (should (= (fib-elisp 1) (fib-elisp-loop 1)
             (fib-c 1) (fib-c-loop 1)
             1)))

(ert-deftest two ()
  "input 2"
  (should (= (fib-elisp 2) (fib-elisp-loop 2)
             (fib-c 2) (fib-c-loop 2)
             1)))

(ert-deftest ten ()
  "input 10"
  (should (= (fib-elisp 10) (fib-elisp-loop 10)
             (fib-c 10) (fib-c-loop 10)
             55)))

;;; test.el ends here
