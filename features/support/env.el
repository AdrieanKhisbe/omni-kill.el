(require 'f)

(defvar omni-kill-support-path
  (f-dirname load-file-name))

(defvar omni-kill-features-path
  (f-parent omni-kill-support-path))

(defvar omni-kill-root-path
  (f-parent omni-kill-features-path))

(add-to-list 'load-path omni-kill-root-path)

(require 'omni-kill)
(require 'espuds)
(require 'ert)

(Setup
 ;; Before anything has run
 )

(Before
 ;; Before each scenario is run
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )
