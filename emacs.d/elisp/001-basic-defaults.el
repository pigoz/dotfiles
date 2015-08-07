; theme!
(load-theme 'atom-dark t)

(require 'better-defaults)

; 80 characters mark
(require 'fill-column-indicator)
(set-fill-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "darkblue")
(add-hook 'after-change-major-mode-hook 'fci-mode)

; we got git: disable backups and autosave
(setq make-backup-files nil)
(setq auto-save-default nil)

; set my programming font
; todo: make it smaller on macbook air
(set-default-font "Inconsolata-22")

(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  (global-set-key (kbd "M-q") 'save-buffers-kill-emacs)
)
