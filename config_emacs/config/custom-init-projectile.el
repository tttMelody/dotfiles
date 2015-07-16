;; all projectile command has prefix C-c p
;; ex. C-c p f  find file in project
(projectile-global-mode)

(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-globally-ignored-file-suffixes 
  '(;; elisp
	"elc"
	;; python
	"pyc"
	;; general documentations
	;; "txt"
	"rst" "doc" "html" "qdoc" "log" "mft" "ver" 
	"png" "jpg" "bmp" "tif"
	;; binary
	"dll" "lib" "exe"
	;; obj file
	".obj" ".o" ".so" ".a"
	;; unity
	".meta"
	))

(add-hook 'lua-mode-hook 'projectile-mode)
(add-hook 'csharp-mode-hook 'projectile-mode)

(provide 'custom-init-projectile)
