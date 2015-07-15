
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
;; (defface org-block-begin-line
;;   '((t (:foreground "#008ED1" :background "#A7A6AF")))
;;   "Face used for the line delimiting the begin of source blocks.")

;; (defface org-block-background
;;   '((t (:background "#FFFFEA")))
;;   "Face used for the source block background.")

;; (defface org-block-end-line
;;   '((t (:foreground "#008ED1" :background "#EAEAFF")))
;;     "Face used for the line delimiting the end of source blocks.")

(provide 'custom-init-theme)
