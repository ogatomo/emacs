(add-to-list 'load-path "~/.emacs.d/lisp")

(unless (require 'cl-lib nil t)
  (require 'cl))

(load "init-env")
(load "init-key-bind")
(load "init-auto-mode")
(load "init-gui")
(load "init-el-get")
(load "init-helm")
(load "init-helm-dash")
(load "init-region-tools")
(load "init-php-mode")
(load "init-tabbar")
(load "init-web-mode")
(load "init-guide-key")
(load "init-dired")
(load "init-google-translate")
;(load "init-persp-mode")

(require 'quickrun)
(require 'undo-tree)
(require 'auto-highlight-symbol-config)

(global-undo-tree-mode)
(global-git-gutter-mode)

(load "init-auto-complete")
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)

