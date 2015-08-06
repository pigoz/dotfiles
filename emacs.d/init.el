(require 'cask "/usr/local/share/emacs/site-lisp/cask.el")
(cask-initialize)
(require 'pallet)

; theme!
(load-theme 'atom-dark t)

(mapc 'load (directory-files "~/.emacs.d/elisp" t "^[0-9]+.*\.el$"))

(require 'better-defaults)

; set the font i like!
(set-default-font "Inconsolata-22")

(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  (global-set-key (kbd "M-q") 'save-buffers-kill-emacs)
)

; give the OS a good text editor
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)

; fuzzy file finder
(require 'helm-config)
(require 'helm-ls-git)
(global-set-key (kbd "C-<f6>") 'helm-ls-git-ls)
(setq helm-ls-git-show-abs-or-relative 'relative)
(setq helm-ls-git-fuzzy-match t)
(global-set-key (kbd "M-t") 'helm-browse-project)

; powerline
(require 'powerline)
(powerline-default-theme)

; disable backups
(setq backup-inhibited t)
; disable autosave
(setq auto-save-default nil)
