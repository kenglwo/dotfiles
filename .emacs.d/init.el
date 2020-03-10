;; added by Package.el.  This must come before configurations 
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
;; HTTP 系のリポジトリ
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/") t)
(package-initialize) ;; インストール済みのElispを読み込む

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

(setq-default tab-width 2 indent-tabs-mode nil)

(set-face-background 'region "darkgreen")

(set-face-attribute 'default nil
    :family "RictyDiminishedDiscord NF"
    :height 130)

;; (set-fontset-font
;;  nil 'japanese-jisx0208
;;  (font-spec :family "Noto Sans CJK JP"))


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




(require 'helm-config)
(helm-mode 1)
;; C-x b ;; select buffer
;; M-x recentf-open-files ;; open file from history
;; M-x apropos ;; search in documents

;; M-y ;; helm-show-kill-ring              

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

(require 'helm-descbinds)
(helm-descbinds-mode)
;; M-x describe-bindings

(require 'helm-config)
(global-set-key (kbd "C-M-o") 'helm-occur) ; helm-occurの起動
(define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch) ; isearchからhelm-occurを起動
(define-key helm-map (kbd "C-c C-a") 'all-from-helm-occur) ; helm-occurからall-extに受け渡し

;; migemo.elの設定 (for macOS)
;; migemoをPATHに追加
(setq exec-path (cons "/usr/local/bin" exec-path))
(setenv "PATH"
    (concat '"/usr/local/bin:" (getenv "PATH")))
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
 ;; Set your installed path
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(migemo-init)

(helm-migemo-mode 1)

;; auto-complete
(when (require 'auto-complete-config nil t)
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default)
  (setq ac-use-menu-map t)
  (setq ac-ignore-case nil))

(when (require 'undohist nil t)
  (undohist-initialize))

;; qで抜ける
(when (require 'undo-tree nil t)
  ;; C-'にredoを割り当てる
  (define-key global-map (kbd "C-'") 'undo-tree-redo)
  (global-undo-tree-mode))

(when (require 'point-undo nil t)
  (define-key global-map (kbd "M-[") 'point-undo)
  (define-key global-map (kbd "M-]") 'point-redo)
  )

(when (require 'elscreen nil t)
  (elscreen-start)
  (set-face-attribute 'elscreen-tab-background-face nil
                    :background "grey10"
                    :foreground "grey90")
  (set-face-attribute 'elscreen-tab-control-face nil
                    :background "grey20"
                    :foreground "grey90")
  (set-face-attribute 'elscreen-tab-current-screen-face nil
                    :background "grey20"
                    :foreground "grey90")
  (set-face-attribute 'elscreen-tab-other-screen-face nil
                    :background "grey30"
                    :foreground "grey60")
  ;; [X]を表示しない
  (setq elscreen-tab-display-kill-screen nil)
  ;; [<->]を表示しない
  (setq elscreen-tab-display-control nil)
  
  (if window-system
    (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
  (define-key elscreen-map (kbd "C-z") 'suspend-emacs)))

;; キーバインド
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

(when (require 'web-mode nil t)
  (add-to-list 'auto-mode-alist '("¥¥.html¥¥'" . web-mode))
  (add-to-list 'auto-mode-alist '("¥¥.php¥¥'" . web-mode))
  (add-to-list 'auto-mode-alist '("¥¥.css¥¥'" . web-mode))
  (add-to-list 'auto-mode-alist '("¥¥.js¥¥'" . web-mode))
  (add-to-list 'auto-mode-alist '("¥¥.jsx¥¥'" . web-mode))
  (add-to-list 'auto-mode-alist '("¥¥.erb¥¥'" . web-mode))
  )
(defun web-mode-hook ()
  (setq web-mode-markup-indent-offset 2)
  (add-hook 'web-mode-hook 'web-mode-hook))

  

(add-hook 'after-init-hook #'global-flycheck-mode)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(global-set-key (kbd "<f5>") 'quickrun)
(global-set-key (kbd "C-<f5>") 'quickrun-with-arg)
(global-set-key (kbd "M-<f5>") 'quickrun-compile-only)

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
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-diff-added ((t (:background "black" :foreground "green"))))
 '(magit-diff-added-highlight ((t (:background "white" :foreground "green"))))
 '(magit-diff-removed ((t (:background "black" :foreground "blue"))))
 '(magit-diff-removed-hightlight ((t (:background "white" :foreground "blue"))))
 '(magit-hash ((t (:foreground "red")))))

(when (require 'projectile nil t)
  (projectile-mode)
  (add-to-list
   'projectile-globally-ignored-directories
   "node_modules")
  (setq projectile-enable-caching t))

(setq helm-projectile-fuzzy-match nil)
(when (require 'helm-projectile nil t)
  (setq projectile-completion-system 'helm))

(when (require 'projectile-rails nil t)
  (projectile-rails-global-mode))


(when (require 'ac-emoji nil t)
  (add-to-list 'ac-modes 'text-mode)
  (add-to-list 'ac-modes 'markdown-mode)
  (add-hook 'text-mode-hook 'ac-emoji-setup)
  (add-hook 'markdown-mode-hook 'ac-emoji-setup))

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
  (php-mode hiwin ac-emoji projectile-rails helm-projectile flycheck-pos-tip flycheck helm-migemo yatex web-mode quickrun zenburn-theme wgrep undohist undo-tree monokai-theme moccur-edit memory-usage madhat2r-theme labburn-theme howm helm-descbinds helm-c-moccur golden-ratio elscreen auto-complete atom-one-dark-theme))))


(when (require 'web-mode nil t)
  (add-to-list 'auto-mode-alist '("//.html//'" . web-mode))
  (add-to-list 'auto-mode-alist '("//.css//'" . web-mode))
  (add-to-list 'auto-mode-alist '("//.js//'" . web-mode))
  (setq web-mode-auto-close-style 1)
  (setq web-mode-tag-auto-close-style t)
  (setq web-mode-enable-auto-pairing t)
)

;; (i-mode 1)
;; (ido-everywhere 1)
;; (setq ido-enable-flex-matching t) ;; 中間/あいまい検索一致

(define-key global-map (kbd "C-h") 'delete-backward-char)

(if window-system
    (progn
      (set-frame-parameter nil 'alpha 90)))

(setq tex-command "platex")
(setq bibtex-command "pbibtex")
;;reftex-mode
(add-hook 'yatex-mode-hook
          '(lambda ()
              (reftex-mode 1)
              (define-key reftex-mode-map
                (concat YaTeX-prefix ">") 'YaTeX-comment-region)
              (define-key reftex-mode-map
                (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))


;; 非アクティブウィンドウの背景色を設定
(when (require 'hiwin)
  (hiwin-activate)
  (set-face-background 'hiwin-face "gray30"))

(use-package php-mode :ensure t)
(add-hook 'php-mode-hook
  (lambda ()
    (setq tab-width 2)
    (setq c-basic-offset 2)
    (setq indent-tabs-mode nil)))


(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <right>") 'windmove-right)

(use-package prettier-js :ensure t :defer t
 :diminish (prettier-js-mode . "-prett")
 ; :hook (
 ;   (yaml-mode . prettier-js-mode)
 ;   (json-mode . prettier-js-mode)
 ;   (html-mode . prettier-js-mode)
 ;   (web-mode . prettier-js-mode)
 ;   (css-mode . prettier-js-mode))
 :config
  (setq prettier-js-command "~/.config/yarn/global/node_modules/.bin/prettier")
  (setq prettier-js-args '(
    "--trailing-comma" "all"
    "--bracket-spacing" "false"
    ))
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode)
)

;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)
