;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; 模块化
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'init-packages)
(require 'init-ui)
(require 'init-better-defaults)
(require 'init-keybindings)
(require 'org)

(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
(load-file custom-file)



;; (custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(company-dabbrev-minimum-length 1)
;; '(custom-safe-themes
;; (quote
;;("9492cf1ac00c8a1f7130a867a97404dfeb6727801c6b2b40b853b91543f7af67" default)))
;; '(package-selected-packages
;; (quote
;;(counsel evil cl-lib-highlight js2-mode ivy powerline monokai-theme company ace-jump-mode undo-tree auto-complete autopair ))))
;; (custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; )
(put 'dired-find-alternate-file 'disabled nil)
