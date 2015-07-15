;;== el-get ==
(add-to-list 'load-path "~/.emacs.d/config")
(require 'custom-emacs)

(custom-require 'custom-init-el-get)
(custom-require 'custom-init-slime)
(custom-require 'custom-init-helm)
(custom-require 'custom-init-evil)
(custom-require 'custom-init-projectile)
(custom-require 'custom-init-emacs-eim)
(custom-require 'custom-init-yasnippet)
(custom-require 'custom-init-lua-mode)
(custom-require 'custom-init-theme)
(custom-require 'custom-init-org-projects)

;(add-to-list 'load-path "~/.emacs.d/el-get/magit")
;(add-to-list 'load-path "~/.emacs.d/el-get/git-modes")
;(add-to-list 'load-path "~/.emacs.d/el-get/avy")

;;== company-mode ==
(add-hook 'after-init-hook 'global-company-mode)

;;== emmet-mode ==
(require 'emmet-mode)

(require 'swift-mode)

;;== expand-region ==
(add-to-list 'load-path "~/.emacs.d/el-get/expand-region")
(require 'expand-region)
;(global-set-key (kbd "C-=") 'er/expand-region)

;;== smarttabs ==
(add-to-list 'load-path "~/.emacs.d/el-get/smarttabs")
(autoload 'smart-tabs-mode "smart-tabs-mode" "Intelligently indent with tabs, align with spaces!")
(autoload 'smart-tabs-mode-enable "smart-tabs-mode")
(autoload 'smart-tabs-advice "smart-tabs-mode")
(autoload 'smart-tabs-insinuate "smart-tabs-mode")
(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'python )

;; common settings
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)
(global-linum-mode 1)
;; (setq linum-format "%d ")
(setq linum-format
     (lambda
       (line)
       (propertize
        (format
         (let
             ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))
;; when line is too long, wrap it to show
(global-visual-line-mode t)
(setq org-src-fontify-natively t)

;; backup file setting
(setq backup-directory-alist `((".*" . , "~/.emacs.d/backup")))
(setq backup-by-copying t)
(setq delete-old-versions t
	  kept-new-versions 6
	  kept-old-versions 2
	  version-control t)

;; enable syntax highlight
(setq global-font-lock-mode 1)
;; set tab stop
(setq default-indent-tabs-mode nil)
(setq indent-line-function 'insert-tab)
(setq default-tab-width 4)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-safe-themes
   (quote
 	("c3c0a3702e1d6c0373a0f6a557788dfd49ec9e66e753fb24493579859c8e95ab" default)))
 '(ido-mode (quote both) nil (ido))
 '(menu-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
