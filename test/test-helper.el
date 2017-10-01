;; Helpers for tests

(setq omni-kill-stub 2)
(require 'undercover)
(undercover "omni-kill.el"
            (:send-report nil)
            (:report-file "/tmp/undercover-report.json"))
(require 'omni-kill)
