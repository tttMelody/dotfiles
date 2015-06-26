;;== emacs-eim ==
(add-to-list 'load-path "~/.emacs.d/self_install/eim")
(add-to-list 'load-path "~/.emacs.d/el-get/emacs-eim")
(autoload 'eim-use-package "eim" "Another emacs input method")
;; (setq eim-use-tooltip nil)
(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "拼音" "汉字拼音输入法" "py.txt")
(require 'eim-extra)
(global-set-key ";" 'eim-insert-ascii)
(set-input-method 'eim-py)

(provide 'custom-init-emacs-eim)
