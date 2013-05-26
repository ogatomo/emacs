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
		      '(column-number-mode t)
                      '(menu-bar-mode nil)
                      '(tool-bar-mode 0))

;;; ウインドウ分割時に画面外へ出る文章を折り返す
(setq truncate-partial-width-windows nil)

;;; デフォルト文字コード
(set-default-coding-systems 'utf-8)

(defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
          (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
	          (process-send-string proc text)
		        (process-send-eof proc))))

(if (not window-system)
 (setq interprogram-cut-function 'paste-to-osx)
 (setq interprogram-paste-function 'copy-from-osx)
 )

;;; 他のソフトでファイルを変更した場合に、バッファを自動再読み込み
(global-auto-revert-mode t)

(if window-system
    (progn
      ;; フレーム移動用のキーバインド
      (define-key global-map [C-tab] 'other-frame)

      ;; スクロールバーを非表示
      (scroll-bar-mode nil)

      ;; スクロールを１行づつ
      (setq scroll-step 1)

      ;; タイトルバーにファイル名表示
      (setq frame-title-format (format "%%f"))

      ;; ウィンドウの透明化
      (add-to-list 'default-frame-alist '(alpha . (0.90 0.90)))

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

      (setenv "LANG" "ja_JP.UTF-8")
      (setenv "LC_CTYPE" "ja_JP.UTF-8")
      (setenv "LC_MESSAGES" "ja_JP.UTF-8")
      (setenv "LC_MONETARY" "ja_JP.UTF-8")
      (setenv "LC_NUMERIC" "ja_JP.UTF-8")
      (setenv "LC_TIME" "ja_JP.UTF-8")
      (setenv "LC_ALL" "")

))

;;; ツールバーを非表示
(if (functionp 'tool-bar-mode) (tool-bar-mode 0))

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

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

;; jaspace
(require 'jaspace)
;; 全角空白を表示させる。
(setq jaspace-alternate-jaspace-string "□")
;; タブ記号を表示。
(setq jaspace-highlight-tabs ?^ ) ; use ^ as a tab marker

;;; auto-save-buffer --------------------------------------------
(require 'auto-save-buffers)
(run-with-idle-timer 1 t 'auto-save-buffers) 

;;; dired   -----------------------------------------------------
(defun dired-open-mac ()
  (interactive)
  (let ((fname (dired-get-file-for-visit)))
    (if (file-exists-p fname)
	(shell-command (concat "open '" fname "'" nil )))))

(defun dired-open-mac-terminal ()
  (interactive)
  (let ((fname (dired-get-file-for-visit)))
    (if (file-exists-p fname)
	(shell-command (concat "open -a Terminal.app '" fname "'" nil )))))

;;;;ファイル作成
(defun dired-create-file (file-name)
  (interactive "F Create file: ")
  (write-region "" nil file-name nil nil nil))

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

	    (define-key dired-mode-map "c" 'dired-create-file)
	    ))

;;; recentf   ---------------------------------------------------
(setq recentf-max-saved-items 1000)

;;; undo-tree  ---------------------------------------------------
; M-_     : redo
; C-x u   : undo-tree-visualize 終了はq
(add-to-list 'load-path "~/.emacs.d/undo-tree")
(when (require 'undo-tree nil t) (global-undo-tree-mode))

;;; magit --------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/magit")
(require 'magit)
(require 'magit-svn)
(require 'magit-topgit)
(require 'magit-stgit)

;; magit
(global-set-key (kbd "C-c g") 'magit-status)

;;; popwin -----------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/popwin")
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;;; helm -------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/helm")
(require 'helm-config)
(require 'helm-ring)

(global-set-key "\M-p" 'helm-mini)
(helm-mode 1)

(global-set-key "\M-y" 'helm-show-kill-ring)
(global-set-key "\M-i" 'helm-imenu)
(custom-set-variables
 '(helm-buffer-max-length 40))

;; helm-git
(add-to-list 'load-path "~/.emacs.d/helm-git")
(require 'helm-git)
(global-set-key (kbd "C-c p") 'helm-git-find-files)

;; 自動補完を無効
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
;; C-hでバックスペースと同じように文字を削除
(define-key helm-c-read-file-map (kbd "C-h") 'delete-backward-char)
;; TABで任意補完。選択肢が出てきたらC-nやC-pで上下移動してから決定することも可能
(define-key helm-c-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;; popwin
(setq display-buffer-function 'popwin:display-buffer)
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)

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
(require 'ruby-electric)

(autoload 'ruby-mode "ruby-mode"
   "Mode for editing ruby source files" t)
(setq auto-mode-alist
   (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                interpreter-mode-alist))

(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile.lock$" . ruby-mode))

;;; ruby on rails -----------------------------------------------
(require 'findr)
(add-to-list 'load-path "~/.emacs.d/rinari")

(require 'rinari)
(global-rinari-mode)

(add-to-list 'load-path "~/.emacs.d/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
    (lambda () (rinari-launch)))

(add-to-list 'auto-mode-alist '("\\.rhtml$" . rhtml-mode)) 
(add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode))

;;; cucumber-mode -----------------------------------------------
(add-to-list 'load-path "~/.emacs.d/cucumber.el")
(require 'feature-mode)

;;; rcodetool ---------------------------------------------------
; gem install rcodetools
; gem install fastri
; C-c C-c  : 関数・メソッド補完
; C-c C-d  : xmpfilter
; C-c C-f  : riでマニュアルを引く
(add-to-list 'load-path "~/.emacs.d/rcodetools")

(require 'rcodetools)
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

;;; auto-complete ------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/popup")
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/auto-complete-etags")

(require 'auto-complete-config)
(require 'auto-complete-etags)

;(add-to-list 'ac-sources 'ac-source-etags)
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

(global-auto-complete-mode t)
(ac-set-trigger-key "TAB")
;;; (setq ac-auto-start nil)
(setq ac-auto-start 2)
(setq ac-candidate-max 40)

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

;;; coffee-mode --------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(require 'coffee-mode)
(setq whitespace-action '(auto-cleanup))
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab))

(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))

;;; undo-tree  ---------------------------------------------------
; M-_     : redo
; C-x u   : undo-tree-visualize 終了はq
(when (require 'undo-tree nil t) (global-undo-tree-mode))

;;; geben  -------------------------------------------------------
; mampでxdebug使う時に使用
(add-to-list 'load-path "~/.emacs.d/geben")
(autoload 'geben "geben" "DBGp protocol front-end" t)

;;; uniquify -----------------------------------------------------
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+}")

;;; flymake -----------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/flymake-easy")
(require 'flymake-easy)

;; direx
(add-to-list 'load-path "~/.emacs.d/direx")
(require 'direx)
(push '(direx:direx-mode :position left :width 25 :dedicated t) popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

;; e2wm
(add-to-list 'load-path "~/.emacs.d/emacs-window-layout")
(add-to-list 'load-path "~/.emacs.d/emacs-window-manager")
(require 'e2wm)
(global-set-key (kbd "M-+") 'e2wm:start-management)
;; C-c ; Q 終了

;; markdown-mode
(add-to-list 'load-path "~/.emacs.d/markdown-mode")
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

;; dash-at-point
(add-to-list 'load-path "~/.emacs.d/dash-at-point")
(autoload 'dash-at-point "dash-at-point"
            "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)

;; eproject
(add-to-list 'load-path "~/.emacs.d/eproject")
(require 'eproject)
