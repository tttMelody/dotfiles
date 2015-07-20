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

(setq-default org-display-custom-times t)
(setq org-time-stamp-formats '("<%Y-%m-%d %A>" . "<%Y-%m-%d %A %H:%M>"))
(setq org-time-stamp-custom-formats  '("<%Y-%m-%d %A>" . "<%Y-%m-%d %A %H:%M>"))


;; org-agenda setting
;; 依赖于cal-china-x
(require 'org-agenda)
(defalias 'org-agenda-format-date-aligned 'custom-org-agenda-format-date-aligned)
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

;; add files to agenda mode 
(setq org-agenda-files '("~/wb/gtd"))

(provide 'custom-init-org-projects)
