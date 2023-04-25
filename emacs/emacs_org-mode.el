;;; emacs_org-mode.el --- Carlos Miguel Alonso configuration
;;
;; Author: Carlos Miguel Alonso <1998cma@gmail.com>
;; URL: https://github.com/charly98cma/emacs.d


;;; Commentary:
;; Org-mode, org-agenda, and org-related packages configuration


;;; Code:


(require 'org)
(require 'org-install)

;; Enable the log
(setq org-log-done t)


;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


;; Pull data for agenda from these files
;; C-c [ and C-c ] to add/remove files to org-agenda-files
;; (setq org-agenda-files
;;       (directory-files-recursively "~/Documentos/AGENDA/" "\\.org$"))


;; Establish TODO keywords and notes
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "DOING(g)" "|" "DONE(d)")
	      (sequence "HOLD(h@/!)" "|" "DROPPED(p@/!)" "CANCELLED(c@/!)"))
	     )
      )


;; Establish TODO keywords appearances
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("DOING":foreground "green" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("HOLD" :foreground "cyan" :weight bold)
	      ("DROPPED" :foreground "orange" :weight bold)
	      ("CANCELLED" :foreground "magenta" :weight bold))
	     )
      )


;; Fast TODO selection
;; C-c C-t KEY
(setq org-use-fast-todo-selection t)


;; Add/Remove tags based on the new state
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
	      ("DROPPED" ("DROPPED" . t))
	      (done ("DROPPED") ("CANCELLED"))
	      ("TODO" ("DROPPED") ("CANCELLED") ("NEXT"))
	      ("NEXT" ("DROPPED") ("CANCELLED") ("NEXT"))
	      ("DOING" ("DROPPED") ("CANCELLED") ("NEXT"))
	      ("DONE" ("DROPPED") ("CANCELLED") ("NEXT"))
	      )
       )
      )


;; Tags
(setq org-tag-alist
      (quote (("CANCELLED" . ?c)
	      ("DROPPED" . ?p)
	      ("HOLD" . ?h)
	      ("IDEA" . ?i)
	      )
	     )
      )


; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))



;;; Org-capture
;; Used to add new tasks quickly

(require 'org-capture)

;; (setq org-directory "~/Documentos/AGENDA/")
;; (setq org-default-notes-file "~/Documentos/AGENDA/refile.org")

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates
(setq org-capture-templates
      (quote (("t" "todo" entry (file org-default-notes-file)
	       "* TODO %?")
	      ("r" "respond" entry (file org-default-notes-file)
	       "* NEXT Respond to %:from on %:subject")
	      ("n" "note" entry (file org-default-notes-file)
	       "* %? :NOTE:")
	      ("m" "Meeting" entry (file org-default-notes-file)
	       "* MEETING with %? :MEETING:")
	      ("i" "Idea" entry (file org-default-notes-file)
	       "* %? :IDEA:")
	      )
	     )
      )



;;; Org-agenda


(require 'org-agenda)

;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Don't slow down startup when generating the agenda
(customize-set-variable 'org-agenda-inhibit-startup nil)

;; Show 14 days per page in the agenda
(customize-set-variable 'org-agenda-span 30)

;; Show upcoming deadlines for the 4 weeks
(customize-set-variable 'org-deadline-warning-days 30)

;; Start the agenda on today
(customize-set-variable 'org-agenda-start-on-weekday nil)

;; Increase line spacing and highlight current line
(defun ll/org/agenda/appearance-hook ()
  (setq line-spacing 4)
  (hl-line-mode 1))
(add-hook 'org-finalize-agenda-hook #'ll/org/agenda/appearance-hook)

;; Don't display holidays that I don't follow
(customize-set-variable 'holiday-bahai-holidays nil)
(customize-set-variable 'holiday-hebrew-holidays
			(quote ((holiday-hebrew-hanukkah)
				(if calendar-hebrew-all-holidays-flag
				    (append (holiday-hebrew-tisha-b-av)
					    (holiday-hebrew-misc))))))
(customize-set-variable 'holiday-islamic-holidays nil)

;; Indent headings by level
(customize-set-variable 'org-startup-indented t)

;; Don't turn on truncating long lines in org mode
(customize-set-variable 'org-startup-truncated nil)

;; Modify the way that entries with time specifications are displayed
(customize-set-variable 'org-agenda-use-time-grid t)
;; (customize-set-variable 'org-agenda-time-grid
;;			(quote ((daily today require-timed)
;;				#("-----------------------------------"
;;				  0 35 (org-heading t))
;;				(0 2400))))
(customize-set-variable 'org-agenda-current-time-string
			#("now - - - - - - - - - - - - - - - -"
			  0 35 (org-heading t)))

;; Modify the way that deadlines are displayed
(customize-set-variable 'org-agenda-deadline-leaders
			'("Deadline:  " "----- In %3d d.: -----"))

;; And scheduled items
(customize-set-variable 'org-agenda-scheduled-leaders
			'(">> Scheduled: <<" "** Sched.%2dx: **"))



;;; Org-babel

(require 'ob)

;; Load different languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (org . t)
   (latex . t)
   (shell . t)
   (plantuml . t)
   (dot . t)
   (C . t)
   )
 )

; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))

(setq org-src-fontify-natively t
      org-confirm-babel-evaluate nil)
(add-hook 'org-babel-after-execute-hook (lambda ()
					  (condition-case nil
					      (org-display-inline-images)
					    (error nil)))
	  'append)



;;; Org-abbrev

(add-hook 'org-mode-hook (lambda () (abbrev-mode 1)))



;;; Org-Habit

(require 'org-habit)

(add-to-list 'org-modules "org-habit")

(setq org-habit-preceding-days 7
      org-habit-following-days 1
      org-habit-graph-column 80
      org-habit-show-habits-only-for-today t
      org-habit-show-all-today t)



;; ;; TOC-ORG
;; (use-package toc-org
;;   :ensure t
;;   :init (add-to-list 'org-tag-alist '("TOC" . ?T)))

(provide 'emacs_org-mode.el)
;;; emacs_org-mode.el ends here
