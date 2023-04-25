;;; qol_pkgs.el --- Quality of Life packages I need
;;
;;; Commentary:
;;
;; Packages required for my sanity
;;
;;; Code:
;;


;;; Basic packages/setup

;; Indent whole buffer (thanks sksergio)
(defun iwb ()
  "Indent whole buffer."
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (message "Indent buffer: Done."))
(global-set-key (kbd "M-i") 'iwb)

;; Aggressive-indent-mode
;; https://github.com/Malabarba/aggressive-indent-mode
(use-package aggressive-indent
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'css-mode-hook #'aggressive-indent-mode)
  (global-aggressive-indent-mode 1)
  )


;; All the icons
(when (display-graphic-p)
  (require 'all-the-icons))

;; Rainbow delimiters
;; https://www.emacswiki.org/emacs/RainbowDelimiters
(defvar rainbow-delimiters)
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode 1))

;; Autopair-mode (closes a brace structure as soon as the opening char os typed)
(eval-after-load "autopair-autoloads" ; <-- "autopair-autoloads" not "autopair"
  '(progn
     (require 'autopair)
     (autopair-global-mode 1)))

;; Spaceline
;; https://github.com/TheBB/spaceline
(defvar spaceline-all-the-icons)
(use-package spaceline-all-the-icons
  :init (progn
          (spaceline-all-the-icons-theme)
          (spaceline-toggle-all-the-icons-projectile-on)
          (spaceline-toggle-all-the-icons-buffer-path-on)
          (spaceline-toggle-all-the-icons-hud-off)
          (spaceline-toggle-all-the-icons-time-off)
          (setq spaceline-all-the-icons-separator-type 'none)
          (setq spaceline-all-the-icons-icon-set-modified 'circle)
          (setq spaceline-all-the-icons-hide-long-buffer-path t)))

;; Vertico
;; https://github.com/minad/vertico
(defvar vertico)
(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  ;; Different scroll margin
  (setq vertico-scroll-margin 0)
  ;; Show more candidates
  (setq vertico-count 20))

;; A few more useful configurations...
(defvar emacs)
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

;; Multiple-cursors
;; https://github.com/magnars/multiple-cursors.el
(defvar multiple-cursors)
(use-package multiple-cursors
  :ensure t
  :bind (("C-c m c" . 'mc/edit-lines)))
;; C-j -> New line while editing multiple lines
;; C-' -> Hide/Unhide all lines without a cursor
;; C-g or ENTER -> exit

(defvar hl-todo)
(use-package hl-todo
  :ensure t
  :bind (("C-c p" . hl-todo-previous)
         ("C-c n" . hl-todo-next)
         ("C-c o" . hl-todo-occur)
         ("C-c i" . hl-todo-insert))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))
(global-hl-todo-mode 1)


;;; Modes and tools

;; Ispell and Flyspell
(require 'ispell)
(setq ispell-dictionary "english")
(add-to-list
 'ispell-dictionary-alist '("spanish"))
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(add-hook 'text-mode-hook 'flyspell-mode)

;; Move-text
(provide 'move-text)
(move-text-default-bindings)

;; Undo-tree (must be installed with M-x package-install)
;; https://github.com/apchamberlain/undo-tree.el
(require 'undo-tree)
(global-undo-tree-mode 1)
(setq undo-tree-auto-save-history t)
(setq undo-tree-show-minibuffer-help t)

;; Windmove (move between buffers with arrows)
;; https://www.emacswiki.org/emacs/WindMove
(use-package windmove
  :ensure t
  :bind (("C-<up>" . windmove-up)
         ("C-<down>" . windmove-down)
         ("C-<right>" . windmove-right)
         ("C-<left>" . windmove-left)))

;; Treemacs
;; https://github.com/Alexander-Miller/treemacs
(use-package treemacs
  :ensure t
  :bind (:map global-map
              ("C-x t t" . treemacs)))

;; Flycheck
;; https://github.com/flycheck/flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Yasnippet
;; https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :ensure t
  :init (yas-global-mode t)
  :bind ("C-<tab>" . yas-expand))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(use-package yasnippet-snippets
  :ensure t)

;; Company
;; https://github.com/company-mode/company-mode
(use-package company
  :ensure t
  :init (global-company-mode)
  :bind ("C-<tab>" . company-yasnippet))
(add-hook 'after-init-hook 'global-company-mode) ; Enabled on all buffers
;; Company-quickhelp
(use-package company-quickhelp
  :ensure t
  :init (company-quickhelp-mode 1)
  :config (eval-after-load 'company
            '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin)))

;; DOOM Themes => doom-tomorrow-night
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-tomorrow-night t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom treemacs theme (all-the-icons must be installed!)
  (setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))



;;; Programming modes

;; Magit
;; https://github.com/magit/magit
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;; LSP
;; https://github.com/emacs-lsp/lsp-mode
(setq lsp-keymap-prefix "C-l")
(use-package lsp-mode
  :init (progn
          (setq lsp-enable-snippet nil)
          (setq lsp-idle-delay 1.0)
          (setq read-process-output-max (* (* 1024 1024) 3)))
  :hook ((c-mode . lsp-deferred)))
(use-package lsp-ui
  :init (progn
          (setq lsp-ui-sideline-show-diagnostics t)
          (setq lsp-ui-sideline-show-hover nil)
          (setq lsp-ui-sideline-show-code-actions t)
          (setq lsp-ui-peek-enable t)
          (setq lsp-ui-doc-enable t)
          (setq lsp-ui-doc-position 'top)
          (setq lsp-ui-doc-show-with-cursor t)
          (setq lsp-ui-doc-show-with-mouse t))
  :hook (lsp-mode . lsp-ui-mode))

;; Nix-mode for Nix files
;; https://github.com/NixOS/nix-mode
(use-package nix-mode
  :mode "\\.nix\\'")

;; Markdown-mode
;; https://github.com/jrblevin/markdown-mode
(use-package markdown-mode
  :init (setq markdown-command "multimarkdown")
  :mode (("\\.markdown$" . markdown-mode)
         ("\\.md$" . markdown-mode))
  :hook ((markdown-mode . flyspell-mode)
         (markdown-mode . auto-fill-mode)))

;; YAML mode
;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode
  :mode (("\\.yaml$" . yaml-mode)
         ("\\.yml$" . yaml-mode)))

;; Dockerfile-mode
;; https://github.com/spotify/dockerfile-mode
(use-package dockerfile-mode
  :mode ("^Dockerfile" . dockerfile-mode))

;; Java stuff
(eval-when-compile
  (defvar c-basic-offset))
(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2
                                  tab-width 2
                                  indent-tabs-mode t)))
(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)

;; Shell-script-mode (specifically for zsh files)
(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))
;; Conf-mode
(add-to-list 'auto-mode-alist '("\\.gitconfig$" . conf-mode))



(provide 'qol_pkgs)
;;; qol_pkgs.el ends here
