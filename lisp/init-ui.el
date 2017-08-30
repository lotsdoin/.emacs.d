;; Open with full screen
;; (setq initial-frame-alist (quote ((fullscreen . maximized))))
;;(load-theme 'wombat)
(load-theme 'tramp t)
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
(setq display-time-interval 60)
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
   'default nil :font "Monaco 9")  ;; Setting Chinese Font
  ;;测试文字
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                       charset
                       (font-spec :family "Yahei Consolas Hybrid" :size 12)))
  
;; (defun s-font()
;; (interactive)
;; ;; font config for org table showing.
;; (set-default-font "monospace-11")
;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;(set-fontset-font (frame-parameter nil 'font)
;;		charset
;;		(font-spec :family "WenQuanYi Micro Hei")))
;; ;; tune rescale so that Chinese character width = 2 * English character width
;; (setq face-font-rescale-alist '(("monospace" . 1.0) ("WenQuanYi" . 1.23))))
;;
;; (add-to-list 'after-make-frame-functions
;;	(lambda (new-frame)
;;	(select-frame new-frame)
;;	(if window-system
;;	    (s-font))))
;; (if window-system
;;(s-font))

;; evil-state-tag 设置如下:
;; (setq evil-normal-state-tag (propertize "[Normal]" 'face '((:background "green" :foreground "black")))
;;       evil-emacs-state-tag    (propertize "[Emacs]" 'face '((:background "orange" :foreground "black")))
;;       evil-insert-state-tag   (propertize "[Insert]" 'face '((:background "red") :foreground "white"))
;;       evil-motion-state-tag   (propertize "[Motion]" 'face '((:background "blue") :foreground "white"))
;;       evil-visual-state-tag   (propertize "[Visual]" 'face '((:background "grey80" :foreground "black")))
;;       evil-operator-state-tag (propertize "[Operator]" 'face '((:background "purple"))))
    (setq evil-normal-state-tag   (propertize "[N]" 'face '((:background "DarkGoldenrod2" :foreground "black")))
          evil-emacs-state-tag    (propertize "[E]" 'face '((:background "SkyBlue2" :foreground "black")))
          evil-insert-state-tag   (propertize "[I]" 'face '((:background "chartreuse3") :foreground "white"))
          evil-motion-state-tag   (propertize "[M]" 'face '((:background "plum3") :foreground "white"))
          evil-visual-state-tag   (propertize "[V]" 'face '((:background "gray" :foreground "black")))
          evil-operator-state-tag (propertize "[O]" 'face '((:background "purple"))))
;; 简化 major-mode 的名字，替换表中没有的显示原名

(defun codefalling//simplify-major-mode-name ()
  "Return simplifyed major mode name"
  (let* ((major-name (format-mode-line "%m"))
         (replace-table '(Emacs-Lisp "𝝀"
                                     Spacemacs\ buffer "𝓢"
                                     Python "𝝅"
                                     Shell ">"
                                     Makrdown "𝓜"
                                     GFM "𝓜"
                                     Org "𝒪"
                                     Text "𝓣"
                                     Fundamental "ℱ"
                                     ))
         (replace-name (plist-get replace-table (intern major-name))))
    (if replace-name replace-name major-name
        )))

(setq-default
 mode-line-format
 (list
  ;; the buffer name; the file name as a tool tip
  " "
  '(:eval (propertize "%b " 'face 'font-lock-keyword-face
                      'help-echo (buffer-file-name)))

  ;; line and column
  "(" ;; '%02' to set to 2 chars at least; prevents flickering
  (propertize "%02l" 'face 'font-lock-type-face) ","
  (propertize "%02c" 'face 'font-lock-type-face)
  ") "

  ;; relative position, size of file
  "["
  (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
  "/"
  (propertize "%I" 'face 'font-lock-constant-face) ;; size
  "] "

  ;; the current major mode for the buffer.
  "["

  '(:eval (propertize (codefalling//simplify-major-mode-name) 'face 'font-lock-string-face
                      'help-echo buffer-file-coding-system))
  "] "


  "[" ;; insert vs overwrite mode, input-method in a tooltip
  '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
                      'face 'font-lock-preprocessor-face
                      'help-echo (concat "Buffer is in "
                                         (if overwrite-mode "overwrite" "insert") " mode")))

  ;; was this buffer modified since the last save?
  '(:eval (when (buffer-modified-p)
            (concat ","  (propertize "Mod"
                                     'face 'font-lock-warning-face
                                     'help-echo "Buffer has been modified"))))

  ;; is this buffer read-only?
  '(:eval (when buffer-read-only
            (concat ","  (propertize "RO"
                                     'face 'font-lock-type-face
                                     'help-echo "Buffer is read-only"))))
  "] "

  ;; evil state
  '(:eval (evil-generate-mode-line-tag evil-state))

  " "
  ;; add the time, with the date and the emacs uptime in the tooltip "%H:%M"
  '(:eval (propertize (format-time-string "%Y-%m-%d %a %H:%M")
                      'help-echo
                      (concat (format-time-string "%c; ")
                              (emacs-uptime "Uptime:%hh"))))
  " --"
  ;; i don't want to see minor-modes; but if you want, uncomment this:
  ;; minor-mode-alist  ;; list of minor modes
  "%-" ;; fill with '-'
  ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Theme hooks

(defvar gh/theme-hooks nil
  "((theme-id . function) ...)")

(defun gh/add-theme-hook (theme-id hook-func)
  (add-to-list 'gh/theme-hooks (cons theme-id hook-func)))

(defun gh/disable-all-themes ()
  (interactive)
  (mapc #'disable-theme custom-enabled-themes))

(defun gh/load-theme-advice (f theme-id &optional no-confirm no-enable &rest args)
  "Enhances `load-theme' in two ways:
1. Disables enabled themes for a clean slate.
2. Calls functions registered using `gh/add-theme-hook'."
  (unless no-enable
    (gh/disable-all-themes))
  (prog1
      (apply f theme-id no-confirm no-enable args)
    (unless no-enable
      (pcase (assq theme-id gh/theme-hooks)
        (`(,_ . ,f) (funcall f))))))

(advice-add 'load-theme
            :around
            #'gh/load-theme-advice)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  
(provide 'init-ui)

