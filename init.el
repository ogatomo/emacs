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
  ;;; フレーム移動用のキーバインド
  (define-key global-map [C-tab] 'other-frame)

  ;;; スクロールバーを非表示
  (scroll-bar-mode nil)

  ;;; スクロールを１行づつ
  (setq scroll-step 1)

  ;; タイトルバーにファイル名表示
  (setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

  ;; ウィンドウの透明化
  (add-to-list 'default-frame-alist '(alpha . (0.80 0.80)))

  ;;; font
  ;; フォントセットを作る
  (let* ((fontset-name "myfonts") ; フォントセットの名前
       (size 12) ; ASCIIフォントのサイズ [9/10/12/14/15/17/19/20/...]
       (asciifont "Menlo") ; ASCIIフォント
       (jpfont "Hiragino Maru Gothic ProN") ; 日本語フォント
       (font (format "%s-%d:weight=normal:slant=normal" asciifont size))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)) 
       (fsn (create-fontset-from-ascii-font font nil fontset-name)))
  (set-fontset-font fsn 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font fsn 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font fsn 'katakana-jisx0201 jp-fontspec) ; 半角カナ
  (set-fontset-font fsn '(#x0080 . #x024F) fontspec) ; 分音符付きラテン
  (set-fontset-font fsn '(#x0370 . #x03FF) fontspec) ; ギリシャ文字
  )

  ;; デフォルトのフレームパラメータでフォントセットを指定
  (add-to-list 'default-frame-alist '(font . "fontset-myfonts"))

  ;; フォントサイズの比を設定
  (dolist (elt '(("^-apple-hiragino.*" . 1.2)
	       (".*osaka-bold.*" . 1.2)
	       (".*osaka-medium.*" . 1.2)
	       (".*courier-bold-.*-mac-roman" . 1.0)
	       (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
	       (".*monaco-bold-.*-mac-roman" . 0.9)))
  (add-to-list 'face-font-rescale-alist elt))


  ;; デフォルトフェイスにフォントセットを設定
  ;; # これは起動時に default-frame-alist に従ったフレームが
  ;; # 作成されない現象への対処
  (set-face-font 'default "fontset-myfonts")

))

;;; ツールバーを非表示
(tool-bar-mode 0)

;;; 他のソフトでファイルを変更した場合に、バッファを自動再読み込み
(global-auto-revert-mode 1)

;;; キー設定
(define-key global-map "\C-t" 'other-window) ;バッファの移動をCtrl+tで行えるようにする
(define-key global-map "\C-c;" 'comment-or-uncomment-region) ;範囲選択後のコメントイン・コメントアウト切替
(define-key global-map [?¥] [?\\]) ; ¥の代わりにバックスラッシュを入力する

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
(add-to-list 'load-path "~/.emacs.d/ruby-mode")
(require 'ruby-mode)

(autoload 'ruby-mode "ruby-mode"
   "Mode for editing ruby source files" t)
(setq auto-mode-alist
   (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                interpreter-mode-alist))

(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

;;; rvm      --------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/rvm")
(require 'rvm)
(rvm-use-default)

;;; ruby-debug --------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/ruby-debug-extra/emacs")
(require 'rdebug)

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
(add-to-list 'load-path "~/.emacs.d/popup")
(add-to-list 'load-path "~/.emacs.d/auto-complete")
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
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
;(setq yas/snippet-dirs '("~/.emacs.d/snippets" "~/.emacs.d/extras/imported"))
;(setq yas/snippet-dirs '("~/.emacs.d/yasnippet/snippets" "~/.emacs.d/extras/imported"))
(setq yas/snippet-dirs '("~/.emacs.d/yasnippet/snippets" "~/.emacs.d/yasnippets-rspec/rspec-snippets"))
(yas/global-mode 1)

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
(global-set-key (kbd "C-,") 'bm-toggle)
(global-set-key (kbd "C-:") 'bm-previous)
(global-set-key (kbd "C-;") 'bm-next)

;;; geben  -------------------------------------------------------
; mampでxdebug使う時に使用
(add-to-list 'load-path "~/.emacs.d/geben")
(autoload 'geben "geben" "DBGp protocol front-end" t)

;;; magit --------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/magit")
(require 'magit)
(require 'magit-svn)
(require 'magit-topgit)
(require 'magit-stgit)

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

;;; cedet -------------------------------------------------------------
(load-library "cedet")

;;; twitting-mode -----------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/twittering-mode")
(autoload 'twit "twittering-mode" nil t)
(setq twittering-icon-mode t)
(setq twittering-jojo-mode t)
(defun twittering-mode-hook-func ()
  (set-face-bold-p 'twittering-username-face t)
  (set-face-foreground 'twittering-username-face "DeepSkyBlue3")
  (set-face-foreground 'twittering-uri-face "gray50")
  (define-key twittering-mode-map (kbd "<") 'my-beginning-of-buffer)
  (define-key twittering-mode-map (kbd ">") 'my-end-of-buffer)
  (define-key twittering-mode-map (kbd "F") 'twittering-favorite))

(add-hook 'twittering-mode-hook 'twittering-mode-hook-func)

; OAuth
;(setq twittering-oauth-access-token-alist
;       '(("oauth_token" . "トークン文字列")
;         ("oauth_token_secret" . "トークン文字列")
;         ("user_id" . "自分のユーザID")
;         ("screen_name" . "自分のスクリーンネーム")))
(load "twittering-oauth-access-token")

;;; flymake -----------------------------------------------------
(when (require 'flymake nil t)
  (global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)
  ;; PHP
  (when (not (fboundp 'flymake-php-init))
    (defun flymake-php-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "php" (list "-f" local-file "-l"))))
    (setq flymake-allowed-file-name-masks
          (append
           flymake-allowed-file-name-masks
           '(("\.php[345]?$" flymake-php-init))))
    (setq flymake-err-line-patterns
          (cons
           '("\(\(?:Parse error\|Fatal error\|Warning\): .*\) in \(.*\) on line \([0-9]+\)" 2 3 nil 1)
           flymake-err-line-patterns)))
  ;; JavaScript
  (when (not (fboundp 'flymake-javascript-init))
    (defun flymake-javascript-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "/usr/local/bin/jsl" (list "-process" local-file))))
    (setq flymake-allowed-file-name-masks
          (append
           flymake-allowed-file-name-masks
           '(("\.json$" flymake-javascript-init)
             ("\.js$" flymake-javascript-init))))
    (setq flymake-err-line-patterns
          (cons
           '("\(.+\)(\([0-9]+\)): \(?:lint \)?\(\(?:Warning\|SyntaxError\):.+\)" 1 2 nil 3)
           flymake-err-line-patterns)))

  (add-hook 'php-mode-hook
            '(lambda () (flymake-mode t)))
  (add-hook 'js-mode-hook
            (lambda () (flymake-mode t))))

;;; flymake-ruby -----------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/flymake-ruby")
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; navi2ch
(add-to-list 'load-path "~/.emacs.d/navi2ch")
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

;; popwin
(add-to-list 'load-path "~/.emacs.d/popwin")
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;; direx
(add-to-list 'load-path "~/.emacs.d/direx")
(require 'direx)
(push '(direx:direx-mode :position left :width 25 :dedicated t) popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

;; nxml
(setq auto-mode-alist (cons '("\.xaml$" . nxml-mode) auto-mode-alist))

;; csharp-mode
(add-to-list 'load-path "~/.emacs.d/csharp-mode")
(require 'csharp-mode)

;; ecb
(add-to-list 'load-path "~/.emacs.d/ecb")
(require 'ecb)
(setq stack-trace-on-error t)
(setq ecb-tip-of-the-day nil)
(setq ecb-windows-width 0.25)
(defun ecb-toggle ()
  (interactive)
  (if ecb-minor-mode
      (ecb-deactivate)
    (ecb-activate)))
(global-set-key [f2] 'ecb-toggle)

(define-key ecb-mode-map (kbd "C-c 1") 'ecb-goto-window-directories)
(define-key ecb-mode-map (kbd "C-c 2") 'ecb-goto-window-sources)
(define-key ecb-mode-map (kbd "C-c 3") 'ecb-goto-window-methods)
(define-key ecb-mode-map (kbd "C-c 4") 'ecb-goto-window-history)
(define-key ecb-mode-map (kbd "C-c 5") 'ecb-goto-window-compilation)
(define-key ecb-mode-map (kbd "C-c 0") 'ecb-goto-window-edit1)
