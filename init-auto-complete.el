(require 'auto-complete)
(require 'auto-complete-config)

(ac-config-default)

(ac-set-trigger-key "TAB")
;;; (setq ac-auto-start nil)
(setq ac-auto-start 1)
(setq ac-candidate-max 40)

(add-to-list 'ac-modes 'objc-mode)
(global-set-key "\M-/" 'ac-start)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(setq ac-disable-faces nil)
