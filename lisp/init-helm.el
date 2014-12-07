;;; init-helm.el
(require 'helm)
(require 'helm-config)
(require 'helm-ring)
(require 'helm-ls-git)
(require 'popwin)

(helm-mode 1)
(custom-set-variables
 '(helm-buffer-max-length 120)
 '(helm-idle-delay 0.05)
 '(helm-input-idle-delay 0.05))

;; 自動補完を無効
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
;; C-hでバックスペースと同じように文字を削除
(define-key helm-c-read-file-map (kbd "C-h") 'delete-backward-char)
;; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定することも可能
(define-key helm-c-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;; popwin
;(setq display-buffer-function 'popwin:display-buffer)
;(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)

;; find-fileはデフォルトのものを使う
(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))

;; gtags設定
(require 'helm-gtags)          
(add-hook 'go-mode-hook (lambda () (helm-gtags-mode)))
(add-hook 'python-mode-hook (lambda () (helm-gtags-mode)))  
(add-hook 'ruby-mode-hook (lambda () (helm-gtags-mode)))                         
(setq helm-gtags-path-style 'root)                       
(setq helm-gtags-auto-update t)
(add-hook 'helm-gtags-mode-hook
          '(lambda ()                                                                   
             (local-set-key (kbd "M-g") 'helm-gtags-dwim)
             (local-set-key (kbd "M-s") 'helm-gtags-show-stack)
             (local-set-key (kbd "M-p") 'helm-gtags-previous-history)
             (local-set-key (kbd "M-n") 'helm-gtags-next-history)))

