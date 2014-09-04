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
(setq display-buffer-function 'popwin:display-buffer)
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)

;; find-fileはデフォルトのものを使う
(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))
