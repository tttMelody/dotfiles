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
	  )

;;--begin org config--
(add-hook 'org-mode-hook
		  (lambda ()
			(local-set-key (kbd "M-O") 'org-insert-heading-after-current)
			(evil-define-key 'normal evil-jumper-mode-map (kbd "TAB") nil)
			(define-key evil-normal-state-map (kbd "TAB") 'org-cycle)

			;; add files to agenda mode
			(setq org-agenda-files '("~/orgs/" "~/orgs/playcrab/" "~/orgs/common/"))
			;;== todo setting ==

			;;== org-babel setting ==
			(setq org-babel-sh-command "/opt/local/bin/bash")
			(setq org-hide-leading-stars t)
			(org-babel-do-load-languages
			 'org-babel-load-languages
			 '((emacs-lisp . t)
			   (sh . t)
			   (js . t)
			   (lua . t)
			   (C . t)
			   (sed . t)
			   (awk . t)
			   (lisp . t)))))

;; 有些org 配置直接放到上面的org-mode-hook 中，不知道什么鬼，偶尔有几个配置会不生效
;; 禁止对global_gnu 等类似带有下划线的字符串做特殊处理
(setq org-export-with-sub-superscripts nil)
(setq org-tag-alist '((:startgroup . nil)
					  ("@work" . ?w)
					  ("@life" . ?L)
					  ("@learn" . ?l)
					  ("@programming" . nil)
					  (:endgroup . nil)
					  ("linux" . ?l)
					  ("unity". ?u)
					  ("emacs" . ?E)
					  ("common_lisp" . nil)
					  ("lua" . nil)
					  ("c/c++" . nil)
					  ("opengl" . nil)))
(setq org-use-fast-todo-selection t)
(setq org-use-fast-tag-selection t)
(setq-default org-display-custom-times t)
(setq org-time-stamp-formats '("<%Y-%m-%d %A>" . "<%Y-%m-%d %A %H:%M>"))
(setq org-time-stamp-custom-formats  '("<%Y-%m-%d %A>" . "<%Y-%m-%d %A %H:%M>"))
(setq org-todo-keywords
	  '((sequence "TODO(t)" "DOING(o)" "|" "DONE(d)")
		(sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
		(sequence "|" "CANCELED(c)")))
; org-agenda setting
;; 依赖于cal-china-x
 (defun custom-org-agenda-format-date-aligned (date)
   "Format a date string for display in the daily/weekly agenda, or timeline.
 This function makes sure that dates are aligned for easy reading."
   (require 'cal-iso)
   (require 'cal-china-x)
   (let* ((dayname (cal-china-x-day-name date))
		  (day (cadr date))
		  (day-of-week (calendar-day-of-week date))
		  (month (car date))
		  (monthname (format "%02d" month))
		  (year (nth 2 date))
		  (iso-week (org-days-to-iso-week
					 (calendar-absolute-from-gregorian date)))
		  (weekyear (cond ((and (= month 1) (>= iso-week 52))
						   (1- year))
						  ((and (= month 12) (<= iso-week 1))
						   (1+ year))
						  (t year)))
		  (weekstring (if (= day-of-week 1)
						  (format " W%02d" iso-week)
						"")))
	 (format "%-10s %4d/%s/%02d %s" dayname year monthname day weekstring)))
(defalias 'org-agenda-format-date-aligned 'custom-org-agenda-format-date-aligned)

;;--end org config--

;;--begin org-page config--
(setq op/repository-directory "~/Documents/github/dingmingxin.github.io"
	  op/repository-org-branch "source"
	  op/repository-html-branch "master"
	  op/personal-google-analytics-id "UA-77360714-1"
	  op/personal-github-link "https://github.com/dingmingxin"
	  op/personal-disqus-shortname "everding"
	  op/site-domain "http://dingmingxin.github.io/"
	  op/site-main-title "从Hello World开始"
	  op/site-sub-title "()==[:::::::::::::> 重剑无锋，大巧不工 "
	  op/theme 'mdo
	  op/category-config-alist '(("blog" ;; this is the default configuration
								  :show-meta t
								  :show-comment t
								  :uri-generator op/generate-uri
								  :uri-template "/blog/%y/%m/%d/%t/"
								  :sort-by :date     ;; how to sort the posts
								  :category-index t) ;; generate category index or not
								 ("wiki" ;; this is the default configuration
								  :show-meta t
								  :show-comment t
								  :uri-generator op/generate-uri
								  :uri-template "/wiki/%y/%m/%d/%t/"
								  :sort-by :date     ;; how to sort the posts
								  :category-index t)
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
								  :category-index nil)))

;;--end org-page config

(setq visual-line-mode t)
(setq python-shell-interpreter "/opt/local/bin/python")
;; Make movement keys work like they should
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;(add-hook 'after-init-hook 'global-company-mode)
;(company-ycmd-setup)
(set-variable 'ycmd-server-command (list "python" (expand-file-name "Documents/github/ycmd/ycmd" "~/")))
(add-hook 'c++-mode-hook 'ycmd-mode)
