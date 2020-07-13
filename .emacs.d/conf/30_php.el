(use-package php-mode :ensure t)
(add-hook 'php-mode-hook
  (lambda ()
    (setq tab-width 2)
    (setq c-basic-offset 2)
    (setq indent-tabs-mode nil)))
