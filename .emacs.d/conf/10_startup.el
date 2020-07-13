;; do not show startup message
(setq inhibit-startup-message 1)

;; do not show menu when started in terminal
(if (eq window-system 'x)
  (menu-bar-mode 1) (menu-bar-mode 0))
(menu-bar-mode nil)

;; delete message of scratch
(setq initial-scratch-message "")

;; 1 scroll moves 1 line
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5)))

;; stop exceleration of scroll
(setq mouse-wheel-progressive-speed nil)

;; remove tool and scroll bar 
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
