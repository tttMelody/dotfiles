
(setq dmx-lua-packages
  '(
    company
    flycheck
    lua-mode
    ))

(defun dmx-lua/post-init-flycheck ()
  (spacemacs/add-flycheck-hook 'lua-mode-hook))

(defun dmx-lua/init-lua-mode ()
  (use-package lua-mode
    :defer t
	:mode ("\\.lua\\'" . lua-mode)
	:interpreter ("lua" . lua-mode)
    :init
    (progn
	  (message "Loading %s..." "lua-mode")
      (setq lua-indent-level 4
            lua-indent-string-contents t)
      (spacemacs/set-leader-keys-for-major-mode 'lua-mode "d" 'lua-search-documentation)
      (spacemacs/set-leader-keys-for-major-mode 'lua-mode "sb" 'lua-send-buffer)
      (spacemacs/set-leader-keys-for-major-mode 'lua-mode "sf" 'lua-send-defun)
      (spacemacs/set-leader-keys-for-major-mode 'lua-mode "sl" 'lua-send-current-line)
      (spacemacs/set-leader-keys-for-major-mode 'lua-mode "sr" 'lua-send-region))))

(defun dmx-lua/post-init-company ()
  (add-hook 'lua-mode-hook 'company-mode))
