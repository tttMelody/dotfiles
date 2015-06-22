(require 'slime-autoloads)
(setq slime-contribs '(slime-fancy))
(setq slime-lisp-implementations
     `((sbcl ("/opt/local/bin/sbcl"))
       (abcl ("/opt/local/bin/abcl"))
       (clisp ("/opt/local/bin/clisp"))))
(setq inferior-lisp-program "/opt/local/bin/sbcl")
(slime-setup  '(slime-repl slime-asdf slime-fancy slime-banner))

(provide 'dmx-init-slime)
