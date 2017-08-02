0 (when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			      ("melpa" . "http://elpa.emacs-china.org/melpa/")
			      ("org" . "http://elpa.emacs-china.org/org/")
			      )))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

 ;; cl - Common Lisp Extension
 (require 'cl)

 ;; Add Packages
 (defvar my/packages '(
                ;; --- Auto-completion ---
                company
                ;; --- Better Editor ---
                evil-escape
		ace-window
		org-plus-contrib
		evil-leader
                hungry-delete
		markdown-mode
		pangu-spacing
		smartparens
		dash
                swiper
                counsel
                smartparens
                ;; --- Major Mode ---
                js2-mode
                ;; --- Minor Mode ---
                ;; --- Themes ---
                monokai-theme
                solarized-theme
                ) "Default packages")

 (setq package-selected-packages my/packages)

 (defun my/packages-installed-p ()
     (loop for pkg in my/packages
           when (not (package-installed-p pkg)) do (return nil)
           finally (return t)))

 (unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
         (package-install pkg))))

 ;; Find Executable Path on OS X
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))

(counsel-mode t)

;; (powerline-center-theme)
;; (setq powerline-default-separator 'arrow)

(evil-mode t)

(global-company-mode t)

;; Add空格between letter and汉字。
(require 'pangu-spacing)
(global-pangu-spacing-mode 1)

(autopair-global-mode)

(global-undo-tree-mode)
;; Delete fast
(global-hungry-delete-mode t)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)


;; (require 'evil)
(evil-mode 1)
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)

;; (global-evil-leader-mode)
;; (evil-leader/set-key
;; "ff" 'find-file
;; "fr" 'recentf-open-files
;; "bb" 'switch-to-buffer
;; "bk" 'kill-buffer
;; "pf" 'counsel-git
;; "ps" 'helm-do-ag-project-root
;; "0" 'select-window-0
;; "1" 'select-window-1
;; "2" 'select-window-2
;; "3" 'select-window-3
;; "fj" 'dired-jump
;; "w/" 'split-window-right
;; "w-" 'split-window-below
;; ":" 'counsel-M-x
;; "wm" 'delete-other-windows
;; "qq" 'save-buffers-kill-terminal
;; "sj" 'counsel-imenu
;; "sp" 'counsel-git-grep
;; )

;; press "jk" replace press ESC
(evil-escape-mode t)
(setq-default evil-escape-key-sequence "jk")
(setq-default evil-escape-delay 0.1)

(provide 'init-packages)
