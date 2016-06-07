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
		(org-page :location (recipe :fetcher github :repo "dingmingxin/org-page" :files ("*.el" "doc" "themes")))
		cal-china-x
		;; smart-tabs-mode
		smart-tab
		company-ycmd
		ycmd
		dash-functional
		toc-org
		ob-lua
		slime
		rainbow-mode
		))

;; List of packages to exclude.
(setq dmx-excluded-packages '())

;; For each package, define a function dmx/init-<package-name>
;;
(defun dmx/init-org-pomodoro ()
  "Initialize org-pomodoro"
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
	  (setq org-pomodoro-killed-hook '(lambda () (dmx/terminal-notify "Oh no, don not leave" "Pomodoro has been killed!"))))))

(defun dmx/init-ob-lua ()
  "Initialize ob-lua"
  (use-package ob-lua
	:defer t
	:init
	(progn
	  (message "Loading ob-lua"))))

(defun dmx/init-cal-china-x ()
  "Initialize cal-china-x"
  (use-package cal-china-x
	:defer t
	:init
	(require 'cal-china-x)
	(progn
	  ;;--begin cal-china-x config
	  (setq mark-holidays-in-calendar t)
	  (setq cal-china-x-dmx-holidays
			'((holiday-fixed 1 1 "元旦")
			  (holiday-lunar 12 30 "春节" 0)
			  (holiday-lunar 1 1 "春节" 0)
			  (holiday-lunar 1 2 "春节" 0)
			  (holiday-solar-term "清明" "清明节")
			  (holiday-fixed 5 1 "劳动节")
			  (holiday-lunar 5 5 "端午节" 0)
			  (holiday-float 6 0 3 "父亲节")
			  (holiday-lunar 8 15 "中秋节" 0)
			  (holiday-fixed 10 1 "国庆节")))
	  (setq cal-china-x-important-holidays cal-china-x-dmx-holidays)
	  (setq calendar-holidays cal-china-x-important-holidays)
	  (setq chinese-calendar-celestial-stem
			["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"]
			chinese-calendar-terrestrial-branch
			["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])

	  ;; 显示 星期数
	  (copy-face font-lock-constant-face 'calendar-iso-week-face)
	  (set-face-attribute 'calendar-iso-week-face nil
						  :height 0.7)
	  (setq calendar-intermonth-text
			'(propertize
			  (format "%2d"
					  (car
					   (calendar-iso-from-absolute
						(calendar-absolute-from-gregorian (list month day year)))))
			  'font-lock-face 'calendar-iso-week-face))
	  (setq calendar-intermonth-header
			(propertize "Wk"                  ; or e.g. "KW" in Germany
						'font-lock-face 'calendar-iso-week-header-face))

	  ;; 显示当日是否有笔记
	  (setq view-diary-entries-initially t
			mark-diary-entries-in-calendar t
			number-of-diary-entries 7)
	  (add-hook 'diary-display-hook 'fancy-diary-display)
	  (add-hook 'today-visible-calendar-hook 'calendar-mark-today)
	  ;;--end cal-china-x config
	  (message "Loading %s..." "cal-china-x"))))

(defun dmx/pre-init-cal-china-x()
  "Pre-init cal-china-x"
   (message "pre init cal-china-x"))
(defun dmx/init-slime()
  "Initialize slime"
  (use-package slime
	:defer t
	:init
	(progn
	  (require 'slime-autoloads)
	  (setq slime-contribs '(slime-fancy))
	  (setq slime-lisp-implementations
			`((sbcl ("/opt/local/bin/sbcl"))
			  (abcl ("/opt/local/bin/abcl"))
			  (clisp ("/opt/local/bin/clisp"))))
	  (setq inferior-lisp-program "/opt/local/bin/sbcl")
	  (slime-setup  '(slime-repl slime-asdf slime-fancy slime-banner))
	  (message "Loading %s..." "slime")
	  )
	)
  )

(defun dmx/init-smart-tab()
  "Initialize smart-tab"
  (use-package smart-tab
	:defer t
	:init
	(progn
	  (setq smart-tab-using-hippie-expand t)
	  (message "Loading %s..." "smart-tab"))))

(defun dmx/init-dash-functional()
  "Initialize dash-functional"
  (use-package dash-functional
	:defer t
	:init
	(progn
	  (message "Loading %s..." "dash-functional"))))
;(defun dmx/init-ycmd()
;  "Initialize ycmd"
;  (use-package ycmd
;               :defer t
;               :init
;               (progn
;                 (ycmd-mode))))
(defun dmx/init-toc-org()
  "Initialize toc-org"
  (use-package toc-org
	:defer t
	:init
	(progn
	  (message "Loading %s..." "toc-org"))))

(defun dmx/init-org-page()
  "Initialize org-page"
  (use-package org-page
	:defer t
	:init
	(progn
	  (require 'org-page)
	  (message "Loading %s..." "org-page"))))
(defun dmx/init-rainbow-mode()
  "Initialize rainbow-mode"
  (use-package rainbow-mode
	:defer t
	:init
	(progn
	  (message "Loading %s..." "rainbow-mode"))))
