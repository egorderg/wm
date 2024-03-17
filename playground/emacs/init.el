;; Learn
;; wgrep, grep-mode
;; ibuffer
;; eglot, edoc, xref, flycheck, flymake
;; ace-window

(let* ((minver "29.1"))
  (when (version< emacs-version minver)
    (error "Emacs v%s or higher is required" minver)))

(unless (bound-and-true-p my-computer-has-smaller-memory-p)
  (setq gc-cons-percentage 0.6)
  (setq gc-cons-threshold most-positive-fixnum))

(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

(set-face-attribute 'default nil :font "FiraCode Nerd Font Ret" :height 200)

;; Keybindings
(keymap-set help-map "C-k" 'describe-keymap)

(keymap-unset ctl-x-map "f")

(keymap-set text-mode-map "C-x f" 'auto-fill-mode)

(add-hook 'help-mode-hook
	  (lambda ()
	    (keymap-set help-mode-map "j" 'next-line)
	    (keymap-set help-mode-map "k" 'previous-line)
	    (keymap-set help-mode-map "h" 'backward-char)
	    (keymap-set help-mode-map "l" 'forward-char)
	    (keymap-set help-mode-map "H" 'help-go-back)
	    (keymap-set help-mode-map "L" 'help-go-forward)
	    (keymap-set help-mode-map "J" 'help-goto-next-page)
	    (keymap-set help-mode-map "K" 'help-goto-previous-page)
	    (keymap-unset help-mode-map "n")
	    (keymap-unset help-mode-map "p")
	    (keymap-unset help-mode-map "r")))

(use-package 'tetris
  :disabled t)
	   
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

(autoload 'View-scroll-half-page-forward "view")
(autoload 'View-scroll-half-page-backward "view")

(keymap-global-set "C-v" 'View-scroll-half-page-forward)
(keymap-global-set "M-v" 'View-scroll-half-page-backward)

;; Treesitter
(setq treesit-font-lock-level 4)

;; (setq display-line-numbers-type 'relative)
(setq display-line-numbers-type 'absolute)
(column-number-mode 1)
(global-display-line-numbers-mode t)

;; Theme/Modeline
(blink-cursor-mode -1)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)
  :config
  (propertize (all-the-icons-octicon "package")
            'face `(:family ,(all-the-icons-octicon-family) :height 1.2)
            'display '(raise -0.1)))

(use-package all-the-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

(use-package all-the-icons-completion
  :init
  (all-the-icons-completion-mode 1)
  (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

(use-package ef-themes
  :config
  (load-theme 'ef-light t))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 55))

;; Workspace
(setq tab-bar-show 1)                      ;; hide bar if <= 1 tabs open
(setq tab-bar-close-button-show nil)       ;; hide tab close / X button
;; (setq tab-bar-new-tab-choice "*dashboard*");; buffer to show in new tabs
(setq tab-bar-tab-hints nil)                 ;; show tab numbers
(setq tab-bar-separator " ")
(setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator))
(tab-bar-mode 1)

;; Completion
(use-package vertico
  :init
  (vertico-mode 1)
  (vertico-multiform-mode 1)
  :config
  (setq vertico-cycle t
	vertico-multiform-categories
	'((consult-grep buffer))))

(use-package consult
  :bind
  (("C-c M-x" . consult-mode-command)
   ("C-x b" . consult-buffer)
   ("C-x 4 b" . consult-buffer-other-window)
   ("C-x 5 b" . consult-buffer-other-frame)
   ("C-x t b" . consult-buffer-other-tab)
   ("M-y" . consult-yank-pop)
   ("M-g g" . consult-goto-line)
   ("M-g M-g" . consult-goto-line)))

(use-package marginalia
  :init (marginalia-mode 1))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Editing
(use-package hydra)

(defhydra hydra-buffer (
	      	      :pre (setq hydra-is-helpful nil)
		      :after-exit (setq hydra-is-helpful t))
  ("b" consult-buffer)
  ("k" kill-current-buffer)
  ("j" next-line)
  ("i" nil :color blue))

;; (keymap-global-set "C-c b" 'hydra-buffer/body)
;; M-g
;; M-s

(use-package ryo-modal
  :commands (ryo-modal-mode)
  :bind ("C-c C-SPC" . ryo-modal-mode)
  :config
  (ryo-modal-keys
   ("," ryo-modal-repeat)
   ("v" set-mark-command)
   ("V" rectangle-mark-mode)
   ("i" ryo-modal-mode -1)
   ("I" back-to-indentation :exit t)
   ("A" move-end-of-line :exit t)
   ("h" backward-char)
   ("H" backward-sentence)
   ("j" next-line)
   ("J" forward-paragraph)
   ("k" previous-line)
   ("K" backward-paragraph)
   ("l" forward-char)
   ("L" forward-sentence)
   ("w" forward-to-word)
   ("e" forward-word)
   ("b" backward-word)
   ("x" delete-char)
   ("u" undo))

  (ryo-modal-keys
   ("d"
    (("l" kill-whole-line)
     ("w" kill-word)
     ("r" kill-region))))

  (ryo-modal-keys
   ("c"
    (("w" kill-word :exit t)
     ("r" kill-region :exit t))))

  (ryo-modal-keys
   ("g"
    (("h" back-to-indentation)
     ("l" move-end-of-line)
     ("g" beginning-of-buffer)
     ("e" end-of-buffer)
     ("t" consult-goto-line))))

  (ryo-modal-keys
   ("SPC b"
    (("b" consult-buffer)
     ("k" kill-current-buffer))))

  (ryo-modal-keys
   ;; These keywords will be applied to all keybindings.
   (:norepeat t)
   ("0" "M-0")
   ("1" "M-1")
   ("2" "M-2")
   ("3" "M-3")
   ("4" "M-4")
   ("5" "M-5")
   ("6" "M-6")
   ("7" "M-7")
   ("8" "M-8")
   ("9" "M-9")))

(setq cursor-type t)
(setq ryo-modal-cursor-type 'box)
(setq ryo-modal-cursor-color "red")

(add-hook 'prog-mode-hook
	  (lambda ()
	    (ryo-modal-mode 1)))

(setq treesit-language-source-alist
      '((go . ("https://github.com/tree-sitter/tree-sitter-go" "v0.20.0"))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ec8ff5e2c8a9eb38e49a9bea6297c2194bbe0c03982630d66db1570f5ae83d90" "6f780ba22a933a57ee1b3aea989dc527c068a31d31513d2f1956955f2a697e6e" "84b04a13facae7bf10f6f1e7b8526a83ca7ada36913d1a2d14902e35de4d146f" "9aa431bc3739422ffb91d9982b52d39cbf5fbe9b472fcdea3d6eccaafa65962f" "f02f8c8efe52c25819eb4341bbadb483d366f637aea0e092e62629126db3545d" default))
 '(package-selected-packages
   '(all-the-icons-ibuffer hydra tsetlbub orderless ef-themes marginalia all-the-icons-completion all-the-icons consult doom-modeline vertico ryo-modal)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tab-bar ((t (:inherit ef-themes-ui-variable-pitch))))
 '(tab-bar-tab ((t (:weight semibold :box (:line-width (40 . 8) :style flat-button)))))
 '(tab-bar-tab-inactive ((t (:background "#dbdbdb" :box (:line-width (40 . 8) :style flat-button))))))
