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


;; Tab and <S-Tab>  
;; (defun zilongshanren/indent-region(numSpaces)
;;  (progn
;;                                      ; default to start and end of current line
;;    (setq regionStart (line-beginning-position))
;;    (setq regionEnd (line-end-position))
;; 
;;                                      ; if there's a selection, use that instead of the current line
;;    (when (use-region-p)
;;      (setq regionStart (region-beginning))
;;      (setq regionEnd (region-end))
;;      )
;; 
;;    (save-excursion                          ; restore the position afterwards
;;      (goto-char regionStart)                ; go to the start of region
;;      (setq start (line-beginning-position)) ; save the start of the line
;;      (goto-char regionEnd)                  ; go to the end of region
;;      (setq end (line-end-position))         ; save the end of the line
;; 
;;      (indent-rigidly start end numSpaces) ; indent between start and end
;;      (setq deactivate-mark nil)           ; restore the selected region
;;      )
;;    )
;;  )


(defun zilongshanren/tab-region ()
  (interactive "p")
  (if (use-region-p)
      (zilongshanren/indent-region 4)               ; region was selected, call indent-region
    (insert "    ")                   ; else insert four spaces as expected
    ))

(defun zilongshanren/untab-region ()
  (interactive "p")
  (zilongshanren/indent-region -4))

(defun zilongshanren/hack-tab-key ()
  (interactive)
  (local-set-key (kbd "<tab>") 'zilongshanren/tab-region)
  (local-set-key (kbd "<S-tab>") 'zilongshanren/untab-region)
  )

(add-hook 'prog-mode-hook 'zilongshanren/hack-tab-key)


;; org export to html with 分享
;; (setq org-html-postamble-format                                                                        
;; '(("en"                                                                                                        
;;    "
;;     <!-- JiaThis Button BEGIN -->                                                                      
;;     <div class='jiathis_style'>                                                                        
;;     <span class='jiathis_txt'>分享到：</span>                                                          
;;     <a class='jiathis_button_tsina'>新浪微博</a>                                                       
;;     <a class='jiathis_button_douban'>豆瓣</a>                                                          
;;     <a class='jiathis_button_weixin'>微信</a>                                                          
;;     <a class='jiathis_button_evernote'>EverNote</a>                                                    
;;     <a class='jiathis_button_googleplus'>Google+</a>                                                   
;;                                                                                                        
;;     <a href='http://www.jiathis.com/share?uid=1891272';
;;     class='jiathis jiathis_txt jiathis_separator jtico
;;     jtico_jiathis' target='_blank'>更多</a> <a
;;     class='jiathis_counter_style'></a> </div> <script
;;     type='text/javascript' > var jiathis_config={
;;     data_track_clickback:true, summary:'', shortUrl:false,
;;     hideMore:false } </script> <script type='text/javascript'
;;     src='http://v3.jiathis.com/code/jia.js?uid=1891272';
;;     charset='utf-8'></script> <!-- JiaThis Button END -->
;;    ")))


;; Emacs support for (Petite) Chez Scheme  

;;;;;;;;;;;;
;; Scheme 
;;;;;;;;;;;;
;; (require 'cmuscheme)
;; (setq scheme-program-name "racket")         ;; 如果用 Petite 就改成 "petite"


;; bypass the interactive question and start the default interpreter
;; (defun scheme-proc ()
;;   "Return the current Scheme process, starting one if necessary."
;;   (unless (and scheme-buffer
;;	(get-buffer scheme-buffer)
;;	(comint-check-proc scheme-buffer))
;;(save-window-excursion
;;(run-scheme scheme-program-name)))
;;   (or (scheme-get-process)
;;(error "No current process. See variable `scheme-buffer'")))
;;
;;
;;   (defun scheme-split-window ()
;;   (cond
;;   ((= 1 (count-windows))
;;(delete-other-windows)
;;(split-window-vertically (floor (* 0.68 (window-height))))
;;(other-window 1)
;;(switch-to-buffer "*scheme*")
;;(other-window 1))
;;   ((not (find "*scheme*"
;;	(mapcar (lambda (w) (buffer-name (window-buffer w)))
;;		(window-list))
;;	:test 'equal))
;;(other-window 1)
;;(switch-to-buffer "*scheme*")
;;(other-window -1))))
;;
;;
;;   (defun scheme-send-last-sexp-split-window ()
;;   (interactive)
;;   (scheme-split-window)
;;   (scheme-send-last-sexp))
;;
;;
;;   (defun scheme-send-definition-split-window ()
;;   (interactive)
;;   (scheme-split-window)
;;   (scheme-send-definition))
;;
;;   (add-hook 'scheme-mode-hook
;;   (lambda ()
;;(paredit-mode 1)
;;(define-key scheme-mode-map (kbd "<f5>") 'scheme-send-last-sexp-split-window)
;;(define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)))


  
;; change the color of paren
(require 'parenface)
(set-face-foreground 'paren-face "DimGray")


;; change indentation in text-mode for emacs
(add-hook 'text-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq tab-width 2)
             (setq indent-line-function (quote insert-tab))))



(provide 'init-better-defaults)
