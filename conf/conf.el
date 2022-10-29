;; [[file:conf.org::*speed init][speed init:1]]
(setq gc-cons-threshold 100000000)
;; speed init:1 ends here

;; [[file:conf.org::*use-package][use-package:1]]
(eval-when-compile
  (require 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; if you use any :bind variant
(use-package bind-key
  :ensure t
  :config
  (require 'bind-key))
;; use-package:1 ends here

;; [[file:conf.org::*benchmark-init][benchmark-init:1]]
;; (use-package benchmark-init
;;   :ensure t
;;   :init
;;   (benchmark-init/activate)
;;   :config
;;   ;; To disable collection of benchmark data after init is done.
;;   (add-hook 'after-init-hook 'benchmark-init/deactivate))
;; benchmark-init:1 ends here

;; [[file:conf.org::*diminish][diminish:1]]
;; (use-package diminish
;;   :ensure t
;;   )
;; diminish:1 ends here

;; [[file:conf.org::*backup][backup:1]]
;; https://www.emacswiki.org/emacs/BackupDirectory
(setq backup-directory-alist
      `((".*" . "~/.emacs.d/backup/")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/backup/" t)))
;; backup:1 ends here

;; [[file:conf.org::*replace tab with space][replace tab with space:1]]
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
;; replace tab with space:1 ends here

;; [[file:conf.org::*utf-8 encoding][utf-8 encoding:1]]
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;; utf-8 encoding:1 ends here

;; [[file:conf.org::*display time][display time:1]]
;; (setq display-time-24hr-format t)
;; (setq display-time-format "%H:%M")
;; (display-time-mode 1)
;; display time:1 ends here

;; [[file:conf.org::*yes-or-no][yes-or-no:1]]
(fset 'yes-or-no-p 'y-or-n-p) ; yes/no -> y/n
;; yes-or-no:1 ends here

;; [[file:conf.org::*font][font:1]]
(set-frame-font "JetBrains Mono 18" nil t)
;; (set-frame-font "Ubuntu Mono 18" nil t)
;; font:1 ends here

;; [[file:conf.org::*global ui][global ui:1]]
(setq inhibit-startup-screen t) ; hide the welcome screen
(setq initial-major-mode 'fundamental-mode) ; change *scratch* major mode
(setq initial-scratch-message "\
# This buffer is for notes you don't want to save") ; change message in *scratch*
(menu-bar-mode -1) ; show/hide menu bar
(tool-bar-mode -1) ; show/hide tool bar
(scroll-bar-mode -1) ; show/hide scroll bar
(global-linum-mode -1) ; show/hide line number
;; (visual-line-mode 1) ; word wrap
(global-hl-line-mode 1) ; highlight current line
(setq column-number-mode t)
;; global ui:1 ends here

;; [[file:conf.org::*transparency][transparency:1]]
;; (set-frame-parameter (selected-frame) 'alpha '(85 100))
;; (add-to-list 'default-frame-alist '(alpha 85 100))
;; transparency:1 ends here

;; [[file:conf.org::*smart-line][smart-line:1]]
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
;; optional key binding
(global-set-key (kbd "C-c C-k")'copy-line)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))
(global-set-key (kbd "C-c M-k") 'duplicate-line)

;; (defun smart-open-line ()
;;   "Insert an empty line after the current line. Position the cursor at its beginning, according to the current mode."
;;   (interactive)
;;   (move-end-of-line nil)
;;   (newline-and-indent))
;; (defun smart-open-line-above ()
;;   "Insert an empty line above the current line. Position the cursor at it's beginning, according to the current mode."
;;   (interactive)
;;   (move-beginning-of-line nil)
;;   (newline-and-indent)
;;   (forward-line -1)
;;   (indent-according-to-mode))
;; (global-set-key (kbd "s-<return>") 'smart-open-line)
;; (global-set-key (kbd "s-S-<return>") 'smart-open-line-above)

;; (defun move-below-line-up ()
;;   "Join the current line with the next line."
;;   (interactive)
;;   (delete-indentation 1))
;; (global-set-key (kbd "s-j") 'move-below-line-up)

;; (global-set-key (kbd "C-M-l") 'goto-line)
;; smart-line:1 ends here

;; [[file:conf.org::*browse-at-remote][browse-at-remote:1]]
(use-package browse-at-remote
  :ensure t
  :bind (("C-c r" . 'browse-at-remote)))
;; browse-at-remote:1 ends here

;; [[file:conf.org::*comment code][comment code:1]]
(defun comment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(global-set-key (kbd "s-/") 'comment-region-or-line)
;; comment code:1 ends here

;; [[file:conf.org::*beacon][beacon:1]]
;; https://github.com/Malabarba/beacon
(use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  (setq beacon-blink-duration 0.5)
  ;; (setq beacon-color "green")
  )
;; beacon:1 ends here

;; [[file:conf.org::*theme][theme:1]]
;; (use-package doom-themes
;;   :ensure t
;;   :config

;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-one t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)

;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))


;; M-x color-theme-sanityinc-tomorrow-day
;; M-x color-theme-sanityinc-tomorrow-night
;; M-x color-theme-sanityinc-tomorrow-blue
;; M-x color-theme-sanityinc-tomorrow-bright
;; M-x color-theme-sanityinc-tomorrow-eighties
;; (use-package color-theme-sanityinc-tomorrow
;;   :ensure t
;;   :config
;;   (require 'color-theme-sanityinc-tomorrow))

;; (use-package dracula-theme
;;   :ensure t
;;   :config
;;   (load-theme 'dracula t))

;; (use-package zenburn-theme
;;   :ensure t
;;   :config
;;   (load-theme 'zenburn t))

;; (use-package solarized-theme
;;   :ensure t
;;   :config
;;   ;; (load-theme 'solarized-light t)
;;   (load-theme 'solarized-dark t)
;;   )

;; (use-package spacemacs-theme
;;   :defer t
;;   :init (load-theme 'spacemacs-dark t))

(use-package nord-theme
  :ensure t
  :config
  ;; (add-to-list 'custom-theme-load-path
  ;;              (expand-file-name "~/.emacs.d/themes/"))
  (load-theme 'nord t))
;; theme:1 ends here

;; [[file:conf.org::*mode line][mode line:1]]
;; (use-package powerline
;;   :ensure t
;;   :config
;;   (powerline-default-theme)
;;   ;; (powerline-center-theme)
;;   ;; (powerline-center-evil-theme)
;;   ;; (powerline-vim-theme)
;;   ;; (powerline-nano-theme)
;;   )
;; mode line:1 ends here

;; [[file:conf.org::*mode line][mode line:2]]
(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme))
;; mode line:2 ends here

;; [[file:conf.org::*mode line][mode line:3]]
;; (use-package all-the-icons
;;   :ensure t)

;; (use-package doom-modeline
;;   :ensure t
;;   :hook (after-init . doom-modeline-mode))
;; mode line:3 ends here

;; [[file:conf.org::*exec-path-from-shell][exec-path-from-shell:1]]
(use-package exec-path-from-shell
  :ensure t
  :defer 5
  :config

  ;; (setq exec-path-from-shell-arguments nil)

  (when (memq window-system '(mac ns x))
    (dolist (var '("https_proxy" "http_proxy" "all_proxy" "GOPATH"))
      (add-to-list 'exec-path-from-shell-variables var))

    (exec-path-from-shell-initialize)))
;; exec-path-from-shell:1 ends here

;; [[file:conf.org::*yasnippet][yasnippet:1]]
(use-package yasnippet
  :ensure t
  :defer 5
  :config
  (yas-reload-all)
  (setq yas-wrap-around-region t)
  :hook (('prog-mode     . 'yas-minor-mode)
         ('org-mode      . 'yas-minor-mode)
         ('LaTeX-mode    . 'yas-minor-mode)
         ('markdown-mode . 'yas-minor-mode)))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)
;; yasnippet:1 ends here

;; [[file:conf.org::*recentf][recentf:1]]
(use-package recentf
  :ensure t
  :config
  (recentf-mode 1)
  (setq recentf-max-saved-items 200
        recentf-max-menu-items 15)
  (run-at-time nil (* 5 60) 'recentf-save-list))
;; recentf:1 ends here

;; [[file:conf.org::*projectile][projectile:1]]
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (setq projectile-completion-system 'ivy)
  (setq projectile-dynamic-mode-line nil)
  :bind-keymap
  ("s-p" . projectile-command-map)
  ;; ("C-c p" . projectile-command-map)
  )

;; (use-package helm-projectile
;;   :ensure t
;;   :config
;;   (projectile-global-mode 1)
;;   (helm-projectile-on)
;;   ;; (setq projectile-completion-system 'helm)
;;   (setq projectile-switch-project-action 'helm-projectile)
;;   )
;; projectile:1 ends here

;; [[file:conf.org::*ivy][ivy:1]]
(use-package counsel
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-wrap t)
  :bind
  (("C-s"     . 'swiper-isearch)
   ("M-x"     . 'counsel-M-x)
   ("M-y"     . 'counsel-yank-pop)
   ("C-x C-f" . 'counsel-find-file)
   ("C-x b"   . 'ivy-switch-buffer)

   ;; ("M-n" . ivy-next-history-element)
   ;; ("M-p" . ivy-previous-history-element)
   ;; ("M-i" . ivy-insert-current)
   ("M-j" . 'ivy-yank-word) ;; C-s M-j this will search symbol at point

   ;; ("C-c C-r" . 'ivy-resume)
   ;; ("C-c v"   . 'ivy-push-view)
   ;; ("C-c V"   . 'ivy-pop-view)
   ("C-c k"   . 'counsel-rg)
   ;; ("C-c l"   . 'counsel-locate)
   ;; ("C-c g"   . 'counsel-git)
   ;; ("C-c j"   . 'counsel-git-grep)
   ;; ("C-S-o"   . 'counsel-rhythmbox)
   ("C-*"     . 'swiper-thing-at-point)
   ))


(use-package counsel-tramp
  :ensure t
  :after counsel)
;; ivy:1 ends here

;; [[file:conf.org::*multiple cursor][multiple cursor:1]]
(use-package multiple-cursors
  :ensure t
  :defer 5
  :bind
  (("C-x C-v" . 'mc/edit-lines)
   ("C->" . 'mc/mark-next-like-this)
   ("C-<" . 'mc/mark-previous-like-this)
   ("C-x C-a" . 'mc/mark-all-like-this)))
;; multiple cursor:1 ends here

;; [[file:conf.org::*cherry pick][cherry pick:1]]
(use-package magit
  :ensure t
  :bind (("C-x g"   . 'magit-status)
         ("C-c g"   . 'magit-dispatch-popup)
         ("C-c M-g" . 'magit-file-dispatch)))

;; (use-package forge
;;   :ensure t
;;   :after magit)
;; cherry pick:1 ends here

;; [[file:conf.org::*ace window][ace window:1]]
(use-package ace-window
  :ensure t
  :bind (("M-o" . 'ace-window)))
;; ace window:1 ends here

;; [[file:conf.org::*which key][which key:1]]
(use-package which-key
  :ensure t
  :config
  (which-key-mode))
;; which key:1 ends here

;; [[file:conf.org::*neotree][neotree:1]]
;; (use-package neotree
;;   :ensure t
;;   :bind
;;   (("s-t" . 'neotree-toggle))
;;   :config
;;   (setq neo-smart-open t)
;;   (setq neo-theme 'arrow))
;; neotree:1 ends here

;; [[file:conf.org::*paredit][paredit:1]]
(use-package paredit
  :ensure t
  :hook
  (('cider-repl-mode          . 'enable-paredit-mode)
   ('cider-mode               . 'enable-paredit-mode)
   ('clojure-mode             . 'enable-paredit-mode)
   ('emacs-lisp-mode          . 'enable-paredit-mode)
   ('ielm-mode                . 'enable-paredit-mode)
   ('lisp-mode                . 'enable-paredit-mode)
   ('lisp-interaction-mode    . 'enable-paredit-mode)
   ('scheme-mode              . 'enable-paredit-mode)
   ('haskell-interactive-mode . 'enable-paredit-mode)))

(global-set-key (kbd "C-s-<right>") 'paredit-forward-slurp-sexp)
(global-set-key (kbd "C-s-<left>") 'paredit-forward-barf-sexp)
;; paredit:1 ends here

;; [[file:conf.org::*smartparens][smartparens:1]]
(use-package smartparens
  :ensure t
  :hook
  (('prog-mode                . 'smartparens-mode)
   ('LaTeX-mode               . 'smartparens-mode)
   ('eshell-mode              . 'smartparens-mode)
   ('cider-mode               . 'smartparens-mode)
   ('cider-repl-mode          . 'smartparens-mode))

  :bind
  (("C-M-a"     . 'sp-beginning-of-sexp)
   ("C-M-e"     . 'sp-end-of-sexp)
   ("C-M-f"     . 'sp-forward-sexp)
   ("C-M-b"     . 'sp-backward-sexp)
   ("C-M-n"     . 'sp-next-sexp)
   ("C-M-p"     . 'sp-previous-sexp)
   ("C-S-f"     . 'sp-forward-symbol)
   ("C-S-b"     . 'sp-backward-symbol)
   ("C-M-k"     . 'sp-kill-sexp)
   ("C-M-w"     . 'sp-copy-sexp)
   ("C-k"       . 'sp-kill-hybrid-sexp)
   ("M-k"       . 'sp-backward-kill-sexp)))
;; smartparens:1 ends here

;; [[file:conf.org::*rainbow][rainbow:1]]
(use-package rainbow-delimiters
  :ensure t
  :hook ('prog-mode . 'rainbow-delimiters-mode))
;; rainbow:1 ends here

;; [[file:conf.org::*eglot][eglot:1]]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; for Go
  ;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md#configuring-eglot
(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(defun eglot-format-buffer-on-save ()
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package eglot
  :ensure t
  :config
  ;; for Go
  (add-hook 'project-find-functions #'project-find-go-module)
  (add-hook 'go-mode-hook #'eglot-format-buffer-on-save)

  :bind
  (("C-c e l" . 'eglot)
   ("C-c C-r" . 'eglot-rename)
   ("C-c C-'" . 'eglot-code-actions)

   ("C-c f p" . 'flymake-goto-prev-error)
   ("C-c f n" . 'flymake-goto-next-error)
   ("C-c f b" . 'flymake-show-buffer-diagnostics)
   ("C-c f s" . 'flymake-show-project-diagnostics)))
;; eglot:1 ends here

;; [[file:conf.org::*clojure and cider][clojure and cider:1]]
(use-package clojure-mode
  :ensure t
  :defer 5
  :hook (('clojure-mode . 'eldoc-mode))
  :config
  (setq align-arguments t)
  ;; compojure indentation
  ;; (define-clojure-indent
  ;;   (defroutes 'defun)
  ;;   (GET 2)
  ;;   (POST 2)
  ;;   (PUT 2)
  ;;   (DELETE 2)
  ;;   (HEAD 2)
  ;;   (ANY 2)
  ;;   (OPTIONS 2)
  ;;   (PATCH 2)
  ;;   (rfn 2)
  ;;   (let-routes 1)
  ;;   (context 2))
  )

(use-package cider
  :ensure t
  :after clojure-mode
  :config
  ;; go right to the REPL buffer when it's finished connecting
  (setq cider-repl-pop-to-buffer-on-connect t)

  ;; When there's a cider error, show its buffer and switch to it
  (setq cider-show-error-buffer t)
  (setq cider-auto-select-error-buffer t)
  (setq cider-test-show-report-on-success t)

  ;; Where to store the cider history.
  (setq cider-repl-history-file "~/.emacs.d/cider-history")

  ;; Wrap when navigating history.
  (setq cider-repl-wrap-history t)

  ;; turn off eldoc displayed when the cursor is over code
  (setq cider-prompt-for-symbol nil)

  ;; Just save without prompting, C-c C-k
  (setq cider-save-file-on-load t)

  ;; evaluate code in Clojure files, display result overlay to be font-locked
  (setq cider-overlays-use-font-lock t)

  (setq cider-refresh-show-log-buffer t)

  (setq cider-repl-tab-command #'indent-for-tab-command)

  (setq cider-eldoc-display-for-symbol-at-point nil)
  (setq cider-repl-display-help-banner nil))
;; clojure and cider:1 ends here

;; [[file:conf.org::*python][python:1]]

;; python:1 ends here

;; [[file:conf.org::*go][go:1]]
(use-package go-mode
  :ensure t
  :defer 5
  :bind
  (("C-c C-c C-t" . 'go-test-current-test)
   ("C-c C-c C-f" . 'go-test-current-file)))
;; go:1 ends here

;; [[file:conf.org::*rust][rust:1]]
(use-package rust-mode
  :ensure t
  :defer 5
  :config
  (setq rust-format-on-save t))
;; rust:1 ends here

;; [[file:conf.org::*elixir][elixir:1]]

;; elixir:1 ends here

;; [[file:conf.org::*company][company:1]]
(use-package company
  :ensure t
  :hook ('prog-mode . 'global-company-mode)
  :config
  (company-tng-configure-default)
  (setq company-idle-delay 0.5)
  (setq company-minimum-prefix-length 3)
  (setq company-selection-wrap-around t)
  (setq company-tooltip-align-annotations t))
;; company:1 ends here

;; [[file:conf.org::*expand region][expand region:1]]
;; C-- C-= : contract the region
(use-package expand-region
  :ensure t
  :defer 5
  :bind
  ("C-=" . 'er/expand-region))
;; expand region:1 ends here

;; [[file:conf.org::*rest client][rest client:1]]
;; (use-package restclient
;;   :ensure t
;;   :defer 5
;;   :mode ("\\.http\\'" . 'restclient-mode))

;; (use-package ob-restclient
;;   :ensure t
;;   :defer 5
;;   :after restclient)
;; rest client:1 ends here

;; [[file:conf.org::*narrow][narrow:1]]
(defun my/org-narrow-forward ()
  "Move to the next subtree at same level, and narrow to it."
  (interactive)
  (widen)
  (org-forward-heading-same-level 1)
  (org-narrow-to-subtree))

(defun my/org-narrow-backward ()
  "Move to the next subtree at same level, and narrow to it."
  (interactive)
  (widen)
  (org-backward-heading-same-level 1)
  (org-narrow-to-subtree))
;; narrow:1 ends here

;; [[file:conf.org::*config][config:1]]
(use-package org
  :ensure t
  :defer 5

  ;; :bind
  ;; (("C-c l"   . 'org-store-link)
  ;;  ("C-c a"   . 'org-agenda)
  ;;  ("C-c b"   . 'org-switchb)
  ;;  ("C-c c"   . 'org-capture)
  ;;  ("C-x n f" . 'my/org-narrow-forward)
  ;;  ("C-x n b" . 'my/org-narrow-backward)
  ;;  ("C-c M-." . 'org-open-at-point)
  ;;  ("C-c M-," . 'org-mark-ring-goto))

  :config
  ;; (org-babel-do-load-languages
  ;;  'org-babel-load-languages
  ;;  '((restclient . t)
  ;;    (clojure    . t)
  ;;    (python     . t)
  ;;    (latex      . t)
  ;;    (shell      . t)))

  (setq org-startup-truncated nil)
  ;; (setq org-link-frame-setup '((file . find-file)))
  (add-to-list 'org-structure-template-alist
               '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))
  (setq org-html-checkbox-type 'html)
  (setq org-log-done 'time)
  (setq org-hide-emphasis-markers t)
  (setq org-image-actual-width nil)
  (setq org-default-notes-file "~/.emacs.d/notes.org")
  (setq org-todo-keywords
        '((sequence "TODO" "DOING" "|" "DONE" "CANCEL"))))

;; (use-package org-bullets
;;   :ensure t
;;   :defer 5
;;   :hook ('org-mode . 'org-bullets-mode)
;;   ;; :config
;;   ;; (setq org-bullets-bullet-list '("⓪" "①" "②" "③" "④" "⑤" "⑥" "⑦" "⑧" "⑨"))
;;   :after org)

;; (use-package htmlize
;;   :ensure t
;;   :defer 5
;;   :after org)

;; (use-package toc-org
;;   :ensure t
;;   :defer 5
;;   :after org
;;   :hook ('org-mode . 'toc-org-mode))

;; (use-package ox-gfm
;;   :ensure t
;;   :defer 5
;;   :after org)

;; ;; https://github.com/yjwen/org-reveal
;; ;;
;; ;; Available themes can be found in “css/theme/” in the reveal.js directory. black|league|night|simple|solarized|beige|blood|moon|serif|sky|white
;; ;; Available transitions are: default|cube|page|concave|zoom|linear|fade|none.
;; (use-package ox-reveal
;;   :ensure t
;;   :defer 5
;;   :after org
;;   :config
;;   (setq org-reveal-mathjax t)
;;   (setq org-reveal-root "https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.8.0/")
;;   ;; (setq org-reveal-root "/home/yuanbo/workspace/github.com/reveal.js")
;;   )
;; config:1 ends here

;; [[file:conf.org::*abbrev][abbrev:1]]
(setq-default abbrev-mode t)
(setq abbrev-file-name "~/.emacs.d/abbrev_defs")
(setq save-abbrevs 'silent)
;; abbrev:1 ends here

;; [[file:conf.org::*undo tree][undo tree:1]]
;; https://elpa.gnu.org/packages/undo-tree.html
;; C-x u
;; C-_  (`undo-tree-undo') Undo changes.
;; M-_  (`undo-tree-redo') Redo changes.
;; (use-package undo-tree
;;   :ensure t
;;   :init
;;   (global-undo-tree-mode))
;; undo tree:1 ends here

;; [[file:conf.org::*misc packages][misc packages:1]]
(use-package yaml-mode
  :ensure t
  :defer 5)

(use-package toml-mode
  :ensure t
  :defer 5)

(use-package markdown-mode
  :ensure t
  :defer 5)

(use-package json-mode
  :ensure t
  :defer 5)
;; misc packages:1 ends here

;; [[file:conf.org::*avy][avy:1]]
(use-package avy
  :ensure t
  :bind
  (
   ;; ("s-c" . 'avy-goto-char-2)
   ("s-c" . 'avy-goto-word-1)
   ))
;; avy:1 ends here

;; [[file:conf.org::*Highlights matching parenthesis][Highlights matching parenthesis:1]]
;; https://github.com/tarsius/paren-face
(use-package paren-face
  :ensure t
  :config
  (setq show-paren-delay 0)
  (show-paren-mode 1)
  (set-face-background 'show-paren-match (face-background 'default))
  (set-face-foreground 'show-paren-match "red")
  ;; (set-face-attribute 'show-paren-match nil :strike-through t :weight 'extra-bold)
  )
;; Highlights matching parenthesis:1 ends here

;; [[file:conf.org::*whitespace cleanup][whitespace cleanup:1]]
;;;; trailing whitespace
;; https://stackoverflow.com/questions/34531831/highlighting-trailing-whitespace-in-emacs-without-changing-character
;; (setq-default show-trailing-whitespace t)

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Useless-Whitespace.html
;; (global-whitespace-mode)

(use-package whitespace-cleanup-mode
  :ensure t
  :bind (("C-c C-SPC". 'whitespace-cleanup))
  :hook
  (('prog-mode . 'whitespace-cleanup-mode)
   ('before-save . 'whitespace-cleanup)))
;; whitespace cleanup:1 ends here

;; [[file:conf.org::*config][config:1]]
;; (use-package tablist
;;   :ensure t
;;   :defer 5)

;; (use-package pdf-tools
;;   :ensure t
;;   :defer 5
;;   :config
;;   (pdf-loader-install))
;; config:1 ends here

;; [[file:conf.org::*google this][google this:1]]
(use-package google-this
  :ensure t
  :defer 5)

(global-set-key (kbd "C-x /") 'google-this-mode-submap)
;; google this:1 ends here

;; [[file:conf.org::*fci fill-column-indicator][fci fill-column-indicator:1]]
(use-package fill-column-indicator
  :ensure t
  ;; :hook
  ;; (('prog-mode . 'fci-mode))
  :config
  ;; (require 'fill-column-indicator)
  (setq fci-rule-column 80))

(global-set-key (kbd "C-c q") 'auto-fill-mode)
;; fci fill-column-indicator:1 ends here

;; [[file:conf.org::*ispell][ispell:1]]
;; (setq ispell-personal-dictionary "~/.emacs.d/ispell_dicts")
;; (global-set-key (kbd "M-$")   'ispell-word)
;; (global-set-key (kbd "C-M-i") 'ispell-complete-word)
;; ispell:1 ends here

;; [[file:conf.org::*unconditional replace][unconditional replace:1]]
(global-set-key (kbd "C-r") 'replace-string)
;; unconditional replace:1 ends here

;; [[file:conf.org::*buffer move][buffer move:1]]
(use-package buffer-move
  :ensure t
  :defer 5)

(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)
;; buffer move:1 ends here

;; [[file:conf.org::*command log][command log:1]]
;; (use-package command-log-mode
;;   :ensure t)
;; command log:1 ends here

;; [[file:conf.org::*window enlarge][window enlarge:1]]
;; C-x + (balance-windows) to make windows the same heights and widths.

;; enlarge window vertically
;; (global-set-key (kbd "C-c ^") (kbd "C-u - 20 C-x ^"))
;; (global-set-key (kbd "C-c C-6") )

;; enlarge window horizontally
;; (global-set-key (kbd "C-c }") (kbd "C-u - 20 C-x }"))
;; (global-set-key (kbd "C-c {") (kbd "C-u - 20 C-x {"))


(global-set-key (kbd "S-C-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")  'shrink-window)
(global-set-key (kbd "S-C-<up>")    'enlarge-window)
;; window enlarge:1 ends here

;; [[file:conf.org::*Occur and highlight][Occur and highlight:1]]
(global-set-key (kbd "C-c o") 'occur)
;; Occur and highlight:1 ends here

;; [[file:conf.org::*dashboard][dashboard:1]]
;; (use-package dashboard
;;   :ensure t
;;   :config
;;   (dashboard-setup-startup-hook)

;;   (setq dashboard-startup-banner 'official)
;;   (setq dashboard-banner-logo-title "Welcome to Emacs")
;;   (setq dashboard-center-content t)
;;   (setq dashboard-show-shortcuts nil)
;;   (setq dashboard-set-init-info t)

;;   (setq dashboard-items '((recents  . 5)
;;                           (projects . 5))))
;; dashboard:1 ends here

;; [[file:conf.org::*browse url][browse url:1]]
(global-set-key (kbd "C-c b") 'browse-url)
;; browse url:1 ends here

;; [[file:conf.org::*+emacs =http:/example.org/feed/][+emacs =http://example.org/feed/:1]]
(use-package elfeed
  :ensure t
  :defer 5
  :bind (("C-x w" . 'elfeed))
  :config
  ;; (setq-default elfeed-search-filter "@1-week-ago +unread ")

  (setq elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory)
        elfeed-show-entry-switch 'display-buffer)

  (setq elfeed-feeds
        '("https://tdodge.consulting/blog/rss.xml")))
;; +emacs =http://example.org/feed/:1 ends here

;; [[file:conf.org::*tab bar][tab bar:1]]
;; (use-package tabbar
;;     :ensure t
;;     :defer 5
;;     :config
;;     (setq tab-bar-show t)
;;     (setq tab-bar-tab-hints t))
;; tab bar:1 ends here

;; [[file:conf.org::*treemacs][treemacs:1]]
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    ;; (treemacs-follow-mode t)
    ;; (treemacs-filewatch-mode t)
    ;; (treemacs-fringe-indicator-mode 'always)
    ;; (when treemacs-python-executable
    ;; (treemacs-git-commit-diff-mode t))

    ;; (pcase (cons (not (null (executable-find "git")))
    ;;              (not (null treemacs-python-executable)))
    ;;   (`(t . t)
    ;;    (treemacs-git-mode 'deferred))
    ;;   (`(t . _)
    ;;    (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("s-t"       . treemacs)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

;; (use-package treemacs-evil
;;   :after (treemacs evil)
;;   :ensure t)

;; (use-package treemacs-projectile
;;   :after (treemacs projectile)
;;   :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

;; (use-package treemacs-magit
;;   :after (treemacs magit)
;;   :ensure t)

;; (use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
;;   :after (treemacs persp-mode) ;;or perspective vs. persp-mode
;;   :ensure t
;;   :config (treemacs-set-scope-type 'Perspectives))

;; (use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
;;   :after (treemacs)
;;   :ensure t
;;   :config (treemacs-set-scope-type 'Tabs))
;; treemacs:1 ends here

;; [[file:conf.org::*libvterm][libvterm:1]]
(use-package vterm
  :ensure t
  :defer 5
  :config
  ;; (setq vterm-kill-buffer-on-exit t)
  (setq vterm-copy-exclude-prompt nil))
(global-set-key (kbd "C-c C-t") 'vterm-other-window)
;; libvterm:1 ends here
