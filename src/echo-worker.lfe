(defmodule echo-worker
  "
  Very simple worker process, which implements the `gen_server` behaviour.

  It has two client functions:
  1. `echo 1` : Sends a message to the `echo-worker` process. The process just returns it and incremets its call counter.
  2. `count`  : Retrieves the call counter kept in the state of the process.
  "
  (behaviour gen_server)
  (export (echo 1) (count 0))
  (export (start_link 0) (init 1) (handle_call 3) (handle_cast 2)
          (handle_info 2) (terminate 2) (code_change 3)))

;; client

(defun echo (msg)
  "
  Sends a message to the `echo-worker` process.
  The process just returns it and incremets its call counter.
  "
  (gen_server:call 'echo-worker `#(echo ,msg)))

(defun count ()
  "Retrieves the call counter kept in the state of the process."
  (gen_server:call 'echo-worker 'count))

;; Record representing the state of the process

(defrecord state (calls 0))

;; callbacks

(defun start_link ()
  (: gen_server start_link
    (tuple 'local 'echo-worker) 'echo-worker (list) (list)))

(defun init (args)
  (tuple 'ok (make-state calls 0)))

(defun handle_call
  ((`#(echo ,msg) _from state)
    (let* ((new-count (+ (state-calls state) 1))
           (new-state (set-state-calls state new-count)))
      `#(reply ,msg ,new-state)))
  (('count _from state)
      `#(reply ,(state-calls state) ,state)))

(defun handle_cast (msg state)
  (tuple 'noreply state))

(defun handle_info (info state)
  (tuple 'noreply state))

(defun terminate (reason state)
  'ok)

(defun code_change (old-vers state extra)
  (tuple 'ok state))
