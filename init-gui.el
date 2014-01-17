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

(defun dired-open-mac-sublime-text ()
  (interactive)
  (let ((fname (dired-get-file-for-visit)))
    (if (file-exists-p fname)
	(shell-command (concat "open -a 'Sublime Text 2.app' '" fname "'" nil )))))

;;;;ファイル作成
(defun dired-create-file (file-name)
  (interactive "F Create file: ")
  (write-region "" nil file-name nil nil nil))

;;; recentf
(setq recentf-max-saved-items 1000)

;;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+}")
