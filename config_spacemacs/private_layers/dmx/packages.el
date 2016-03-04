;;; packages.el --- dmx Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq dmx-packages
    '(
      	org-pomodoro
      ))

;; List of packages to exclude.
(setq dmx-excluded-packages '())

;; For each package, define a function dmx/init-<package-name>
;;
(defun dmx/init-org-pomodoro ()
  "Initialize my package"
  (use-package org-pomodoro
    :defer t
    :init
    (progn
      (when (spacemacs/system-is-mac)
        (setq org-pomodoro-audio-player "/usr/bin/afplay"))
      (spacemacs/set-leader-keys-for-major-mode 'org-mode "p" 'org-pomodoro)
      (setq org-pomodoro-started-hook '(lambda () (dmx/terminal-notify "Pomodoro Started" "Go go go!" )))
      (setq org-pomodoro-finished-hook '(lambda () (dmx/terminal-notify "Pomodoro Finished" "☕️ Have a break!")))
      (setq org-pomodoro-short-break-finished-hook '(lambda () (dmx/terminal-notify "Short Break" "🐝 Ready to Go?")))
      (setq org-pomodoro-long-break-finished-hook '(lambda () (dmx/terminal-notify "Long Break" " 💪 Ready to Go?")))
      (setq org-pomodoro-killed-hook '(lambda () (dmx/terminal-notify "Oh no, don not leave" "Pomodoro has been killed!")))
      ))
  )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
