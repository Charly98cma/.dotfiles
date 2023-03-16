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

;; All the icons
(when (display-graphic-p)
  (require 'all-the-icons))

;; Rainbow delimiters
;; https://www.emacswiki.org/emacs/RainbowDelimiters
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode 1))

;; Spaceline
;; https://github.com/TheBB/spaceline
(use-package spaceline-all-the-icons
  :init (progn
          (spaceline-all-the-icons-theme)
          (spaceline-toggle-all-the-icons-projectile-on)
          (spaceline-toggle-all-the-icons-buffer-path-on)
          (spaceline-toggle-all-the-icons-hud-off)
          (spaceline-toggle-all-the-icons-time-off)
          (setq spaceline-all-the-icons-separator-type 'none)
          (setq spaceline-all-the-icons-icon-set-modified 'circle)
          (setq spaceline-all-the-icons-hide-long-buffer-path t)
          (when (string-equal system-type "darwin")
            (setq powerline-image-apple-rgb t)))
  )

;; Vertico
;; https://github.com/minad/vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  (setq vertico-scroll-margin 0)

  ;; Show more candidates
  (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; A few more useful configurations...
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
(use-package multiple-cursors
  :bind (:map global-map
              ("C-S-c C-S-c" . 'mc/edit-lines)
              ("C->" . 'mc/mark-next-like-this)
              ("C-<" . 'mc/mark-previous-like-this)
              ("C-c C-<" . 'mc/mark-all-like-this)))



;;; Modes and tools

;; Undo-tree
;; (must be installed with M-x package-install)
;; https://github.com/apchamberlain/undo-tree.el
(require 'undo-tree)
(global-undo-tree-mode 1)
(setq undo-tree-show-minibuffer-help t)

;; All the icons
(when (display-graphic-p)
  (require 'all-the-icons))

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
  :bind (:map global-map
              ("C-x t t" . treemacs)))

;; Flycheck
;; https://github.com/flycheck/flycheck
(use-package flycheck
  :init (global-flycheck-mode))

;; Yasnippet
;; https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :init (yas-global-mode 1))

;; Company
;; https://github.com/company-mode/company-mode
(use-package company
  :init (progn
          (global-company-mode)
          (setq company-idle-delay 0)
          (setq company-minimum-prefix-length 1)))

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



;;; qol_pkgs.el ends here
