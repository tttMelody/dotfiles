(setq helm-autoresize-max-height 80
	  helm-autoresize-min-height 20
	  ;; linum
	  linum-relative-format "%3s "
	  ;; 设置yasnippet 补全的时候不增加缩进
	  yas-indent-line 'fixed
	  yas-snippet-dirs '("~/.spacemacs.d/yasnippet/snippets" yas-installed-snippets-dir)
	  ;; 如果是软连接，跟随
	  vc-follow-symlinks t
	  ;; vc中的文件保存时不提示
	  vc-suppress-confirm t

	  evil-want-C-d-scroll t
	  evil-want-C-u-scroll t
	  ;; org-page
	  op/repository-directory "~/Documents/github/dingmingxin.github.io"
	  op/repository-org-branch "source"
	  op/repository-html-branch "master"
	  op/personal-google-analytics-id "UA-77360714-1"
	  op/personal-github-link "https://github.com/dingmingxin"
	  op/site-domain "http://dingmingxin.github.io/"
	  op/site-main-title "勿忘初心，方得始终"
	  op/site-sub-title "()==[:::::::::::::> 重剑无锋，大巧不工 "
	  op/theme 'mdo
	  op/category-config-alist '(("blog" ;; this is the default configuration
								  :show-meta t
								  :show-comment t
								  :uri-generator op/generate-uri
								  :uri-template "/blog/%y/%m/%d/%t/"
								  :sort-by :date     ;; how to sort the posts
								  :category-index t) ;; generate category index or not
								 ("index"
								  :show-meta nil
								  :show-comment nil
								  :uri-generator op/generate-uri
								  :uri-template "/"
								  :sort-by :date
								  :category-index nil)
								 ("about"
								  :show-meta nil
								  :show-comment nil
								  :uri-generator op/generate-uri
								  :uri-template "/about/"
								  :sort-by :date
								  :category-index nil))
	  )

;; Make movement keys work like they should
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;(add-hook 'after-init-hook 'global-company-mode)
;(company-ycmd-setup)
(set-variable 'ycmd-server-command (list "python" (expand-file-name "Documents/github/ycmd/ycmd" "~/")))
(add-hook 'c++-mode-hook 'ycmd-mode)
