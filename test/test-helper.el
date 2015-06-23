;; Helpers for tests

(setq omni-kill-stub 2)
(undercover "*.el" "omni-kill/*.el"
            (:exclude "*-test.el")
            (:send-report nil)
            (:report-file "/tmp/undercover-report.json"))
