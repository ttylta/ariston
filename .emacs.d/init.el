;; Melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; Setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

```
;; Load/install evil
(use-package evil
  :ensure t
  :config
  (evil-mode 1))
```

;; Load/install dash
(use-package dash
  :ensure t)

;; Load/install tree-sitter / tree-sitter-langs
(use-package tree-sitter
  :ensure t
  :init (global-tree-sitter-mode
          (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)))
(use-package tree-sitter-langs
  :ensure t
  :after (tree-sitter))

;; Setup dired utils
(use-package dired-hacks-utils
  :ensure t)

(use-package dired-subtree
  :ensure t
  :after (dired-hacks-utils)
  :init
  (add-hook 'dired-subtree-mode-hook
            (lambda ()
              (local-set-key [l] #'dired-subtree-insert)
              (local-set-key [h] #'dired-subtree-remove))))

;; Flycheck!
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Company!
(use-package company
  :ensure t
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-idle-delay              0.1
        company-minimum-prefix-length   2
        company-show-numbers            t
        company-tooltip-limit           20
        company-dabbrev-downcase        nil
        company-backends                '((company-gtags))
      )
  )


(use-package dired
  :config
  (evil-define-key 'normal dired-mode-map "h" 'dired-subtree-remove)
  (evil-define-key 'normal dired-mode-map "l" 'dired-subtree-insert))

;; Dired-sidebar config
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;; LSP!
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (typescript-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :commands lsp-ui-mode)


;; Typesript mode!
  (use-package tide :ensure t)
  (use-package flycheck :ensure t)

  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    ;; company is an optional dependency. You have to
    ;; install it separately via package-install
    ;; `M-x package-install [ret] company`
    (company-mode +1))

  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)

  ;; formats the buffer before saving
  (add-hook 'before-save-hook 'tide-format-before-save)

  (add-hook 'typescript-mode-hook #'setup-tide-mode)

;; Load/install clojure-mode
(use-package clojure-mode
  :ensure t)

;; ewal!
(use-package ewal
  :init (setq ewal-use-built-in-always-p nil
              ewal-use-built-in-on-failure-p t
              ))
(use-package ewal-spacemacs-themes
  :init (progn
          (show-paren-mode +1))
  :config (progn
            (load-theme 'ewal-spacemacs-modern t)
            (enable-theme 'ewal-spacemacs-modern)))

(load-theme 'xresources t)
            (enable-theme 'xresources)


;; UI improvements
(xterm-mouse-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(add-to-list 'default-frame-alist '(internal-border-width  . 30))
(setq-default indent-tabs-mode nil)
(set-face-attribute 'mode-line nil
                    :box '(:width 0))
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(global-prettify-symbols-mode t)
;; (set-frame-font "curie 12" nil t)

;; Enable the display of the current time, see DisplayTime
(display-time-mode 1)
;; Enable or disable the display of the current line number, see also LineNumbers
(line-number-mode 1)
;; Enable or disable the display of the current column number
(column-number-mode 1)
;; (for Emacs 22 and up) – Enable or disable the current buffer size, Emacs 22 and later, see size-indication-mode
(size-indication-mode 1)
;; Enable or disable laptop battery information, see DisplayBatteryMode.
(display-battery-mode 1)

;; Avoid littering the user's filesystem with backups
(setq
    backup-by-copying t      ; don't clobber symlinks
    backup-directory-alist 
        ;; '((".*" . (concat user-emacs-directory "saves/")))    ; don't litter my fs tree
        ;; '((".*" . (expand-file-name "saves/" user-emacs-directory))) 
        '((".*" . "~/.emacs.d/saves/"))    ; don't litter my fs tree
    delete-old-versions t
    kept-new-versions 6
    kept-old-versions 2
    version-control t)       ; use versioned backups

;; Avoid littering of auto-saves
(setq auto-save-file-name-transforms
  `((".*" "~/.emacs.d/saves/" t)))

    ;;; Lockfiles unfortunately cause more pain than benefit
    (setq create-lockfiles nil)

;; Org customizations
(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

(setq org-hide-emphasis-markers t)
(defun my/modify-org-done-face ()
  (setq org-fontify-done-headline t)
  (set-face-attribute 'org-done nil :strike-through t)
  (set-face-attribute 'org-headline-done nil
                      :strike-through t))

(eval-after-load "org"
  (add-hook 'org-add-hook 'my/modify-org-done-face))

 (font-lock-add-keywords 'org-mode
                            '(("^ +\\([-*]\\) "
                               (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))


  (require 'org-bullets)
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Helpful when exporting with fern
(add-hook 'before-save-hook 'time-stamp) ; update timestamp, if it exists, when saving

(defun my/org-mode-hook ()
(set-face-attribute 'org-level-1 nil :box nil :background nil)
(set-face-attribute 'org-level-2 nil :box nil :background nil)
(set-face-attribute 'org-level-3 nil :box nil :background nil)
(set-face-attribute 'org-level-4 nil :box nil :background nil)
(set-face-attribute 'org-level-5 nil :box nil :background nil)
(set-face-attribute 'org-level-6 nil :box nil :background nil))
(add-hook 'org-mode-hook 'my/org-mode-hook)

;; Serif

(defun serif-mode ()
  "Make current buffer use a serif font."
  (interactive)
  (setq buffer-face-mode-face '(:family "Lora" :height 120 :weight light))
  (buffer-face-mode))

;; Live reloading of changes
(global-auto-revert-mode 1)
(add-hook 'dired-mode-hook 'auto-revert-mode)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;;; Setup themes
(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes/"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(dired-sidebar clojure-mode olivetti ewal-spacemacs-themes ewal use-package evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
