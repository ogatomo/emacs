(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(require 'dired)
(require 'peep-dired)

(define-key dired-mode-map "\C-xx" 'peep-dired)
(define-key peep-dired-mode-map "\C-xx" 'peep-dired)
