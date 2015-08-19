(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(setq el-get-emacs "/opt/local/bin/emacs")
(unless (require 'el-get nil 'noerror)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/"))
  (package-refresh-contents)
  (package-initialize)
  (package-install 'el-get)
  (require 'el-get))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

;; el-get 自动安装插件
(setq my-packages
	(append '(slime 
			  lua-mode 
			  php-mode
			  projectile 
			  yasnippet 
			  evil
			  evil-leader
			  evil-org-mode
              evil-nerd-commenter
              evil-matchit
              auctex
			  company-auctex
			  applescript-mode
			  ;; predictive ;; package for latex completion
			  expand-region
              company-mode
			  ;ido-vertical-mode
              powerline
              emmet-mode
			  color-theme ;; org-color-theme
			  swift-mode
			  highlight-parentheses
			  autopair
              rainbow-mode
			  ido-ubiquitous
			  smarttabs
              eim
			  cal-china-x
			  ;; org-journal ;; has encryption problem
              ;; emacs-eim
              git-gutter
			  magit
			  helm
			  helm-swoop
              ;; helm-dash
              helm-gtags
              helm-ag)))
(el-get 'sync my-packages)

;; 自定义的 package
;; 如果package和el-get recipes 中有重名，则会重写其中的属性
(el-get-bundle csharp-mode
  :url "https://github.com/josteink/csharp-mode.git"
  :type git
  :features csharp-mode)


(provide 'custom-init-el-get)
