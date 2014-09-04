;; helm-dash
(setq helm-dash-docsets-path (expand-file-name "~/.docset"))
(setq helm-dash-min-lengh 0)

;; 
(defun my-helm-dash-php-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("PHP" "CSS")))

(add-hook 'php-mode-hook 'my-helm-dash-php-doc)
