; C-.     : 引数リスト表示
; C-c C-f : カーソル位置の関数を調べる
; C-c RET : マニュアルのトップ
(setq php-search-url "http://www.php.net/ja/")
(setq php-manual-url "http://www.php.net/manual/ja/")

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
