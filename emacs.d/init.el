(require 'cask "/usr/local/share/emacs/site-lisp/cask.el")
(cask-initialize)
(require 'pallet)

(mapc 'load (directory-files "~/.emacs.d/elisp" t "^[0-9]+.*\.el$"))
