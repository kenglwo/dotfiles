(require 'golden-ratio)
(golden-ratio-mode 1)
(setq golden-ratio-exclude-buffer-names '(" *NeoTree*"))

;; helm ===================================================================
(require 'helm)
(require 'helm-config)
(helm-mode 1)
;; C-x b ;; select buffer
;; M-x recentf-open-files ;; open file from history
;; M-x apropos ;; search in documents
;; M-y ;; helm-show-kill-ring              

(define-key helm-map (kbd "C-h") 'delete-backward-char)
;;(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
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
;;  ===================================================================

;; auto-complete
(when (require 'auto-complete-config nil t)
  (global-auto-complete-mode t)
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default)
  (defvar ac-use-menu-map t)
  (defvar ac-ignore-case nil))

;; recover file history
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
  (setq elscreen-prefix-key (kbd "C-c"))
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


;; キーバインド
;; C-c ,, to open howm-menu
;; C-c C-c to save and close the current buffer
(defvar howm-directory (concat user-emacs-directory "howm"))
(defvar howm-menu-lang 'ja)
(defvar howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
(when (require 'howm-mode nil t)
  (define-key global-map (kbd "C-c ,,") 'howm-menu))
(defun howm-save-buffer-and-kill ()
  (interactive)
  (when (and (buffer-file-name)
       (howm-buffer-p))
  (save-buffer)
  (kill-buffer nil)))

(define-key howm-mode-map (kbd "C-c C-c") 'howm-save-buffer-and-kill)


(when (require 'web-mode nil t)
  (add-to-list 'auto-mode-alist '("//.html//'" . web-mode))
  (add-to-list 'auto-mode-alist '("//.css//'" . web-mode))
  (add-to-list 'auto-mode-alist '("//.js//'" . web-mode))
  (add-to-list 'auto-mode-alist '("//.erb//'" . web-mode))
 (add-to-list 'auto-mode-alist '("//.php//'" . web-mode))  
  (defvar web-mode-auto-close-style 1)
  (defvar web-mode-tag-auto-close-style t)
  (defvar web-mode-enable-auto-pairing t)
)
(defun web-mode-hook ()
  (defvar web-mode-markup-indent-offset 2)
  (add-hook 'web-mode-hook 'web-mode-hook))  

(add-hook 'after-init-hook #'global-flycheck-mode)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(global-set-key (kbd "<f5>") 'quickrun)
(global-set-key (kbd "C-<f5>") 'quickrun-with-arg)
(global-set-key (kbd "M-<f5>") 'quickrun-compile-only)

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
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (add-to-list
   'projectile-globally-ignored-directories
   "node_modules")
  (setq projectile-enable-caching t))

(setq helm-projectile-fuzzy-match nil)
(when (require 'helm-projectile nil t)
  (setq projectile-completion-system 'helm))

(when (require 'projectile-rails nil t)
  (projectile-rails-global-mode))

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(when (require 'ac-emoji nil t)
  (add-to-list 'ac-modes 'text-mode)
  (add-to-list 'ac-modes 'markdown-mode)
  (add-hook 'text-mode-hook 'ac-emoji-setup)
  (add-hook 'markdown-mode-hook 'ac-emoji-setup))


(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
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
    (init-loader php-mode hiwin ac-emoji projectile-rails helm-projectile flycheck-pos-tip flycheck helm-migemo yatex web-mode quickrun zenburn-theme wgrep undohist undo-tree monokai-theme moccur-edit memory-usage madhat2r-theme labburn-theme howm helm-descbinds helm-c-moccur golden-ratio elscreen auto-complete atom-one-dark-theme))))




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
