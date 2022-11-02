;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/conf/conf.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(sanityinc-tomorrow-night))
 '(custom-safe-themes
    '("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default))
 '(package-selected-packages
    '(color-theme-sanityinc-tomorrow embark-consult embark marginalia nord-theme doom-modeline all-the-icons solarized-theme vterm xterm-color markdown-mode eglot elfeed docker-tramp counsel-tramp doom-themes treemacs treemacs-icons-dired projectile-ripgrep ripgrep go-playground browse-at-remote docker carbon-now-sh go-mode command-log-mode buffer-move fill-column-indicator google-this pdf-tools tablist whitespace-cleanup-mode paren-face ansible docker-compose-mode dockerfile-mode json-mode toml-mode yaml-mode ox-reveal ox-gfm toc-org htmlize org-bullets ob-restclient restclient expand-region company exunit elixir-mode rust-playground rust-mode cider clojure-mode flycheck rainbow-delimiters smartparens paredit neotree which-key ace-window magit multiple-cursors counsel projectile yasnippet-snippets yasnippet exec-path-from-shell spaceline dracula-theme beacon use-package diminish)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
