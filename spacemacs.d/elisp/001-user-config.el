(defun dotspacemacs/user-init ()
  (setq dotspacemacs-startup-banner nil)
  (setq dotspacemacs-auto-resume-layouts nil)
  (setq dotspacemacs-auto-save-file-location nil)
  (setq dotspacemacs-default-font
        '("Menlo" :size 20 :weight normal :width normal :powerline-scale 1.1))
  (setq dotspacemacs-startup-lists '((recents . 5) (projects . 10))))

;; all my config except layers
(defun dotspacemacs/user-config ()
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

  (setq auto-mode-alist
    (append
     '(("\\.js\\'" . react-mode))
     auto-mode-alist))

  ;; make paste when a region is selected like if should (replace text with
  ;; system clipobard)
  ;; https://emacs.stackexchange.com/questions/14940/emacs-doesnt-paste-in-evils-visual-mode-with-every-os-clipboard/15054#15054
  (fset 'evil-visual-update-x-selection 'ignore)
  (delete-selection-mode 1)
)
