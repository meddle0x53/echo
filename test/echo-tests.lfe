(defmodule echo-tests
  (behaviour ltest-unit)
  (export all)
  (import
    (from ltest
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "./deps/ltest/include/ltest-macros.lfe")

(deftest echo-application-test
  "Tests the behaviour of the Echo application"
  (progn
    (application:ensure_all_started 'echo)
    (is-qual #"Hello world" (echo-world:echo #"Hello world"))
    (is-qual 5 (echo-world:echo 5))
    (is-qual 2 (echo-world:count))
    ))
