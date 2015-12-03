;;== yasnipet ==
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.spacemacs.d/yasnippet/snippets" yas-installed-snippets-dir))
;(define-key yas-minor-mode-map (kbd "<tab>") nil)
;(define-key yas-minor-mode-map (kbd "TAB") nil)
;(define-key yas-minor-mode-map (kbd "C-x ,") 'yas-expand)

(yas-global-mode 1)

(provide 'custom-init-yasnippet)
