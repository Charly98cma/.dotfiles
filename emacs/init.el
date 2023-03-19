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

;; Load newest byte-code
(setq load-prefer-newer t)

;; UTF-8 Encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Don't show the splash/startup screen and scratch msg
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(setq inhibit-startup-screen t)

;; Turn off some unneeded UI elements
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  (menu-bar-mode -1)
  (show-paren-mode 1)
  ;; Parenthesis around selection
  (electric-pair-mode 1)
  ;; Ignore all bell functions
  (setq ring-bell-function 'ignore)
)

;; Delete the selected text when key pressed
(delete-selection-mode t)

;; Line numbers and highlight of current line
(global-display-line-numbers-mode 1)
(global-hl-line-mode t)

;; Indent with spaces always and 4 spaces/tab
(setq tab-width 4
      indent-tabs-mode nil)
;; Auto-indent new line
(global-set-key (kbd "RET") 'newline-and-indent)

;; No backup files (*~) and no auto-saves
(setq make-backup-files nil
      auto-save-default nil)

;; Always follow symlinks
(setq find-file-visit-truename t)

;; Only 80 characters per line
(setq-default fill-column 80)
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'prog-mode-hook #'auto-fill-mode)

;; Remove trailing withespaces on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Font
(add-to-list 'default-frame-alist '(font . "Monospace 11"))
(set-face-attribute 'default nil :family "Monospace 11")
(set-frame-font "Monospace 11" nil t)

;; Replace "yes/no" with "y/n"
(fset 'yes-or-no-p 'y-or-n-p)

;; Comment/Uncomment shortcut
(global-set-key (kbd "C-,") 'comment-or-uncomment-region)

;; Text-scale
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Column numbers enabled
(setq column-number-mode t)

;; Daemon mode
(require 'server)
(if (not (server-running-p)) (server-start))



;; ADDITIONAL CONFIGURATION

(load-file "~/.dotfiles/emacs/pkg_config.el")
(load-file "~/.dotfiles/emacs/qol_pkgs.el")

(provide 'init)
;;; init.el ends here
