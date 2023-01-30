;; Ensures use-package is installed.

(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(require 'use-package)
(setq use-package-always-ensure t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
  (setq package-enable-at-startup nil)

;; Appearance

(set-frame-parameter (selected-frame) 'internal-border-width 32)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(column-number-mode)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
		dired-sidebar-mode
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(add-hook 'dired-sidebar-mode-hook (lambda () (display-line-numbers-mode 0)))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Don't wrap lines
(add-hook 'prog-mode-hook '(lambda ()
    (setq truncate-lines t
          word-wrap nil display-line-numbers-type 'relative)))


;;; EVIL

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Ensure things are clean.

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

;; Ewal

(use-package ewal
  :init (setq ewal-use-built-in-always-p nil
              ewal-use-built-in-on-failure-p t
              ewal-built-in-palette "sexy-material"))
(use-package ewal-spacemacs-themes
  :init (progn
          (show-paren-mode +1)
          (global-hl-line-mode)
          )
  :config (progn
            (load-theme 'ewal-spacemacs-modern t)
            (enable-theme 'ewal-spacemacs-modern)))
(use-package ewal-evil-cursors
  :after (ewal-spacemacs-themes)
  :config (ewal-evil-cursors-get-colors
           :apply t :spaceline t))
(use-package spaceline
  :after (ewal-evil-cursors winum)
  :init (setq powerline-default-separator nil)
  :config (spaceline-spacemacs-theme))

;; Tree-sitter
(use-package tree-sitter
  :ensure t
  :config
  ;; activate tree-sitter on any buffer containing code for which it has a parser available
  (global-tree-sitter-mode)
  ;; you can easily see the difference tree-sitter-hl-mode makes for python, ts or tsx
  ;; by switching on and off
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

;; LSP
(use-package yasnippet                  ; Snippets
  :ensure t
  :config

  (yas-reload-all)
  (yas-global-mode))

(use-package yasnippet-snippets         ; Collection of snippets
  :ensure t)

(use-package crdt
  :ensure t)

(use-package typescript-mode
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook ((js-mode typescript-mode) . lsp-deferred)
  :config
  (setq lsp-log-io t)
  (setq lsp-clients-typescript-max-ts-server-memory 8000)
  (setq lsp-headerline-breadcrumb-enable nil)
  :commands lsp lsp-deferred)

(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-border (face-foreground 'default))
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-lens-enable t)
  (setq lsp-ui-sideline-delay 0.05))

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      create-lockfiles nil) ;; lock files will kill `npm start'

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package ivy
  :ensure t
  :init (ivy-mode)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))

(straight-use-package '(tsi :type git :host github :repo "orzechowskid/tsi.el"))
(use-package tsi
  :straight (tsi :type git :host github :repo "orzechowskid/tsi.el")
  :init
  (add-hook 'typescript-mode-hook (lambda () (tsi-typescript-mode 1)))
  (add-hook 'json-mode-hook (lambda () (tsi-json-mode 1)))
  (add-hook 'css-mode-hook (lambda () (tsi-css-mode 1)))
  (add-hook 'scss-mode-hook (lambda () (tsi-scss-mode 1))))


;; Code
;;
;;
;;

(setq indent-tabs-mode nil)
(setq default-tab-width 2)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :config
  (setq projectile-completion-system 'ivy)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))


(use-package dired-subtree
  :ensure t
  :after dired
  :bind (:map dired-mode-map
              ("TAB" . dired-subtree-toggle)))

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

  (setq dired-sidebar-subtree-line-prefix "  ")
  (setq dired-sidebar-theme 'ascii)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

(use-package ibuffer-sidebar
  :load-path "~/.emacs.d/fork/ibuffer-sidebar"
  :ensure t
  :commands (ibuffer-sidebar-toggle-sidebar)
  :config
  (setq ibuffer-sidebar-use-custom-font t))

(defun sidebar-toggle ()
  "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
  (interactive)
  (dired-sidebar-toggle-sidebar)
  (ibuffer-sidebar-toggle-sidebar))


;; UI
(use-package highlight-indent-guides
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?|))

;;
;; Org-mode
;;

(setq org-toggle-inline-images 1)
(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.x?html?\\'" . "firefox %s")
        ("\\.pdf\\(::[0-9]+\\)?\\'" . "zathura %s")
        ("\\.mp4\\'" . "mpv \"%s\"")
        ("\\.mkv" . "mpv \"%s\"")))

; Hides asterisks
(setq org-hide-emphasis-markers t)
(setq org-return-follows-link t)

; Replaces dashes with bullets
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(use-package org-bullets
  :ensure t
  )

(add-hook 'org-mode-hook 'visual-line-mode)


(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "azukifontBI" :height 180))))
 '(fixed-pitch ((t ( :family "azukifontBI" :height 160)))))

 (setq org-startup-indented t
          org-pretty-entities t
          org-hide-emphasis-markers t
          org-startup-with-inline-images t
          org-image-actual-width '(300))

  ;; Distraction-free screen
  (use-package olivetti
    :ensure t
    :init
    (setq olivetti-body-width .47)
    :config
    (defun distraction-free ()
      "Distraction-free writing environment"
      (interactive)
      (if (equal olivetti-mode nil)
          (progn
            (window-configuration-to-register 1)
            (delete-other-windows)
            (text-scale-increase 1)
            (olivetti-mode t))
        (progn
          (jump-to-register 1)
          (olivetti-mode 0)
          (text-scale-decrease 1))))
    :bind
    (("<f9>" . distraction-free)))


;; Add strikethrough
(defun my/modify-org-done-face ()
  (setq org-fontify-done-headline t)
  (set-face-attribute 'org-done nil :strike-through t)
  (set-face-attribute 'org-headline-done nil
                      :strike-through t))
(eval-after-load "org"
  (add-hook 'org-add-hook 'my/modify-org-done-face))

(set-face-attribute 'org-level-1 nil :background nil)
(set-face-attribute 'org-level-2 nil :background nil)
(set-face-attribute 'org-level-3 nil :background nil)
(set-face-attribute 'org-level-4 nil :background nil)
(set-face-attribute 'org-level-5 nil :background nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil-visual-mark-mode evil use-package)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 125 :width normal :family "azukifontBI")))))
