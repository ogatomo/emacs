;;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get")

(setq el-get-dir "~/.emacs.d/el-get-packages")
(setq el-get-recipe-path (list "~/.emacs.d/el-get-user-recipes"
                               "~/.emacs.d/el-get/recipes/emacswiki"
                               "~/.emacs.d/el-get/recipes"))
(setq el-get-user-package-directory "~/.emacs.d/el-get-init-files/")

(require 'el-get)

(el-get 'sync)
