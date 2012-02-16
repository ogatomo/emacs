;;; マークのリージョンに色を付ける
(setq transient-mark-mode t)

;;; スタートメッセージを表示しない
(setq inhibit-startup-message t)

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)

;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;;; カラムを見やすくする
(custom-set-variables '(line-number-mode t)
		      '(column-number-mode t))

(set-background-color "Black")
(set-foreground-color "White")
(set-cursor-color "Gray")

;; ウィンドウサイズの位置、サイズ
(setq initial-frame-alist
      (append (list
	       '(background-color . "Black")
	       '(foreground-color . "White")
	       '(cursor-color . "Gray")
	       )
	      initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

(if window-system (progn

  ;;; スクロールバーを非表示
  (scroll-bar-mode nil)

  ;;; スクロールを１行づつ
  (setq scroll-step 1)

  ;; タイトルバーにファイル名表示
  (setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

  ;; ウィンドウの透明化
  (add-to-list 'default-frame-alist '(alpha . (0.80 0.80)))

  ;;時刻表示
  (display-time-mode 1)
))

;;; ツールバーを非表示
(menu-bar-mode nil)

;;; 他のソフトでファイルを変更した場合に、バッファを自動再読み込み
(global-auto-revert-mode 1)

;;; キー設定
(define-key global-map "\C-t" 'other-window) ;バッファの移動をCtrl+tで行えるようにする
(define-key global-map "\C-c;" 'comment-or-uncomment-region) ;範囲選択後のコメントイン・コメントアウト切替
(define-key global-map [C-tab] 'other-frame)
(define-key global-map [S-C-tab] (lambda () (interactive) (other-frame -1)))
(define-key global-map [?¥] [?\\]) ; ¥の代わりにバックスラッシュを入力する

;; シフト + 矢印で範囲選択1
(setq pc-select-selection-keys-only t)(pc-selection-mode 1)

;; 改行後にインデント
(global-set-key "\C-m" 'newline-and-indent)

;;M-g で指定行へジャンプ
(global-set-key "\M-g" 'goto-line)

;;; 下線をつける
(setq hl-line-face 'hlline-face)
(setq hl-line-face 'underline)
(global-hl-line-mode)

;;; elisp path
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

;;; dired   -----------------------------------------------------
(defun uenox-dired-winstart ()
  "Type '\\[uenox-dired-winstart]': win-start the current line's file."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (let ((fname (dired-get-filename)))
	(call-process-shell-command (concat "/usr/bin/open \"" fname "\"")) ;;mac
        (message "opening... %s" fname)
)))

(add-hook 'dired-mode-hook
          (lambda ()
	    ; dired-mode時もバッファ切替をC-tでできるようにする
            (define-key dired-mode-map "\C-t" 'other-window)

	    ; 自在に名前変更するモード
	    (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

	    ; dired のキー割り当て追加。zキーを押すと、
	    ; Macに関連付けられたアプリケーションでファイルを開けるようにする。
	    (define-key dired-mode-map "z" 'uenox-dired-winstart)
	    )) 




;;; recentf   ---------------------------------------------------
(setq recentf-max-saved-items 1000)

;;; anything  ---------------------------------------------------
(require 'anything-startup)
(require 'recentf-ext)

(setq anything-sources (list anything-c-source-buffers
			 anything-c-source-imenu
			 anything-c-source-files-in-current-dir+
			 anything-c-source-recentf
                             ))

(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
(define-key global-map "\M-p" 'anything)

;kill-ring の最大値. デフォルトは 30.
(setq kill-ring-max 50)

;anything で対象とするkill-ring の要素の長さの最小値.
;デフォルトは 10.
(setq anything-kill-ring-threshold 20)
(global-set-key "\M-y" 'anything-show-kill-ring)
(global-set-key "\M-[" 'anything-imenu)

;;; linum --------------------------------------------------------
(require 'wb-line-number)
(global-set-key "\M-n" 'wb-line-number-toggle)

;;; php-mode ---------------------------------------------------
; C-.     : 引数リスト表示
; C-c C-f : カーソル位置の関数を調べる
; C-c RET : マニュアルのトップ
(add-to-list 'load-path (expand-file-name "~/.emacs.d/php-mode"))
(require 'php-mode)
(setq php-search-url "http://www.php.net/ja/")
(setq php-manual-url "http://www.php.net/manual/ja/")

;;; PHPのインデント設定 ----------------------------------------------
(setq php-mode-force-pear nil)

(add-hook 'php-mode-user-hook 
'(lambda () 
    (setq c-basic-offset 4)
    (setq c-tab-width 4)
    (setq c-indent-level 4)
    (setq tab-width 4)
    (setq-default tab-width 4)
))

(add-hook 'php-mode-hook '(lambda ()
    (setq c-basic-offset 4)
    (setq c-tab-width 4)
    (setq c-indent-level 4)
    (setq tab-width 4)
    (setq-default tab-width 4)
))

;;; ruby     ---------------------------------------------------
(add-to-list 'load-path (expand-file-name "~/.emacs.d/ruby"))

(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda () (inf-ruby-keys)))

(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

;;; ruby on rails -----------------------------------------------
(add-to-list 'load-path "~/.emacs.d/rinari")
(require 'rinari)

(add-to-list 'load-path "~/.emacs.d/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
    (lambda () (rinari-launch)))

(add-to-list 'auto-mode-alist '("\\.rhtml$" . rhtml-mode)) 
(add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode)) 

;;; rcodetool ---------------------------------------------------
; gem install rcodetools
; gem install fastri
; C-c C-c  : 関数・メソッド補完
; C-c C-d  : xmpfilter
; C-c C-f  : riでマニュアルを引く
(add-to-list 'load-path "~/.emacs.d/rcodetools")

(require 'rcodetools)
(require 'anything-rcodetools)

(setq rct-find-tag-if-available nil)
(setq rct-get-all-methods-command "PAGER=cat fri -l")

(defun make-ruby-scratch-buffer ()
  (with-current-buffer (get-buffer-create "*ruby scratch*")
    (ruby-mode)
    (current-buffer)))
(defun ruby-scratch ()
  (interactive)
  (pop-to-buffer (make-ruby-scratch-buffer)))
(defun ruby-mode-hook-rcodetools ()
  (define-key ruby-mode-map "\C-c\C-c" 'rct-complete-symbol)
  (define-key ruby-mode-map "\C-c\C-d" 'xmp)
  (define-key ruby-mode-map "\C-c\C-f" 'rct-ri))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)

(add-to-list 'load-path "~/.emacs.d/ri-emacs")
(setq ri-ruby-script
      (expand-file-name "~/.emacs.d/ri-emacs/ri-emacs.rb"))
(autoload 'ri "ri-ruby.el" "Execute `ri'." t)

;;; VTL Mode   ---------------------------------------------------
(autoload 'turn-on-vtl-mode "vtl" nil t)
(add-to-list 'auto-mode-alist '("\\.vm$" . turn-on-vtl-mode))

;;; ffap ---------------------------------------------------------
(ffap-bindings)
(setq ffap-newfile-prompt t)
(setq ffap-kpathsea-depth 5)

(setq ff-other-file-alist
     '(("\\.mm?$" (".h"))
       ("\\.cc$"  (".hh" ".h"))
       ("\\.hh$"  (".cc" ".C"))
       ("\\.c$"   (".h"))
       ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))
       ("\\.C$"   (".H"  ".hh" ".h"))
       ("\\.H$"   (".C"  ".CC"))
       ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
       ("\\.HH$"  (".CC"))
       ("\\.cxx$" (".hh" ".h"))
       ("\\.cpp$" (".hpp" ".hh" ".h"))
       ("\\.hpp$" (".cpp" ".c"))))

;;; auto-complete ------------------------------------------------
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complate-dict")
(ac-config-default)

(global-auto-complete-mode t)
(ac-set-trigger-key "TAB")
(setq ac-auto-start nil)
(setq ac-candidate-max 20)

;(setq ac-modes (append ac-modes '(objc-mode)))
(add-to-list 'ac-modes 'objc-mode) 
(global-set-key "\M-/" 'ac-start)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;;; Objective-C Mode ---------------------------------------------
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

(add-hook 'objc-mode-hook
          (lambda ()
	    ;; auto-complate
	    ; 自動補完
	    (define-key objc-mode-map (kbd "\t") 'ac-complete)
	    
	    ;; ffap
	    ; ヘッダーとmainファイル切り替え
	    (define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)

	    ;; xcode
	    ; 実行
            (define-key objc-mode-map "\C-c\C-r" 'run)
            (define-key objc-mode-map "\C-c\C-x" 'xcode)
            (define-key objc-mode-map "\C-c\C-d" 'doc)
            (define-key objc-mode-map "\C-c\C-c" 'comment-region)
            (define-key objc-mode-map "\C-cc"    'uncomment-region)
            (setq compilation-scroll-output t)))
(defun doc ()
	(interactive)
  (shell-command-to-string "~/.emacs.d/sh/xcode-show-doc.sh"))
(defun xcode ()
	(interactive)
  (shell-command-to-string "~/.emacs.d/sh/xcode-show-proj.sh"))
(defun run ()
  (interactive)
  (shell-command-to-string "~/.emacs.d/sh/xcode-run.sh"))

;;; yasnippet  ---------------------------------------------------
(require 'yasnippet-bundle)
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet/snippets")

;;; yaml-mode  ---------------------------------------------------
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;;; espresso-mode ------------------------------------------------
; jQueryのインデントが思うようにいかない時に使用
(add-to-list 'auto-mode-alist '("\\.js\\'" . espresso-mode))
(autoload 'espresso-mode "espresso" nil t)

;;; undo-tree  ---------------------------------------------------
; M-_     : redo
; C-x u   : undo-tree-visualize 終了はq
(when (require 'undo-tree nil t) (global-undo-tree-mode))

;;; point-undo ---------------------------------------------------
(require 'point-undo)
(define-key global-map (kbd "<f7>") 'point-undo)

;;; goto-chg.el --------------------------------------------------
(require 'goto-chg)
(define-key global-map (kbd "<f8>") 'goto-last-change)
(define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse)

;;; bm --------------------------------------------------
(setq-default bm-buffer-persistence nil)
(setq bm-restore-repository-on-load t)
(require 'bm)
(add-hook 'find-file-hooks 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)
(global-set-key (kbd "C-.") 'bm-toggle)
(global-set-key (kbd "C-:") 'bm-previous)
(global-set-key (kbd "C-;") 'bm-next)

;;; geben  -------------------------------------------------------
; mampでxdebug使う時に使用
(add-to-list 'load-path "~/.emacs.d/geben")
(autoload 'geben "geben" "DBGp protocol front-end" t)

;;; github-code-search -------------------------------------------
(require 'github-search)

;;; gist ---------------------------------------------------------
(require 'gist)
(setq gist-view-gist t)
(setq github-user "ogatomo")
(load "github-token") ; (setq github-token "xxxxxxxxxx")

;;; auto-compile -------------------------------------------------
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;;; uniquify -----------------------------------------------------
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+}")


