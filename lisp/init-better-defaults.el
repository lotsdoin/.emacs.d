;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top
(setq ring-bell-function 'ignore)
(global-auto-revert-mode t)
(setq visible-bell t)
;; disbale backup file
;; (setq make-backup-files nil)

;; Keep all backup and auto-save files in one directory
(setq backup-directory-alist '(("." . "~/.emacs.d/lotsd/backups/")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
(fset 'yes-or-no-p 'y-or-n-p)

(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
(put 'dired-find-alternate-file 'disabled nil)

(ido-mode t)
(column-number-mode)
(show-paren-mode)
;; show match parents
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(winner-mode t)
(windmove-default-keybindings)
;; 用来显示当前光标在哪个函数
(which-func-mode 1)
;;自动重载更改的文件
(global-auto-revert-mode 1)
;; 在文档最后自动插入空白行
(setq require-final-newline t)

;;鼠标滚轮，默认的滚动太快，这里改为3行
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)


(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 200)
(setq recentf-max-saved-items 200)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; 即当你选中一段文字 之后输入一个字符会替换掉你选中部分的文字,但是不安全。
;; (delete-selection-mode 1)

;; turn on abbrev mode
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ("alpha" "α")
					    ("∞" "∞")
					    ("→" "→")



					    ))

(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer. "
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indented selected region."))
      (progn
	(indent-buffer)
	(message "Indented buffer.")))))

(setq hippie-expand-try-functions-list '(try-expand-dabbrev
					 try-expand-dabbrev-all-buffers
					 try-expand-dabbrev-from-kill
					 try-complete-file-name-partially
					 try-complete-file-name
					 try-expand-all-abbrevs
					 try-expand-list
					 try-expand-line
					 try-complete-lisp-symbol-partially
try-complete-lisp-symbol))

(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
(aset buffer-display-table ?\^M []))

(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
(while (search-forward "\r" nil t) (replace-match "")))

;; *toggle-truncate-lines* 当前行换行
;; 在 *org-mode* 自动换行

(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))



(provide 'init-better-defaults)
