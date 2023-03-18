;;; pkg_config.el -- Package configuration
;;
;;; Commentary:
;;
;; Settings of the packages archives and basic functions
;;
;;; Code:
;;


;; Package management
(eval-when-compile
  (defvar package-archives))
(setq package-archives '(
			 ("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(unless (package-installed-p 'use-package)
  (package-initialize)
  (package-refresh-contents)
  (package-install 'use-package))

;; use-package
(dolist (package '(use-package))
  (unless (package-installed-p package)
    (package-install package)))

(eval-when-compile
  (require 'use-package)
  (require 'use-package-ensure))

(setq use-package-always-ensure t)
