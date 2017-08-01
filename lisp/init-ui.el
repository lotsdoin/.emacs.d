;; Open with full screen
;; (setq initial-frame-alist (quote ((fullscreen . maximized))))
;;(load-theme 'wombat)
;;(load-theme 'monokai)
(menu-bar-mode -1)
(global-linum-mode)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; (set-default 'cursor-type 'hbar)
(set-default 'cursor-type 'bar)
(global-hl-line-mode)
;;关闭启动画面
(setq inhibit-startup-message t)
;; 尽快显示按键序列
(setq echo-keystrokes 0.1)
;;默认显示 80列就换行
(setq default-fill-column 80)
;; mode line上的时间显示
(display-time-mode t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
;;(setq display-time-interval 60)
;;进行语法加亮
(global-font-lock-mode t)
;;高亮光标处单词
;;(require 'highlight-symbol)
(global-set-key [(control f8)] 'highlight-symbol-at-point)
(global-set-key [f8] 'highlight-symbol-next)
(global-set-key [(shift f8)] 'highlight-symbol-prev)

 ;;测试文字 "SimHei" "Yahei Consolas Hybrid"
;; (set-default-font "Monaco 9")
;; (set-fontset-font "fontset-default"  
;;	    'gb18030' ("Yahei Consolas Hybrid" . "unicode-bmp"))

  ;; Setting English Font Consolas
  (set-face-attribute
   'default nil :font "Monaco 9")
  ;; Setting Chinese Font
  ;;测试文字
(dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "Yahei Consolas Hybrid" :size 12)))
  






(provide 'init-ui)

