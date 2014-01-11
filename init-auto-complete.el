(require 'auto-complete)
(require 'auto-complete-config)
(require 'auto-complete-etags)

(ac-config-default)

(add-to-list 'ac-sources 'ac-source-etags)
(setq ac-etags-use-document t)

(defvar ac-source-etags
  '((candidates . (lambda ()
		    (all-completions ac-target (tags-completion-table))))
    (candidate-face . ac-candidate-face)
    (selection-face . ac-selection-face)
    (requires . 3))
  "etags をソースにする")

(add-hook 'ruby-mode-hook
	  (lambda ()
	    (push 'ac-source-etags ac-sources)))

(ac-set-trigger-key "TAB")
;;; (setq ac-auto-start nil)
(setq ac-auto-start 2)
(setq ac-candidate-max 40)

;(setq ac-modes (append ac-modes '(objc-mode)))
(add-to-list 'ac-modes 'objc-mode)
(global-set-key "\M-/" 'ac-start)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
