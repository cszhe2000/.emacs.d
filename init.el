;; get package source
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			   ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; cl - Common Lisp Extension
(require 'cl)

;; add packages
(defvar my/packages '(
		      company
		      smex
		      smartparens
		      popwin
		      monokai-theme
		      dracula-theme
		      ) "Default packages")

(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
  (loop for pkg in my/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (my/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg my/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; enable company mode
(global-company-mode 1)

;; enable smartparens mode
(smartparens-global-mode)

;; enable popwin mode
(require 'popwin)
(popwin-mode 1)

;; quick open config file
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-init-file)

;; close tool bar
(tool-bar-mode -1)

;; show line number
(global-linum-mode 1)

;; yes or no -> y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; disable auto backup
(setq make-backup-files nil)

;; disable auto save file
(setq auto-save-default nil)

;; auto load outside update
(global-auto-revert-mode 1)

;; highlight matching parenthesis
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; highlight current line
(global-hl-line-mode 1)

;; use only one buffer for Dired Mode
(put 'dired-find-alternate-file 'disabled nil)

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; load dracula
(load-theme 'dracula 1)

;; load monokai
;; (load-theme 'monokai 1)
