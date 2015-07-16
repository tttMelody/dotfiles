;; 禁止对global_gnu 等类似带有下划线的字符串做特殊处理
(setq org-export-with-sub-superscripts nil)
;; (add-to-list 'load-path "~/.emacs.d/el-get/htmlize")
;; (require 'htmlize)
;; org 工程配置

(setq org-tag-alist '((:startgroup . nil)
					  ("work" . ?w)
					  ("life" . ?f)
					  ("linux" . ?l)
					  ("learn" . ?e)
					  (:endgroup . nil)))
(setq org-publish-project-alist
           '(("ontes-org"
			  :base-directory "~/wb/evblog/"
			  :base-extension "org"
			  :publishing-directory "~/wb/evblog_export/"
			  :publishing-function org-html-publish-to-html
			  :headline-levels 3
			  :select-tags t
			  :section-numbers t
			  :with-timestamps t
			  :with-toc t
			  :with-tags t
              :recursive t
			  :makeindex t
			  :html-head-include-default-style nil
			  :html-head-include-scripts nil ;; 导出html时禁止include default javascript snippets
			  :html-head "<link  rel=\"stylesheet\" href=\"fancy/bower_components/bootstrap/dist/css/bootstrap.min.css\" type=\"text/css\"/>
<link  rel=\"stylesheet\" href=\"fancy/mystyle.css\" type=\"text/css\"/>
<script type=\"text/javascript\" src=\"fancy/bower_components/jquery/dist/jquery.min.js\"></script>
<script type=\"text/javascript\" src=\"fancy/bower_components/bootstrap/dist/js/bootstrap.min.js\"></script>
<script type=\"text/javascript\" src=\"fancy/custom_script.js\"></script>"
			  :html-preamble t
			  :html-postamble nil
			  :auto-sitemap	t
			  ;:sitemap-filename	 ;; default sitemap.html
			  :sitemap-title "dmx-notes"
			  ;:sitemap-function	org-publish-org-sitema
			  ;:sitemap-sort-folders	
			  ;:sitemap-sort-files	
			  :sitemap-ignore-case t
			  ;:sitemap-file-entry-format
			  ;:sitemap-date-format	
			  ;:sitemap-sans-extension
			  )

             ("notes-static"
              :base-directory "~/wb/evblog/"
              :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
              :publishing-directory "~/wb/evblog_export/"
              :recursive t
              :publishing-function org-publish-attachment)
     
              ("notes" :components ("notes-org" "notes-static"))))

;; (setq org-src-fontify-natively t)

(provide 'custom-init-org-projects)
