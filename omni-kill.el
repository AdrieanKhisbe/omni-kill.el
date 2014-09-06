;;; omni-kill.el --- Kill them all the things

;; Copyright (C) 2014  Adrien Becchis

;; Author: Adrien Becchis <adriean.khisbe@live.fr>
;; Created:  2014-09-06
;; Version: 0.1
;; Keywords: convenience, editing, tools

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

(defgroup omni-kill nil
    "Commands to kill/delete/copy/younameit all the things at point."
    :group 'editing)

(defcustom omni-kill-thing-list
  '(symbol list sexp defun filename url email word sentence whitespace line number page )
  "List of THING symbols for which omni kill will create a fonction"
  :type '(repeat symbol)
  :group 'omni-kill)

(defcustom omni-kill-naming-scheme
  "omni-%s-%s"
  "Naming pattern of generated patters.
The first placeholder correspond to the action, the second to the thing.

Changing this would only have effect at next startup."
  :type 'string ; §check (function  )
  :group 'omni-kill)


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

(defun ok:select-thing-at-point (thing)
  ;; ¤note: similar to mark...
  "Select the THING at point if any.

Returns nil."
  (let ((frontier (bounds-of-thing-at-point thing) ))
    ;; §later: try catch error?
    (if frontier
	(progn
	  (push-mark) ; save old mark
	  (set-mark (car frontier))
	  (goto-char  (cdr frontier)))
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


;;; ¤> Function generators
(defun ok:generate-all-the-fun (thing)
  "Generate all the functions associated with the given THING"
  (ok:generate-copy-command thing)
  (ok:generate-delete-command thing)
  (ok:generate-kill-command thing)
  (ok:generate-select-command thing))
;; §name: maybe copy-this-THING rather than omny-copy? [user choice?]


;; §maybe: macro generate the macro... ^^
(defmacro ok:generate-copy-command (symb)
  "Generate a copy command for the given SYMB."
 `(defun ,(intern (format omni-kill-naming-scheme "copy" (eval symb))) ()
       ,(format "Copy the %s at point" (eval symb))
       (interactive)
       (ok:copy-thing-at-point ',(eval symb))))

(defmacro ok:generate-delete-command (symb)
  "Generate a delete command for the given SYMB."
  `(defun ,(intern (format omni-kill-naming-scheme "delete" (eval symb))) ()
       ,(format "Delete the %s at point"  (eval symb))
       (interactive)
       (ok:delete-thing-at-point ',(eval symb))))

(defmacro ok:generate-kill-command ( symb)
  "Generate a kill command for the given SYMB."
  `(defun ,(intern (format omni-kill-naming-scheme "kill" (eval symb))) ()
     ,(format "Kill the %s at point"  (eval symb))
     (interactive)
     (ok:kill-thing-at-point ',(eval symb))))

(defmacro ok:generate-select-command ( symb)
  "Generate a select command for the given SYMB."
  `(defun ,(intern (format omni-kill-naming-scheme "select" (eval symb))) ()
     ,(format "Select the %s at point"  (eval symb))
     (interactive)
     (ok:select-thing-at-point ',(eval symb))))


(defun ok:get-all-the-things()
  "Generate all the omni functions for the list of things."
  ;; §tofix: eager macro expansion failure
  ;; §wtf: does not happ when manually load.
  (mapc (lambda (arg) (ok:generate-all-the-fun arg))
	omni-kill-thing-list))
;; §maybe user custom for list?



;; set up all commands:
(ok:get-all-the-things)

(provide 'omni-kill)
;;; omni-kill.el ends here
