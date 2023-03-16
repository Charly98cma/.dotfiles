;;; init.el -- My humble (and basic) Emacs configuration
;;
;; Author: Carlos Miguel
;; URL: https://github.com/Charly98cma/.dotfiles
;;
;;; Commentary:
;;
;; My (try at) Emacs configuration
;;
;;; Code:
;;

;; My info :O
(setq user-full-name "Carlos Miguel"
      user-mail-address "1998cma@gmail.com")

;; UTF-8 Encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Don't show the splash screen
(setq inhibit-startup-message t)

;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(show-paren-mode 1)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; PArenthesis around selection
(electric-pair-mode 1)

;; Ignore all bell functions
(setq ring-bell-function 'ignore)

;; Line numbers and highlight of current line
(global-display-line-numbers-mode 1)
(global-hl-line-mode t)

;; Indent with spaces always and 4 spaces/tab
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; No backup files (*~) and no auto-saves
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Always follow symlinks
(setq find-file-visit-truename t)

;; Only 80 characters per line
(setq-default fill-column 80)
(add-hook 'text-mode-hook 'auto-fill-mode)

;; Remove trailing withespaces on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Font
(set-frame-font "Monospace 10" nil t)

;; Replace "yes/no" with "y/n"
(fset 'yes-or-no-p 'y-or-n-p)

;; Daemon mode
(require 'server)
(if (not (server-running-p)) (server-start))


;; ADDITIONAL CONFIGURATION

(load-file "~/.dotfiles/emacs/pkg_config.el")
(load-file "~/.dotfiles/emacs/qol_pkgs.el")

(provide 'init)
;;; init.el ends here
