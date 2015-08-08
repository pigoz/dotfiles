; give the emacs os a good text editor
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)

; use projectile to find files
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-use-native-indexing t)
(setq projectile-enable-caching t)
(helm-projectile-on)
(global-set-key (kbd "M-t") 'helm-projectile)
(global-set-key (kbd "M-p") 'helm-projectile-switch-project)

; powerline
(require 'powerline)
(powerline-default-theme)

; neotree
(require 'neotree)
(global-set-key (kbd "M-d") 'neotree-toggle)
(add-hook 'neotree-mode-hook
   (lambda ()
     (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

; use rainbow delimiter in lisps
(require 'rainbow-delimiters)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)

(require 'cl-lib)
(require 'color)

(cl-loop
 for index from 1 to rainbow-delimiters-max-face-count
 do
 (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
   (cl-callf color-saturate-name (face-foreground face) 100)))
