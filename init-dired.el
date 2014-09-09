(require 'dired-details)
(dired-details-install)
(setq dired-details-hidden-string "")
(setq dired-details-hide-link-targets nil)

(defadvice find-dired-sentinel (after dired-details (proc state) activate)
  "find-diredでもdired-detailsを使えるようにする"
  (ignore-errors
    (with-current-buffer (process-buffer proc)
      (dired-details-activate))))

(add-hook 'dired-toggle-mode-hook
          (lambda () (interactive)
            (visual-line-mode 1)
            (setq-local visual-line-fringe-indicators '(nil right-curly-arrow))
            (setq-local word-wrap nil)))
