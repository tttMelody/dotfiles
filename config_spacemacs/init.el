;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '("~/.spacemacs.d/layers")
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
	 ;; ----------------------------------------------------------------
	 ;; Example of useful layers you may want to use right away.
	 ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
	 ;; <M-m f e R> (Emacs style) to install them.
	 ;; ----------------------------------------------------------------
	 auto-completion
	 better-defaults
	 git
	 markdown
	 org
	 ;; pandoc
	 javascript
	 ycmd
	 c-c++
	 swift
	 php
	 html
	 java
	 python
	 emacs-lisp
	 vimscript
	 shell-script
	 go
	 yaml
	 search-engine
	 tmux
	 games
	 dash
	 shell-scripts
	 ;;chinese
	 ;; (colors :variables
	 ;;         colors-enable-rainbow-identifiers t
	 ;;         colors-enable-nyan-cat-progress-bar t)

	 ;;osx
	 (shell :variables
			shell-default-height 30
			shell-default-position 'bottom)
	 ;; spell-checking
	 ;; syntax-checking
	 ;; version-control
	 dmx
	 dmx-lua
	 )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(evil-tutor bracketed-paste)
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages nil))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner '999
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(solarized-light
						 solarized-dark
						 spacemacs-light
						 spacemacs-dark
						 leuven
						 monokai
						 zenburn)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Menlo For Powerline"
							   :size 18
							   :weight normal
							   :width normal
							   :powerline-scale 1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to miminimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   dotspacemacs-elpa-https nil
   ))

(defun dmx-init-spacemacs-theme ()
  ;;== solarized theme setting ==
  ;; make the fringe stand out from the background
  ;; (setq solarized-distinct-fringe-background t)
  ;; Don't change the font for some headings and titles
  (setq solarized-use-variable-pitch nil)
  ;; Use more italics
  ;;(setq solarized-use-more-italic t)

  ;; Use less colors for indicators such as git:gutter, flycheck and similar
  ;;(setq solarized-emphasize-indicators nil)
  ;; Don't change size of org-mode headlines (but keep other size-changes)
  (setq solarized-scale-org-headlines nil)

  ;; Avoid all font-size changes
  (setq solarized-height-minus-1 1)
  (setq solarized-height-plus-1 1)
  (setq solarized-height-plus-2 1)
  (setq solarized-height-plus-3 1)
  (setq solarized-height-plus-4 1))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put any
