(ert-deftest omni-kill-run-test ()
  (should (equal (+ 2 2) 4)))


(ert-deftest omni-kill-helper ()
  (should (equal omni-kill-stub 2)))
