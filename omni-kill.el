;;; omni-kill.el --- Kill them all the things

;; Copyright (C) 2014  Adrien Becchis

;; Author: Adrien Becchis <adriean.khisbe@live.fr>
;; Created:  2014-09-06
;; Version: 0.1
;; Keywords: convenience, languages, tools

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

;; `ok' is the namespace for internal function that are not part of the
;; public api of the mode.

;;; Code:

(require 'thingatpt)

;; ¤> thing at point wrappers
;; §todo: select thing at pt

;; kill-thing at point

(defun ok:kill-thing-at-point (thing)
  "Kill the THING at point if any.

Returns nil."
  (let ((frontier (bounds-of-thing-at-point thing) ))
    ;; §later: try catch error?
    (if frontier
	 (kill-region (car frontier) (cdr frontier))
	(message "There is not a %s at point!" thing))
    ;; §check if can be chained.
    nil))

(defun ok:delete-thing-at-point (thing)
  "Delete the THING at point if any.

Returns nil."
  (let ((frontier (bounds-of-thing-at-point thing) ))
    ;; §later: try catch error?
    (if frontier
	 (delete-region (car frontier) (cdr frontier))
	(message "There is not a %s at point!" thing))
    nil))

(defun ok:copy-thing-at-point (thing)
  "Try to copy the THING at point.  (use kill-new for now)

Returns the value grabed, otherwise nil."
  ;; §later: reconsider signature? (send the catch?)
  (let ((the-thing (thing-at-point thing) ))
    ;; §later: try catch error?
    (if the-thing
	(progn
	 (kill-new the-thing)
	 (message "%s was copied" thing)
	 the-thing)
      (progn
	(message "There is not a %s at point!" thing)
	     nil))))

;; §later:  make it in the clipboard.

;; §see: clipboard function: clipboard-yank, etc!!!!!
;; §see: xsel


;; §later: store-thing..
;; ¤> functions
;; §then: macro generate all the functions!

(defmacro ok:generate-all-the-fun (thing)
 (let ((symb (eval thing)))
  `(progn
     (defun ,(intern (format "omni-copy-%s" symb)) ()
       (interactive)
       ,(format "Copy the %s at point"  symb)
       (ok:copy-thing-at-point ',symb))

     (defun ,(intern (format "omni-delete-%s" symb)) ()
       (interactive)
       ,(format "Delete the %s at point"  symb)
       (ok:delete-thing-at-point ',symb))

     (defun ,(intern (format "omni-kill-%s" symb)) ()
       (interactive)
       ,(format "Kill the %s at point"  symb)
       (ok:kill-thing-at-point ',symb))
    )))
;; §name: maybe copy-this-THING rather than omny-copy? [user choice?]

(defun ok:get-all-the-things()
  "Generate all the omni functions for the list of things."
  ;; §tofix: eager macro expansion failure
  ;; §wtf: does not happ when manually load.
  (mapc (lambda (arg) (ok:generate-all-the-fun arg))
	'(url line sentence)))
;; §maybe user custom for list?


(defun copy-url()
  (interactive)
  ;; ¤proto §todo: check if url first
  ;; make it in the clipboard.
  ;; §see: clipboard function: clipboard-yank, etc!!!!!
  ;; §see: xsel
  (ok:copy-thing-at-point 'url))

;; §tmp. for testing issue. then consider how to create then à la chain!!
(defun delete-url()
  (interactive)
  (ok:delete-thing-at-point 'url))

(defun kill-url()
  (interactive)
  (ok:kill-thing-at-point 'url))

(provide 'omni-kill)
;;; omni-kill.el ends here
