;; Make source code fancy in the org file.
(require 'org)
(setq org-src-fontify-natively t)
(setq org-default-notes-file '("~/.emacs.d/org/"))
(setq org-directory '("~/.emacs.d/org/"))
(setq org-agenda-files '("~/.emacs.d/org/inbox.org"
			 "~/.emacs.d/org/gtd.org"
			 "~/.emacs.d/org/tickler.org"
			 "~/.emacs.d/org/journal.org"))

;; (setq org-capture-templates
;;'(("t" "Todo" entry (file+headline "~/.emacs.d/org/gtd.org" "工作安排")
;;    "* TODO [#B] %?\n %i \n"
;;    :empty-lines 1)))
;; (setq org-capture-templates
;; '(("j" "Journal" entry (file+datetree "~/.emacs.d/org/journal.org")
;; "* %?\nEntered on %U\n %i\n %a")))
;; ;; 将以上代码添加到 Emacs 的配置文件，就可以直接利用 M-x org-capture j 实现添加日记的功能



(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/.emacs.d/org/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/.emacs.d/org/tickler.org" "Tickler")
                               "* %i%? \n %U")
			      ("j" "Journal" entry
			       (file+datetree "~/.emacs.d/org/journal.org")
			      "* %?\nEntered on %U\n %i\n %a")))




(setq org-refile-targets '(("~/.emacs.d/org/gtd.org" :maxlevel . 3)
                           ("~/.emacs.d/org/someday.org" :level . 1)
                           ("~/.emacs.d/org/tickler.org" :maxlevel . 2)
			   ("~/.emacs.d/org/journal.org" :level . 0)))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))



(setq org-agenda-custom-commands 
      '(("o" "At the office" tags-todo "@office"
         ((org-agenda-overriding-header "Office")))))

(setq org-agenda-custom-commands 
      '(("o" "At the office" tags-todo "@office"
         ((org-agenda-overriding-header "Office")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))
		  
(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(provide 'init-org)
