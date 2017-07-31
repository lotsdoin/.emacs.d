(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
;;(load-theme 'wombat)
;;(load-theme 'monokai)

(setq visible-bell t)
(menu-bar-mode -1)
(global-linum-mode)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; (set-default 'cursor-type 'hbar)
(set-default 'cursor-type 'bar)
;; disbale backup file
(setq make-backup-file nil)
(ido-mode t)
(column-number-mode)
(show-paren-mode)
;; show match parents
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(global-hl-line-mode)
(winner-mode t)
(windmove-default-keybindings)
;;关闭启动画面
(setq inhibit-startup-message t)
;; 尽快显示按键序列
(setq echo-keystrokes 0.1)
;; 用来显示当前光标在哪个函数
(which-func-mode 1)
;;默认显示 80列就换行
(setq default-fill-column 80)
;;自动重载更改的文件
(global-auto-revert-mode 1)
;; 在文档最后自动插入空白行
(setq require-final-newline t)

;; mode line上的时间显示
(display-time-mode t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
;;(setq display-time-interval 60)

;;进行语法加亮
(global-font-lock-mode t)

;;鼠标滚轮，默认的滚动太快，这里改为3行
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

;;高亮光标处单词
;;(require 'highlight-symbol)
(global-set-key [(control f8)] 'highlight-symbol-at-point)
(global-set-key [f8] 'highlight-symbol-next)
(global-set-key [(shift f8)] 'highlight-symbol-prev)

 ;;测试文字
(set-default-font "Monaco-9")
(set-fontset-font "fontset-default"  
                  'gb18030' ("SimHei" . "unicode-bmp"))


(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
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




(provide 'init-better-defaults)

