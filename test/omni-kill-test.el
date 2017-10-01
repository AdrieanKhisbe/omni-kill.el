
(ert-deftest omni-kill-helper ()
  (should (equal omni-kill-stub 2)))

(ert-deftest omni-kill-destroy-function ()
  (should (fboundp 'omni-copy-list))
  (omni-kill-destroy-all-the-things)
  (should-not (fboundp 'omni-kill))
  (should-not (fboundp 'omni-copy))
  (should-not (fboundp 'omni-select-email))
  (omni-kill-get-all-the-things))
