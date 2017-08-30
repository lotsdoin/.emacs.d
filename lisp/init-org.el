;; Make source code fancy in the org file.
(require 'org)
(setq org-src-fontify-natively t)
(setq org-default-notes-file '("~/.emacs.d/org/"))
(setq org-directory '("~/.emacs.d/org/"))
(setq org-agenda-files '("~/.emacs.d/org/inbox.org"
			 "~/.emacs.d/org/gtd.org"
			 "~/.emacs.d/org/tickler.org"
			 "~/.emacs.d/org/journal.org"
			 "~/.emacs.d/org/emacs.org"
			 "~/.emacs.d/org/vim.org"
                         "~/.emacs.d/org/health.org"))

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
			       "* %?\nEntered on %U\n %i\n %a")
			      ("e" "emacs" entry
			       (file+datetree "~/.emacs.d/org/emacs.org")
			       "* %?\nEntered on %U\n %i\n %a")
			      ("v" "vim" entry
			       (file+datetree "~/.emacs.d/org/vim.org")
			       "* %?\nEntered on %U\n %i\n %a")
			      ("k" "know" entry
			       (file+datetree "~/.emacs.d/org/know.org")
			       "* %?\nEntered on %U\n %i\n %a")
			      ("b" "book" entry
			       (file+datetree "~/.emacs.d/org/book.org")
			       "* %?\nEntered on %U\n %i\n %a")
			      ("q" "quote" entry
			       (file+datetree "~/.emacs.d/org/quote.org")
			       "* %?\nEntered on %U\n %i\n %a")
			      ("h" "health" entry
			       (file+datetree "~/.emacs.d/org/health.org")
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


;; org-mode 設定 C-c C-c 加密，M-x org-decrpt-entry
(require 'org-crypt)

;; 當被加密的部份要存入硬碟時，自動加密回去
(org-crypt-use-before-save-magic)

;; 設定要加密的 tag 標籤為 secret
(setq org-crypt-tag-matcher "secret")

;; 避免 secret 這個 tag 被子項目繼承 造成重複加密
;; (但是子項目還是會被加密喔)
(setq org-tags-exclude-from-inheritance (quote ("secret")))

;; 用於加密的 GPG 金鑰
;; 可以設定任何 ID 或是設成 nil 來使用對稱式加密 (symmetric encryption)
(setq org-crypt-key nil)

;; -------------------------------------
;; -- PDF
;; -------------------------------------
;; 'djcb-org-article' for export org documents to the LaTex 'article', using
;; XeTeX and some fancy fonts; requires XeTeX (see org-latex-to-pdf-process)
;; -----------------------------------------------------------------------------
;; http://emacs-fu.blogspot.com/2011/04/nice-looking-pdfs-with-org-mode-and.html
;; http://comments.gmane.org/gmane.emacs.orgmode/40221
;; -----------------------------------------------------------------------------
;; Install Packages:
;; + texlive-all  
;; + texlive-xetex
;; + ttf-sil-gentium
;; + ttf-sil-gentium-basic
;; + ttf-sil-charis
;; + ttf-dejavu
;; -----------------------------------------------------------------------------
;; Make sure to include the latex class in you header:
;; #+LaTeX_CLASS: djcb-org-article
;; -----------------------------------------------------------------------------
(eval-after-load 'org-export-latex
  '(progn
     (add-to-list 'org-export-latex-classes
          '("djcb-org-article"
            "\\documentclass[11pt,a4paper]{article}
             \\usepackage{minted}
             \\usemintedstyle{emacs}
             \\newminted{common-lisp}{fontsize=10}
                     \\usepackage[T1]{fontenc}
                     \\usepackage{hyperref}
                     \\usepackage{fontspec}
                     \\usepackage{graphicx} 
                     \\defaultfontfeatures{Mapping=tex-text}
                     \\setromanfont{Gentium}
                     \\setromanfont [BoldFont={Gentium Basic Bold},
                                     ItalicFont={Gentium Basic Italic}]{Gentium Basic}
                     \\setsansfont{Charis SIL}
                     \\setmonofont[Scale=0.8]{DejaVu Sans Mono}
                     \\usepackage{geometry}
                     \\geometry{a4paper, textwidth=6.5in, textheight=10in,
                                 marginparsep=7pt, marginparwidth=.6in}
                     \\pagestyle{empty}
                     \\title{}
                           [NO-DEFAULT-PACKAGES]
                           [NO-PACKAGES]"
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))))
;; -----------------------------------------------------------------------------
;; Added Syntax Highlighting Support
;; http://orgmode.org/worg/org-tutorials/org-latex-export.html
;; #+LaTeX_HEADER: \usepackage{minted}
;; #+LaTeX_HEADER: \usemintedstyle{emacs}
;; #+LaTeX_HEADER: \newminted{common-lisp}{fontsize=\footnotesize}
;; -----------------------------------------------------------------------------
;; Install Packages:
;; + python-pygments
;; -----------------------------------------------------------------------------
(setq org-export-latex-listings 'minted)
(setq org-export-latex-custom-lang-environments
      '(
    (emacs-lisp "common-lispcode")
       ))
(setq org-export-latex-minted-options
      '(("frame" "lines")
        ("fontsize" "\\scriptsize")
    ("linenos" "")
))
(setq org-latex-to-pdf-process 
      '("xelatex --shell-escape -interaction nonstopmode %f"
    "xelatex --shell-escape -interaction nonstopmode %f")) ;; for multiple passes
;; Not sure if this is actually setting the export class correctly.
(setq org-export-latex-class "djcb-org-article")
;;
;;




(provide 'init-org)
