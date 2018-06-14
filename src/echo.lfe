(defmodule echo
  "
  OTP application with one supervisor, supervising only one worker.

  This application is an example of a project created with `mix_lfe`
  It can be started with `(application:ensure_all_started 'echo)`.
  "
  (behaviour application)
  (export (start 2) (stop 1)))

(defun start (type start-args)
  "Starts the application"
  (echo-sup:start_link))

(defun stop (state)
  "Stops the application"
  'ok)
