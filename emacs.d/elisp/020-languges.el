(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

; ruby - rails stuff
(require 'haml-mode)

(require 'js2-mode)
(require 'ac-js2)
; add flycheck haml error reporting through haml-lint 
(flycheck-def-config-file-var flycheck-haml-lintrc haml-lint ".haml-lint.yml"
  :safe #'stringp)

(flycheck-define-checker haml-lint
  "A haml-lint syntax checker"
  :command ("haml-lint"
            (config-file "--config" flycheck-haml-lintrc)
            source)
  :error-patterns
  ((warning line-start
            (file-name) ":" line " [W] "  (message)
            line-end))
  :modes (haml-mode))

; JS mode
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq js2-highlight-level 3)
; use js-mode for js.erb, since webmode is broken on it
(add-to-list 'auto-mode-alist '("\\.js.erb\\'" . js-mode))
