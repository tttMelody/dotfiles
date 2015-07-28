;;激活 AucTex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-view-program-list
	    '(("Preview" "/Applications/Preview.app/Contents/MacOS/Preview %q")))

(provide 'custom-init-auctex)
