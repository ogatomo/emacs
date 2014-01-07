;;; 環境変数PATH設定
(dolist (dir (list
              "/usr/local/bin"
              "/usr/local/sbin"
              "/usr/local/man"
              "/usr/local/share/npm/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))

;;; rbenv設定
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
                       (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
                      (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))


(add-to-list 'load-path "~/.emacs.d/el-get")

(setq el-get-dir "~/.emacs.d/el-get-packages")
(setq el-get-recipe-path (list "~/.emacs.d/el-get-user-recipes"
                               "~/.emacs.d/el-get/recipes/emacswiki"
                               "~/.emacs.d/el-get/recipes"))
;(setq 'el-get-init-files-pattern "~/emacs/el-get-init/.*.el")

(require 'el-get)
(el-get 'sync)
