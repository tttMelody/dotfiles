(add-to-list 'load-path "~/.emacs.d/el-get/evil")
(require 'evil)
(define-key evil-motion-state-map ":" 'undefined)
(define-key evil-motion-state-map ";" 'evil-ex)


;;== evil-leader ==
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-key
  "e" 'helm-find-files
  "b" 'helm-buffers-list
  "k" 'kill-buffer)

;;== evil-org-mode
(require 'evil-org)


(provide 'dmx-init-evil)
