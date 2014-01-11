(add-to-list 'load-path "~/.emacs.d")

(load "init-env")
(load "init-key-bind")
(load "init-auto-mode")
(load "init-gui")
(load "init-el-get")
(load "init-helm")

(require 'quickrun)
(require 'auto-save-buffers)
(require 'dash-at-point)

(load "init-auto-complete")
