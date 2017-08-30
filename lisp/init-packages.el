(when (>= emacs-major-version 24)
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
		helm
	        dash
                swiper
                counsel
                smartparens
		;; --- C++ Mode ---
		auto-complete
		
		;; --- Python Mode ---
		iedit
		json-mode
		elpy
                ;; --- Major Mode ---
                js2-mode
                ;; --- Minor Mode ---
                ;; --- Themes ---
                tronesque-theme
		cyberpunk-theme
		material-theme
		ahungry-theme
		tramp-theme
		abyss-theme
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

(ivy-mode -1)
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
;; "ps" 'helm-do-ag-project-roo
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

;; Python mode
; Enable elpy mode
(elpy-enable)
; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)

;; C++ Mode
; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)
; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/5.4.0/include/")
)
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

; Fix iedit bug in Mac
;; (define-key global-map (kbd "C-c ;") 'iedit-mode)

; start flymake-google-cpplint-load
; let's define a function for flymake initialization
;; (defun my:flymake-google-init () 
;; (require 'flymake-google-cpplint)
;; (custom-set-variables
;; '(flymake-google-cpplint-command "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/cpplint"))
;; (flymake-google-cpplint-load)
;; )
;; (add-hook 'c-mode-hook 'my:flymake-google-init)
;; (add-hook 'c++-mode-hook 'my:flymake-google-init)

; start google-c-style with emacs
;; (require 'google-c-style)
;; (add-hook 'c-mode-common-hook 'google-set-c-style)
;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)

; turn on Semantic
(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete() 
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
; turn on ede mode 
(global-ede-mode 1)
; create a project for our program.
(ede-cpp-root-project "my project" :file "~/lotsd/projects/C++/main.cpp"
		      :include-path '("/../my_inc"))
; you can use system-include-path for setting up the system header file locations.
; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)


(provide 'init-packages)