user code."
  (setq spacemacs-theme-comment-bg nil)
  (setq spacemacs-theme-org-height nil)
  (dmx-init-spacemacs-theme)
  (setq org-bullets-bullet-list
	   '( "◉" "○" "✸" "✿" "◆" "♠" "♣" "♥" "●" "☢" "❀" "☯" "◇" "✚" "✜" "♦" "◆" "◖" "▶"))
  ;前12个是：子鼠、丑牛、寅虎、卯兔、辰龙、巳蛇、午马、未羊、申猴、酉鸡、戌狗、亥猪
  ;; (setq org-bullets-bullet-list
  ;;	'("🐢 " "🐀 " "🐂 " "🐅 " "🐇 " "🐉 " "🐍 " "🐎 " "🐐 " "🐒 " "🐓 " "🐕 " "🐖 " "🐠 " "🐘 " "🐙 " "🐜 " "🐝 " "🐟 " "🐪 " "🐬 " "🐳 "))
  ;;for dash layer
  (setq dash-helm-dash-docset-path "~/Library/Application Support/Dash/DocSets")
)

(defun dmx-c-mode-hook ()
  (c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
  (c-set-offset 'inline-open '+)
  (c-set-offset 'block-open '+)
  (c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
  (c-set-offset 'case-label '+)       ; in
  (setq-default c-basic-offset 4
				c-default-style "linux"
				tab-width 4
				tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)
				indent-tabs-mode t))
(defun dmx-hideshow-config()
  (spacemacs/set-leader-keys "mhha" 'hs-hide-all)
  (spacemacs/set-leader-keys "mhhb" 'hs-hide-block)
  (spacemacs/set-leader-keys "mhsa" 'hs-show-all)
  (spacemacs/set-leader-keys "mhsb" 'hs-show-block))

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
  This function is called at the very end of Spacemacs initialization after
  layers configuration. You are free to put any user code."

  (setq powerline-default-separator 'arrow)
  (spaceline-compile)
  (set-locale-environment "zh_CN.utf-8")

  ;; font for all unicode characters

  ;; 设置c-c++mode 缩进
  ;(setq-default tab-width 4
  ;              tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
  (setq-default c-basic-offset 4
				c-default-style "linux"
				tab-width 4
				tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)
				indent-tabs-mode t)

  ;; 设置按tab键输入\t
  ;(global-set-key (kbd "TAB") 'self-insert-command)
  (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
  (define-key evil-insert-state-map (kbd "TAB") 'self-insert-command)
  (c-set-offset 'substatement-open '0)
  (add-hook 'c++-mode-hook 'dmx-c-mode-hook)
  (add-hook 'c-mode-hook 'dmx-c-mode-hook)
  ;; 禁用鼠标
  (xterm-mouse-mode -1)
  (dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]
			   [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
			   [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
			   [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
			   [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
	  (global-unset-key k))
  (spacemacs/set-leader-keys "mwc" 'whitespace-cleanup)

  (spacemacs/set-leader-keys "aaw" 'avy-goto-word-or-subword-1)
  (spacemacs/set-leader-keys "aac" 'avy-goto-char-in-line)
  (spacemacs/set-leader-keys "mhha" 'hs-hide-all)

  (add-hook 'org-mode-hook 'toc-org-enable)
  (add-hook 'lua-mode-hook 'dmx-hideshow-config)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ob-lua chinese-fonts-setup yapfify yaml-mode xterm-color ws-butler window-numbering which-key web-mode web-beautify volatile-highlights vimrc-mode vi-tilde-fringe uuidgen use-package typit mmt toc-org tagedit swift-mode spacemacs-theme spaceline powerline smeargle smart-tab slime slim-mode shell-pop scss-mode sass-mode restart-emacs rainbow-mode rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements phpunit phpcbf php-extras php-auto-yasnippets persp-mode pcre2el paradox spinner pacmacs orgit org-projectile org-present org-pomodoro alert log4e gntp org-plus-contrib org-page git mustache ht org-download org-bullets open-junk-file neotree mwim multi-term move-text mmm-mode markdown-toc markdown-mode magit-gitflow macrostep lua-mode lorem-ipsum livid-mode skewer-mode simple-httpd live-py-mode linum-relative link-hint less-css-mode json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc info+ indent-guide ido-vertical-mode hydra hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-gitignore helm-flx helm-descbinds helm-dash helm-css-scss helm-company helm-c-yasnippet helm-ag haml-mode google-translate golden-ratio go-eldoc gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md flx-ido flx fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit magit magit-popup git-commit with-editor evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight eshell-z eshell-prompt-extras esh-help engine-mode emmet-mode elisp-slime-nav dumb-jump drupal-mode php-mode disaster diminish define-word dash-at-point dactyl-mode cython-mode company-ycmd ycmd request-deferred request deferred company-web web-completion-data company-tern dash-functional tern company-statistics company-shell company-go go-mode company-emacs-eclim eclim company-c-headers company-anaconda company column-enforce-mode coffee-mode cmake-mode clean-aindent-mode clang-format cal-china-x bind-map bind-key auto-yasnippet yasnippet auto-highlight-symbol auto-compile packed applescript-mode anaconda-mode pythonic f s aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core async ac-ispell auto-complete popup 2048-game quelpa package-build solarized-theme)))
 '(solarized-use-variable-pitch nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
