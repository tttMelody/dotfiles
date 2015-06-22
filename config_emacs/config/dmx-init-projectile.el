;; all projectile command has prefix C-c p
;; ex. C-c p f  find file in project
(projectile-global-mode)

(setq projectile-completion-system 'helm)
(helm-projectile-on)
(add-hook 'lua-mode-hook 'projectile-mode)
(add-hook 'csharp-mode-hook 'projectile-mode)

(provide 'dmx-init-projectile)
