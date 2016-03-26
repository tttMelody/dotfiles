
(defun dmx/terminal-notify (title message)
 "Send a notification via terminal-notifier"
  ;; (call-process "/opt/local/bin/terminal-notifier")
 (progn
   (setq dmx-notification-command (format "/opt/local/bin/terminal-notifier -message \"%s\" -title \"%s\" -sound moof" title message))
   (shell-command-to-string dmx-notification-command))
 )
(defun dmx/linum-config ()
  ;; 开启行号
  (global-linum-mode)
  (with-eval-after-load 'linum
						(linum-relative-toggle))

  ;; org mode 禁用行号
  (add-hook 'org-mode-hook (lambda ()
							  "disable linum in org mode"
							  (linum-mode 0)))
  ;; helm buffer 禁用行号
  (add-hook 'helm-after-initialize-hook (lambda ()
										  (with-helm-buffer
											(linum-mode 0)))))
