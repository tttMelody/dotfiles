;;== yasnipet ==
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/self_install/yasnippet/snippets"))
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-x ,") 'yas-expand)

(yas-global-mode 1)

(provide 'dmx-init-yasnippet)
