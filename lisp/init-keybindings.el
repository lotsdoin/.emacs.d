
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

;;将F10绑定为显示菜单栏
(global-set-key [(f10)] 'menu-bar-mode)


;;it don't work
(global-set-key (kbd "C-{") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-}") 'mc/mark-next-like-this)

(global-set-key (kbd "C-c m c") 'mc/edit-lines)


(global-set-key (kbd "\C-s") 'swiper)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-x") 'counsel-M-x) 
(global-set-key (kbd "C-x C-r") 'ivy-recentf)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
(global-set-key (kbd "C-x g") 'counsel-ag)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-x f") 'counsel-describe-function)
(global-set-key (kbd "C-x v") 'counsel-describe-variable)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

(global-set-key (kbd "M-/") 'undo-tree-visualize)

(global-set-key (kbd "C-c a") 'org-agenda)

(provide 'init-keybindings)
