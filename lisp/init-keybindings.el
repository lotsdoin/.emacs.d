
(global-set-key (kbd "C-M-)") 'transparency-increase)
(global-set-key (kbd "C-M-(") 'transparency-decrease)


;;open init fast use F1
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f1>") 'open-my-init-file)

;; open init-packages.el use F2
(defun open-my-init-packages-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/init-packages.el"))
(global-set-key (kbd "<f2>") 'open-my-init-packages-file)

(defun open-my-keybindings-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/init-keybindings.el"))
(global-set-key (kbd "<f3>") 'open-my-keybindings-file)

(defun open-my-better-defaults-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/init-better-defaults.el"))
(global-set-key (kbd "<f4>") 'open-my-better-defaults-file)



;;将F10绑定为显示菜单栏
(global-set-key [(f10)] 'menu-bar-mode)


;;it don't work
(global-set-key (kbd "C-{") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-}") 'mc/mark-next-like-this)

(global-set-key (kbd "C-c m c") 'mc/edit-lines)

;; ivy-recentf better than recentf-open-files
;;(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(global-set-key (kbd "\C-x\ \C-r") 'ivy-recentf)

(global-set-key (kbd "\C-s") 'swiper)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-x") 'counsel-M-x) 
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
(global-set-key (kbd "C-x g") 'counsel-ag)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
;; (global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(global-set-key (kbd "M-/") 'undo-tree-visualize)


(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)

;; same as "/" in "vim normal mode"
(global-set-key (kbd "s-/") 'hippie-expand)

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

(with-eval-after-load 'dired
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))


(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)

;; (js2r-add-keybindings-with-prefix "C-c C-m")

(global-set-key (kbd "M-s i") 'counsel-imenu)


    (with-eval-after-load 'company
    (define-key company-active-map (kbd "M-n") nil)
    (define-key company-active-map (kbd "M-p") nil)
    (define-key company-active-map (kbd "C-n") #'company-select-next)
    (define-key company-active-map (kbd "C-p") #'company-select-previous))


(global-set-key (kbd "C-w") 'backward-kill-word)

;; It can do as "J" in vim.
;; (global-set-key (kbd "C-j")
;;	(lambda ()
;;	    (interactive)
;;	    (join-line -1)))

;; (ace-jump-mode 1)
;; (define-key global-map (kbd "C-c SPC") 'ace-jump-mode))
;; "C-c j j" ace-jump-mode, find letter 'j'
(global-set-key (kbd "C-c j") 'ace-jump-mode)

(global-set-key (kbd "C-x p") 'ace-window)

(provide 'init-keybindings)
