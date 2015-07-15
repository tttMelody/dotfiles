
(add-to-list 'load-path "~/.emacs.d/themes")
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(load "color-theme-tangotango")
(load "color-theme-molokai")
(add-hook 'after-init-hook
		  (lambda ()
			(progn
			  (color-theme-molokai))))

(provide 'custom-init-theme)
