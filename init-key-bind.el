;;; キー設定
(define-key global-map "\C-t" 'other-window) ;バッファの移動をCtrl+tで行えるようにする
(define-key global-map "\C-c;" 'comment-or-uncomment-region) ;範囲選択後のコメントイン・コメントアウト切替
(define-key global-map "\C-ci" 'indent-region)
(define-key global-map [?¥] [?\\]) ; ¥の代わりにバックスラッシュを入力する

;; 改行後にインデント
(global-set-key "\C-m" 'newline-and-indent)

;;M-g で指定行へジャンプ
(global-set-key "\M-g" 'goto-line)

;;; init.el再読込用
(global-set-key [f12] 'eval-buffer)

(add-hook 'dired-mode-hook
          (lambda ()
            ; dired-mode時もバッファ切替をC-tでできるようにする
            (define-key dired-mode-map "\C-t" 'other-window)

            ; 自在に名前変更するモード
            (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

            ; dired のキー割り当て追加。zキーを押すと、
            ; Macに関連付けられたアプリケーションでファイルを開けるようにする。
            (define-key dired-mode-map "z" 'dired-open-mac)

            ; dired のキー割り当て追加。_キーを押すと、
            ; Terminalでディレクトリまでcdして開けるようにする。
            (define-key dired-mode-map "_" 'dired-open-mac-terminal)

            ; SublimeText2で開く
            (define-key dired-mode-map "." 'dired-open-mac-sublime-text)

            ; ファイル作成
            (define-key dired-mode-map "c" 'dired-create-file)
            ))

;;; helm
(global-set-key (kbd "C-c p") 'helm-ls-git-find-files)
(global-set-key "\M-p" 'helm-mini)
(global-set-key "\M-y" 'helm-show-kill-ring)
(global-set-key "\M-i" 'helm-imenu)

;;; dash
(global-set-key "\C-cd" 'dash-at-point)
