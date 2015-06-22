(add-to-list 'load-path "~/.emacs.d/el-get/evil")
(require 'evil)

(define-key evil-motion-state-map ":" 'undefined)
(define-key evil-motion-state-map ";" 'evil-ex)
(evil-mode 1)


;;== evil-leader ==
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-key
  "e" 'helm-find-files
  "b" 'helm-buffers-list
  "r" 'helm-recentf
  "p" 'helm-projectile-find-file
  "k" 'kill-buffer)

;;== evil-nerd-comment with evil-leader ==
(evilnc-default-hotkeys)
(evil-leader/set-key
  "cl" 'evilnc-comment-or-uncomment-lines
  "ci" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "\\" 'evilnc-comment-operator ; if you prefer backslash key
)

;;== evil-matchit ==
(require 'evil-matchit)
(global-evil-matchit-mode 1)

;;== evil-easymotion ==
;(evil-leader/set-key
;  "w" (evilem-create 'evil-forward-word-begin))


;;== evil-org-mode
(require 'evil-org)


(provide 'dmx-init-evil)
