(defun dotspacemacs/user-init ())

;; all my config except layers
(defun dotspacemacs/user-config ()
  (setq dotspacemacs-startup-banner nil)
  (setq dotspacemacs-auto-resume-layouts nil)
  (setq dotspacemacs-auto-save-file-location nil)
  (setq dotspacemacs-default-font
        '("Menlo" :size 20 :weight normal :width normal :powerline-scale 1.1))
  (define-key evil-normal-state-map (kbd "SPC p p") 'helm-projectile)
  (define-key evil-normal-state-map (kbd "SPC p P") 'helm-projectile-switch-project)
  (define-key evil-normal-state-map (kbd "SPC p a") 'helm-projectile-ag)
  (global-set-key (kbd "s-t") 'helm-projectile)
  (global-set-key (kbd "s-b") 'helm-projectile)
  (global-set-key (kbd "s-d") 'neotree-find-project-root)
  (add-hook
   'neotree-mode-hook
   (lambda ()
     (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
     (define-key evil-normal-state-local-map (kbd "ma") 'neotree-create-node)
     (define-key evil-normal-state-local-map (kbd "md") 'neotree-delete-node)
     (define-key evil-normal-state-local-map (kbd "mr") 'neotree-rename-node)))

  ;; osx movements -> kinda bad but I am addicted
  (define-key evil-normal-state-map (kbd "<s-left>") 'move-beginning-of-line)
  (define-key evil-normal-state-map (kbd "<s-right>") 'move-end-of-line)
  (define-key evil-normal-state-map (kbd "<s-up>") 'beginning-of-buffer)
  (define-key evil-normal-state-map (kbd "<s-down>") 'end-of-buffer)

  ;; 80 chars fill column
  (setq-default fill-column 80)
  (setq-default fci-rule-width 1)
  (setq-default fci-rule-color "darkblue")
  (add-hook 'after-change-major-mode-hook 'fci-mode)

  (load-theme 'herald t)
)
