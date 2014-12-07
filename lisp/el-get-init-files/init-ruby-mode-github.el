(add-hook 'ruby-mode-hook 'yard-mode)
(add-hook 'ruby-mode-hook 'eldoc-mode)

(defun make-ruby-scratch-buffer ()
  (with-current-buffer (get-buffer-create "*ruby scratch*")
    (ruby-mode)
    (current-buffer)))

(defun ruby-scratch ()
  (interactive)
  (pop-to-buffer (make-ruby-scratch-buffer)))

(add-hook 'ruby-mode-hook
   '(lambda()
      (require 'rcodetools)
      (setq rct-find-tag-if-available nil)
      (setq rct-get-all-methods-command "PAGER=cat fri -l")

      (require 'ruby-end)
      (ruby-end-mode)
      (abbrev-mode 1)
      (electric-pair-mode t)
      (electric-indent-mode t)
      (electric-layout-mode t)
      (define-key ruby-mode-map "\C-c\C-c" 'rct-complete-symbol)
      (define-key ruby-mode-map "\C-c\C-d" 'xmp)
      (define-key ruby-mode-map "\C-c\C-f" 'rct-ri)))

