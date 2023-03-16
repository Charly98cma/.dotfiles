;;; pkg_config.el -- Package configuration
;;
;;; Commentary:
;;
;; Settings of the packages archives and basic functions
;;
;;; Code:
;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
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
