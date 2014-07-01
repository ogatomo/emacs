(add-to-list 'load-path "~/.emacs.d")

(unless (require 'cl-lib nil t)
  (require 'cl))

(load "init-env")
(load "init-key-bind")
(load "init-auto-mode")
(load "init-gui")
(load "init-el-get")
(load "init-helm")

(require 'quickrun)
;(require 'auto-save-buffers)
(require 'dash-at-point)
(require 'undo-tree)
(require 'auto-highlight-symbol-config)

(global-undo-tree-mode)
(global-git-gutter-mode)

(load "init-auto-complete")
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
