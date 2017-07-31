;; Make source code fancy in the org file.
(require 'org)
(setq org-src-fontify-natively t)
(setq org-agenda-files '("~/org"))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.emacs.d/org/gtd.org" "工作安排")
	 "* TODO [#B] %?\n %i \n"
	 :empty-lines 1)))

(provide 'init.org)
