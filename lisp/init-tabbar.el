(require 'tabbar)
(tabbar-mode t)

;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
;; タブ同士の間隔
(setq tabbar-separator '(0.8))

;; 外観変更
(set-face-attribute
 'tabbar-default nil
 :family (face-attribute 'default :family)
 :background (face-attribute 'mode-line-inactive :background)
 :height 0.9)
(set-face-attribute
 'tabbar-unselected nil
 :background (face-attribute 'mode-line-inactive :background)
 :foreground (face-attribute 'mode-line-inactive :foreground)
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background (face-attribute 'mode-line :background)
 :foreground (face-attribute 'mode-line :foreground)
 :box nil)

(defun get-color-helper (face attribute n diff)
  (format "%x" (max 0 (min (car (color-values "white"))
                           (+ diff (nth n (color-values (face-attribute face attribute))))))))
(defun create-color-helper (face attribute r g b)
  (concat "#"
          (get-color-helper face attribute 0 r)
          (get-color-helper face attribute 1 g)
          (get-color-helper face attribute 2 b)))
 
(create-color-helper 'mode-line :foreground 10 -20 30)
