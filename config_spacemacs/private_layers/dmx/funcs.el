
(defun dmx/terminal-notify (title message)
 "Send a notification via terminal-notifier"
  ;; (call-process "/opt/local/bin/terminal-notifier")
 (progn
   (setq dmx-notification-command (format "/opt/local/bin/terminal-notifier -message \"%s\" -title \"%s\" -sound moof" title message))
   (shell-command-to-string dmx-notification-command))
 )
