
(require 'php-mode)
(add-hook 'php-mode-hook
          '(lambda ()
             ;(c-set-style "stroustrup")
             (setq tab-width 4)
             (setq c-basic-offset 4)
             (setq indent-tabs-mode t)
             (c-set-offset 'arglist-intro '+)
             (c-set-offset 'arglist-close 0)
             ;;(setq php-mode-force-pear t)
         ))
