(defvar google-translate-english-chars "[:ascii:]"
  "これらの文字が含まれているときは英語とみなす")
(defun google-translate-enja-or-jaen ()
  (interactive)
  (let* ((asciip (string-match
                  (format "\\`[%s]+\\'" google-translate-english-chars)
                  (buffer-substring (region-beginning) (region-end))))
         (google-translate-default-source-language (if asciip "en" "ja"))
         (google-translate-default-target-language (if asciip "ja" "en"))
         (google-translate-translation-directions-alist
          '(("en" . "ja") ("ja" . "en"))))
    (run-at-time 0.1 nil 'deactivate-mark)
    (call-interactively (if (region-active-p) 'google-translate-at-point
                          'google-translate-smooth-translate))))
(global-set-key (kbd "C-c t") 'google-translate-enja-or-jaen)
