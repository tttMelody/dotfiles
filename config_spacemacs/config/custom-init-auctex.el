;;激活 AucTex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-view-program-list
	    '(("Preview" "/Applications/Preview.app/Contents/MacOS/Preview %q")))

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'latex-mode-hook 'turn-on-reftex)

(require 'company-auctex)
(company-auctex-init)

(provide 'custom-init-auctex)
