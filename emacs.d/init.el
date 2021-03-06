;; package repositories
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(defun ensure-package-installed (&rest packages)
"Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

;; Ensure that specific packages are installed
(ensure-package-installed
  'helm
  'use-package
  'solarized-theme
  'evil
  'org
)

;disable toolbar
;(tool-bar-mode -1)

(use-package evil
  :ensure t
  :config
  (evil-mode 1)

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

 (use-package evil-indent-textobject
    :ensure t)
)
(evil-select-search-module 'evil-search-module 'evil-search)


; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;auto-complete-mode
(require 'auto-complete)
(global-auto-complete-mode t)

; elpy
(package-initialize)
(elpy-enable)


(global-hl-line-mode +1)

; load theme
;(load-theme 'sanityinc-tomorrow-night t)
(load-theme 'solarized-dark t)

(eval-after-load 'shell
  '(progn
     (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
     (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
     t))


; put backup files to a dedicated directory
(setq backup-directory-alist
      '(("." . "~/.emacs.d/backup"))
      delete-old-versions t)

; create backup file by copying
(setq backup-by-copying t)

; set tab-width to 4
(setq-default tab-width 4)

; OSX specific settings
(setq default-input-method "MacOSX")
(setq mac-option-key-is-meta t)
;(setq mac-right-option-modifier nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
	("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "11636897679ca534f0dec6f5e3cb12f28bf217a527755f6b9e744bd240ed47e1" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
	(fzf evil-tutor go-tag exec-path-from-shell flycheck org magit go-mode evil helm tern-auto-complete tern web-mode helm-ag markdown-mode linum-relative color-theme-sanityinc-tomorrow color-theme ag)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
