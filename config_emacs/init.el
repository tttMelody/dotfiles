;;== el-get ==
(add-to-list 'load-path "~/.emacs.d/config")
(require 'custom-emacs)

; http://andrewjamesjohnson.com/suppressing-ad-handle-definition-warnings-in-emacs/
;(setq ad-redefinition-action 'accept)

;;== load important plugins ==
(custom-require 'custom-init-el-get)
(custom-require 'custom-init-slime)
(custom-require 'custom-init-helm)
(custom-require 'custom-init-evil)
(custom-require 'custom-init-projectile)
;(custom-require 'custom-init-emacs-eim)
(custom-require 'custom-init-yasnippet)
(custom-require 'custom-init-lua-mode)
(custom-require 'custom-init-theme)
(custom-require 'custom-init-org-projects)
;; (custom-require 'custom-init-org-journal)
(custom-require 'custom-init-cal-china-x)
(custom-require 'custom-init-auctex)

;== powerline ==
(require 'powerline)
(powerline-center-evil-theme)

;;== company-mode ==
(add-hook 'after-init-hook 'global-company-mode)

;;== emmet-mode ==
(require 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'html-mode-hook 'emmet-mode)

;;== swift-mode ==
(require 'swift-mode)

;;== expand-region ==
(add-to-list 'load-path "~/.emacs.d/el-get/expand-region")
(require 'expand-region)
;(global-set-key (kbd "C-=") 'er/expand-region)

;;== auto-save-place ==
(require 'saveplace)
(setq-default save-place t)

;;== smarttabs ==
(add-to-list 'load-path "~/.emacs.d/el-get/smarttabs")
(autoload 'smart-tabs-mode "smart-tabs-mode" "Intelligently indent with tabs, align with spaces!")
(autoload 'smart-tabs-mode-enable "smart-tabs-mode")
(autoload 'smart-tabs-advice "smart-tabs-mode")
(autoload 'smart-tabs-insinuate "smart-tabs-mode")
(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'python )


;; highlight-parentheses and autopair need to install manually
;;== highlight-parentheses ==
;; 显示匹配的括号
(show-paren-mode 1) ;; buildin show-paren-mode
(setq show-paren-delay 0)
(global-highlight-parentheses-mode t)

;;== autopair ==
;(add-hook 'highlight-parentheses-mode-hook
;          '(lambda ()
;             (setq autopair-handle-action-fns
;                   (append
;                    (if autopair-handle-action-fns
;                        autopair-handle-action-fns
;                      '(autopair-default-handle-action))
;                    '((lambda (action pair pos-before)
;                        (hl-paren-color-update)))))))
;(define-globalized-minor-mode global-highlight-parentheses-mode
;  highlight-parentheses-mode
;  (lambda ()
;    (highlight-parentheses-mode t)))
;(autopair-global-mode t)

;;== smartparens ==
(require 'smartparens-config)
(smartparens-global-mode t)

;; common settings
;(setq scroll-step 1)
;(setq scroll-conservatively 10000)
;(setq auto-window-vscroll nil)
;(global-linum-mode 1)
;; (setq linum-format "%d ")
;(setq linum-format
;     (lambda
;       (line)
;       (propertize
;        (format
;         (let
;             ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))
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
;; make org timestamp show Chinese format
(set-locale-environment "zh_CN.utf-8")

(setq view-diary-entries-initially t
	  mark-diary-entries-in-calendar t
	  number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-safe-themes
   (quote
	("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(helm-gtags-auto-update t)
 '(helm-gtags-display-style (quote detail))
 '(helm-gtags-fuzzy-match t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-path-style (quote absolute))
 '(ido-mode (quote both) nil (ido))
 '(menu-bar-mode nil)
 '(org-agenda-files
   (quote
	("~/wb/learn/postgresql/note.org" "/Users/dmx/wb/learn/README.org" "/Users/dmx/wb/orgs/credit_card.org" "/Users/dmx/wb/orgs/learn.org" "/Users/dmx/wb/orgs/life_2015.org" "/Users/dmx/wb/orgs/resume.org" "/Users/dmx/wb/orgs/work.org" "/Users/dmx/wb/orgs/work_2015.org")))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#fdf6e3" :foreground "#657b83" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 180 :width normal :foundry "nil" :family "Menlo for Powerline")))))
;; 如果是软连接，跟随
(setq vc-follow-symlinks t)
;; vc中的文件保存时不提示
(setq vc-suppress-confirm t)
