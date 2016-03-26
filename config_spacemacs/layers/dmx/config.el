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
	  )
