;; Chinese calendar
(require 'cal-china-x)
(setq mark-holidays-in-calendar t)
(setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
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

(provide 'custom-init-cal-china-x)
