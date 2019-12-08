;; added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.

;; You may delete these explanatory comments.
;;(package-initialize)

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name(concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
          (normal-top-level-add-subdirs-to-load-path))))))


(add-to-load-path "elisp" "conf" "public_repos")

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/conf")


(require 'package)
;; HTTPS 系のリポジトリ
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)

;; HTTP 系のリポジトリ
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)

;; marmalade　は HTTP アクセスすると証明書エラーでフリーズするので注意
;; (add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize) ; インストール済みのElispを読み込む

;; setting for Mac
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

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

;; C-m (newline-and-indent)
(define-key global-map (kbd "C-m") 'newline-and-indent)
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)
(define-key global-map (kbd "C-t") 'other-window)

(column-number-mode t)

;;(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time-mode t)

(setq frame-title-format "%f")

(global-linum-mode t)

(setq-default tab-width 4)

(setq-default indent-tabs-mode t)

(set-face-background 'region "darkgreen")

(set-face-attribute 'default nil
					:family "RictyDiminishedDiscord NF"
					:height 130)

;; (set-fontset-font
;;  nil 'japanese-jisx0208
;;  (font-spec :family "Noto Sans CJK JP"))
;;心はいつもはれ

(global-hl-line-mode t)

(setq show-paren-delay 0)
(show-paren-mode t)
;;(setq show-paren-style 'expression nil)
;;(set-face-background 'show-paren-match-face nil)
;;(set-face-background 'show-paren-match-face "pink")
(transient-mark-mode 1)


(load-theme 'madhat2r t)
;;(load-theme 'wombat t)
;;(load-theme 'atom-one-dark t)
;;(load-theme 'monokai-pro t)

(golden-ratio-mode 1)
(add-to-list 'golden-ratio-exclude-buffer-names " *NeoTree*")

(require 'undo-tree)

;;-------------------------------------------------------------------
(require 'helm-config)
(helm-mode 1)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

;; TABとC-zを入れ替える
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)   ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)       ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action)            ; list actions using C-z
;;(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
;;(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;; キーバインド
(global-set-key (kbd "C-c h") 'helm-mini)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
;;(define-key global-map (kbd "C-x b") 'helm-for-files)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)

(global-set-key (kbd "C-M-o") 'helm-occur)
(define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch) ; isearchからhelm-occurを起動
(define-key helm-map (kbd "C-c C-a") 'all-from-helm-occur) ; helm-occurからall-extに受け渡し
;;------------------------------------------------------------------



(when (require 'auto-complete-config nil t)
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
 (ac-config-default)
 (setq ac-use-menu-map t)
 (setq ac-ignore-case nil)
 (add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
 (add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
 (add-to-list 'ac-modes 'org-mode)
 (add-to-list 'ac-modes 'yatex-mode)
 (ac-set-trigger-key "TAB")
 (setq ac-use-fuzzy t))          ;; 曖昧マッチ



(when (require 'color-moccur nil t)
 (define-key global-map (kbd "M-o") 'occur-by-moccur)
 (setq moccur-split-word t))

(require 'moccur-edit nil t)
;; type r to edit on result view
;; type C-c C-u to discard modifications
;; type C-c C-k to discard changes
;; type C-x C-s to save the changes
(defadvice moccur-edit-change-file ; autosave changes
  (after save-after-moccur-edit-buffer activate)
  (save-buffer))

;; edit result view of grep
;; type C-c C-p to edit on grep buffer
;; type C-c C-k to discard changes
;; type C-c C-c to apply changes
;; M-x wgrep-save-all-buffers 
(require 'wgrep nil t)

;; C-x u to show undotree
;; type q to go to the state
;; type t to toggle time view
(when (require 'undohist nil t)
  (undohist-initialize))

(when (require 'undo-tree nil t)
  (define-key global-map (kbd "C-'") 'undo-tree-redo)
  (global-undo-tree-mode))


(when (require 'point-undo nil t)
  (define-key global-map (kbd "M-[") 'point-undo) ;; previous position
  (define-key global-map (kbd "M-]") 'point-redo)
)


;; C-z c to create new screen
;; C-z p to move to previous screen
;; C-z n to move to next screen
;; C-z k to remove the current screen
(setq elscreen-prefix-key (kbd "C-z"))
(when (require 'elscreen nil t)
  (elscreen-start))
  ;; C-z C-z means defaul C-z (hide emacs)
  (if window-system
  	  (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
  	(define-key elscreen-map (kbd "C-z") 'suspend-emacs))


;; C-c ,, to open howm-menu
;; C-c C-c to save and close the current buffer
(setq howm-directory (concat user-emacs-directory "howm"))
(setq howm-menu-lang 'ja)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
(when (require 'howm-mode nil t)
  (define-key global-map (kbd "C-c ,,") 'howm-menu))
(defun howm-save-buffer-and-kill ()
  (interactive)
  (when (and (buffer-file-name)
			 (howm-buffer-p))
	(save-buffer)
	(kill-buffer nil)))

(define-key howm-mode-map (kbd "C-c C-c") 'howm-save-buffer-and-kill)

(cua-mode t)
(setq cua-enable-cua-keys nil) ; disable CUA keybinds

(put 'narrow-to-region 'disabled nil)

;; M-x smartparens-mode to enable this minor mode
(require 'smartparens-config)
(smartparens-global-mode)

;; Magit
(setq-default magit-auto-revert-mode nil)
(setq vc-handled-backends '())
(eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))
(define-key global-map (kbd "C-x m") 'magit-status)
(define-key global-map (kbd "C-c l") 'magit-blame)

(custom-set-faces
 '(magit-diff-added ((t (:background "black" :foreground "green"))))
 '(magit-diff-added-highlight ((t (:background "white" :foreground "green"))))
 '(magit-diff-removed ((t (:background "black" :foreground "blue"))))
 '(magit-diff-removed-hightlight ((t (:background "white" :foreground "blue"))))
 '(magit-hash ((t (:foreground "red"))))
)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


;; rainbow-delimiters を使うための設定
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;; 括弧の色を強調する設定
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
    (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)

;; quickrun was installed
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(web-mode quickrun zenburn-theme wgrep undohist undo-tree monokai-theme moccur-edit memory-usage madhat2r-theme labburn-theme howm helm-descbinds helm-c-moccur golden-ratio elscreen auto-complete atom-one-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when (require 'web-mode nil t)
  (add-to-list 'auto-mode-alist '("//.html//'" . web-mode))
  (add-to-list 'auto-mode-alist '("//.css//'" . web-mode))
  (add-to-list 'auto-mode-alist '("//.js//'" . web-mode))
)

;; (i-mode 1)
;; (ido-everywhere 1)
;; (setq ido-enable-flex-matching t) ;; 中間/あいまい検索一致

(define-key global-map (kbd "C-h") 'delete-backward-char)

(if window-system 
    (progn
      (set-frame-parameter nil 'alpha 90)))

;; 透明度を変更するコマンド M-x set-alpha
(defun set-alpha (alpha-num)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons alpha-num '(90))))

(set-frame-parameter nil 'fullscreen 'maximized)

;; automatically insert brackets
;;(electric-pair-mode 1)


;; spaceline similar to poweline
(use-package spaceline-config
  :init
  (progn
    (setq powerline-default-separator 'slant)
    ;; anti aging power-line.
    (setq ns-use-srgb-colorspace nil))
  :config
  (progn
    (spaceline-emacs-theme)))

;; paradox mode on
(spaceline-toggle-paradox-menu-on)

;; anti aging power-line.
;; (setq ns-use-srgb-colorspace t)
(mode-icons-mode)
(setq mode-icons-grayscale-transform nil)

(use-package spaceline-config)
(setq powerline-height 16)

(spaceline-emacs-theme)
;;(require 'spaceline-all-the-icons)

(use-package all-the-icons)
(all-the-icons-octicon "file-binary")
(require 'neotree)
(global-set-key (kbd "C-c C-n") 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
