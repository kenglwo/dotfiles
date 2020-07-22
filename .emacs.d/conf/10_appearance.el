(setq frame-title-format "%f")

(column-number-mode t)
(global-linum-mode t)
(global-hl-line-mode t)

(defvar show-paren-delay 0)
(show-paren-mode t)
(set-face-attribute 'show-paren-match nil
                    :background 'unspecified)
(setq show-paren-style 'parenthesis)
(set-face-underline 'show-paren-match "orange")



;; Programing font
(set-face-attribute 'default nil
    :family "RictyDiminishedDiscord NF"
    :height 130)
;; Japanese font
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Noto Sans CJK JP"))

(load-theme 'madhat2r t)
;;(load-theme 'wombat t)
;;(load-theme 'atom-one-dark t)
;;(load-theme 'monokai-pro t)

;; give mark region some color
(transient-mark-mode 1)
;; color of the mark region
(set-face-background 'region "DarkOliveGreen4")
;; (set-face-background 'region "MediumPurple4")
;; (set-face-background 'region "DeepSkyBlue4")

(if window-system
    (progn
      (set-frame-parameter nil 'alpha 90)))

;; 非アクティブウィンドウの背景色を設定
(when (require 'hiwin)
  (hiwin-activate)
  (set-face-background 'hiwin-face "gray30"))

;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)

