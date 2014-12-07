;;; el-get
(add-to-list 'load-path "~/.emacs.d/lisp/el-get")

(setq el-get-dir "~/.emacs.d/lisp/el-get-packages")
(setq el-get-recipe-path (list "~/.emacs.d/lisp/el-get-user-recipes"
			       "~/.emacs.d/lisp/el-get/recipes/emacswiki"
			       "~/.emacs.d/lisp/el-get/recipes"))
(setq el-get-user-package-directory "~/.emacs.d/lisp/el-get-init-files/")

(setq el-get-byte-compile nil)
(setq el-get-byte-compile-at-init nil)

(require 'el-get)

(el-get 'sync)
