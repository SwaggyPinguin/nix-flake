;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;;------ User Configuration ------;;;

(setq doom-theme 'doom-one)

;; (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
;;       doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
;;       doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 20)
;;       doom-serif-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))

(setq doom-font (font-spec :family "Liga SFMono Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Liga SFMono Nerd Font" :size 14)
      doom-big-font (font-spec :family "Liga SFMono Nerd Font" :size 20)
      doom-serif-font (font-spec :family "Liga SFMono Nerd Font" :size 14))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

;; (custom-set-faces!
;;   '(font-lock-comment-face :slant italic)
;;   '(font-lock-keyword-face :slant italic))

(setq display-line-numbers-type t) ; nil to disable or relative

;; Icons in completion buffers
;; (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)
;; (all-the-icons-completion-mode)

;; This makes non-main buffers dimmer, so you can focus on main buffers
(solaire-global-mode +1)

;; Beacon shows where the cursor is, even when fast scrolling
;; (setq beacon-mode t)
(beacon-mode 1)

;; Don't create backup files
(setq make-backup-files nil)

;; Set default org directory
(setq org-directory "~/org/")

;; Top-level headings should be bigger!
(custom-set-faces!
  '(org-level-1 :inherit outline-1 :height 1.3)
  '(org-level-2 :inherit outline-2 :height 1.25)
  '(org-level-3 :inherit outline-3 :height 1.2)
  '(org-level-4 :inherit outline-4 :height 1.1)
  '(org-level-5 :inherit outline-5 :height 1.1)
  '(org-level-6 :inherit outline-6 :height 1.05)
  '(org-level-7 :inherit outline-7 :height 1.05)
  )

(after! org (org-eldoc-load))

(with-eval-after-load 'org (global-org-modern-mode))

(setq
  ;; Edit settings
  org-auto-align-tags nil
  org-tags-column 0
  org-fold-catch-invisible-edits 'show-and-error
  org-special-ctrl-a/e t
  org-insert-heading-respect-content t

  ;; Org styling, hide markup etc.
  org-hide-emphasis-markers t
  org-pretty-entities t
  org-ellipsis "…")

(setq-default line-spacing 0)

;; Automatic table of contents is nice
(if (require 'toc-org nil t)
    (progn
      (add-hook 'org-mode-hook 'toc-org-mode)
      (add-hook 'markdown-mode-hook 'toc-org-mode))
  (warn "toc-org not found"))

;; Tangle Org files when we save them
(defun tangle-on-save-org-mode-file()
  (when (string= (message "%s" major-mode) "org-mode")
    (org-babel-tangle)))

(add-hook 'after-save-hook 'tangle-on-save-org-mode-file)

;; Better for org source blocks
;; (setq electric-indent-mode nil)
;; (setq org-src-window-setup 'current-window)
;; (set-popup-rule! "^\\*Org Src"
;;   :side 'top'
;;   :size 0.9)

;; (use-package! org-auto-tangle
;;   :defer t
;;   :hook (org-mode . org-auto-tangle-mode)
;;   :config
;;   (setq org-auto-tangle-default t))

;; (defun nd/insert-auto-tangle-tag ()
;;   "Insert auto-tangle tag in a literate config."
;;   (interactive)
;;   (evil-org-open-below 1)
;;   (insert "#+auto_tangle: t ")
;;   (evil-force-normal-state))

;; (map! :leader
;;       :desc "Insert auto_tangle tag" "i a" #'nd/insert-auto-tangle-tag)

;; Set Path to search for Projects
(setq projectile-project-search-path '("~/Documents/Projects/bmc/bmc-staging" "~/Documents/Projects/wifimedia4u"))

;; I don't know if this is working
;; Prevent initializing the home directory as a project if it is managed with git
(after! projectile
  (setq projectile-project-root-files-bottom-up
        (remove ".git"
          projectile-project-root-files-bottom-up)))

;; Quicker window management keybindings
(bind-key* "C-j" #'evil-window-down)
(bind-key* "C-k" #'evil-window-up)
(bind-key* "C-h" #'evil-window-left)
(bind-key* "C-l" #'evil-window-right)
(bind-key* "C-q" #'evil-window-delete)
(bind-key* "M-q" #'kill-current-buffer)
(bind-key* "M-w" #'+workspace/close-window-or-workspace)
(bind-key* "M-n" #'next-buffer)
(bind-key* "M-p" #'previous-buffer)
(bind-key* "M-z" #'+vterm/toggle)
(bind-key* "M-e" #'+eshell/toggle)
(bind-key* (kbd "M-<return>") #'+vterm/here)
(bind-key* (kbd "M-E") #'+eshell/here)

(bind-key* "<mouse-4>" #'next-buffer)
(bind-key* "<mouse-5>" #'previous-buffer)

;; Unique buffer names
(setq uniquify-buffer-name-style 'forward
      uniquify-min-dir-content 3)

;; Set buffer file size limit
(setq default-buffer-file-size-limit (* 1024 1024)) ; Set to 1 MB

;; Garbage collection to speed things up
;; (add-hook 'after-init-hook
;;           #'(lambda ()
;;               (setq gc-cons-threshold (* 100 1024 1024))))
;; (add-hook 'after-focus-change-function 'garbage-collect)
;; (run-with-idle-timer 5 t 'garbage-collect)

;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; (map! :desc "Increase font size"
;;       "C-=" 'text-scale-increase

;;       :desc "Decrease font size"
;;       "C--" 'text-scale-decrease

;;       :desc "Jump to dired"
;;       "M-f" 'dired-jump
;; )

;; (require 'focus)

;; (map! :leader
;;       :prefix ("F" . "Focus mode")
;;       :desc "Toggle focus mode"
;;       "t" 'focus-mode

;;       :desc "Pin focused section"
;;       "p" 'focus-pin

;;       :desc "Unpin focused section"
;;       "u" 'focus-unpin)

;; (add-to-list 'focus-mode-to-thing '(org-mode . org-element))
;; (add-to-list 'focus-mode-to-thing '(php-mode . paragraph))
;; (add-to-list 'focus-mode-to-thing '(lisp-mode . paragraph))

(use-package lsp-mode)

(use-package nix-mode
  :hook (nix-mode . lsp-deferred))

(use-package php-mode
  :hook (php-mode . lsp-deferred))

(setq +format-on-save-enabled-modes '(not emacs-lisp-mode sql-mode nix-mode php-mode))

;; File Modes
(add-to-list 'auto-mode-alist '("\\.html\\.twig\\'" . web-mode))

(add-hook 'before-save-hook 'php-cs-fixer-before-save)
(use-package! php-cs-fixer
  :config
  (setq php-cs-fixer-config-option (concat (getenv "HOME") "/.config/doom/tools/.php-cs.php")))

(use-package dap-mode
  :config
  (dap-ui-mode 1)
  (require 'dap-php)
  (dap-php-setup))

;; (dap-register-debug-template
;;  "PHP Listen for Xdebug"
;;  (list :type "php"
;;        :request "launch"
;;        :name "Listen for Xdebug"
;;        :port 9003
;;        :stopOnEntry t
;;        :sourceMaps t
;;        ;; :pathMappings (ht ("/var/www/bmc" "${workspaceFolder}"))
;;        ;; :pathMappings (list
;;        ;;                "/var/www/wifimedia4u" "${workspaceFolder}"
;;        ;;                "/var/www/bmc" "${workspaceFolder}")
;;        :log (concat doom-cache-dir "xdebug.log")))

(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "bash"))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("M-j" . 'copilot-accept-completion)
              ("M-j" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))
              ;; ("<tab>" . 'copilot-accept-completion)
              ;; ("TAB" . 'copilot-accept-completion)
              ;; ("C-TAB" . 'copilot-accept-completion-by-word)
              ;; ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; disable copilot warning
(use-package copilot
  :hook
  (prog-mode . copilot-mode)
  (copilot-mode . (lambda ()
                    (setq-local copilot--indent-warning-printed-p t))))

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook 'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'php-mode-hook 'emmet-mode)

;; Already set to "SPC t z" (Zen Mode)
;; (map! :leader
;;       (:prefix "t"
;;                :desc "Writeroom Mode" "W" #'writeroom-mode))

(with-eval-after-load 'writeroom-mode
  (define-key writeroom-mode-map (kbd "C-M-<") #'writeroom-decrease-width)
  (define-key writeroom-mode-map (kbd "C-M->") #'writeroom-increase-width)
  (define-key writeroom-mode-map (kbd "C-M-=") #'writeroom-adjust-width))

(global-set-key (kbd "C-'") 'avy-goto-char-2)

;; Disables custom.el
(setq custom-file null-device)
