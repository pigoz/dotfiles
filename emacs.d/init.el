(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package better-defaults :ensure t)

(use-package atom-dark-theme :ensure t)
(use-package fill-column-indicator :ensure t)

;; vim like stuff
(use-package evil :ensure t)
(use-package helm-projectile :ensure t)
(use-package powerline :ensure t)

;; ide stuff
(use-package neotree :ensure t)
(use-package auto-complete :ensure t)

;; language packages
(use-package rainbow-delimiters :ensure t)

(mapc 'load (directory-files "~/.emacs.d/elisp" t "^[0-9]+.*\.el$"))
