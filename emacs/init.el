;; Базовая настройка

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")

(set-face-attribute 'default nil :font "Jetbrains Mono NL" :height 130)
(setq auth-sources '("~/.authinfo"))
(setq warning-minimum-level :error)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(scroll-bar-mode -1)
(tool-bar-mode -1)

(display-time-mode 1)
(delete-selection-mode 1)
;;(global-tab-line-mode)
;; Настройка use-package

(require 'package)

(setq package-archives '(("melpa" . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/melpa/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("gnu-devel" . "https://elpa.gnu.org/devel/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(use-package use-package-ensure-system-package :ensure t)
(setq use-package-always-ensure t)

(setq ispell-program-name "aspell")

(setq ispell-dictionary "ru")

(use-package yascroll
  :config (global-yascroll-bar-mode 1)
  )


;; Настройка темы и украшений
;; (use-package material-theme)
;; (load-theme 'material-light t)

;; (use-package apropospriate-theme
;;   :ensure t
;;   :config
;;   ;;(load-theme 'apropospriate-dark t)
;;   ;; or
;;   (load-theme 'apropospriate-light t))

;; (use-package doom-themes
;;   :config
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-tomorrow-day t)
;;   ;;(doom-themes-treemacs-config)
;;   (doom-themes-org-config)
;;   )


;; (use-package kaolin-themes
;;   :config
;;   (load-theme 'kaolin-mono-light t)
;;   (kaolin-treemacs-theme))

(use-package catppuccin-theme
  :config (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'latte)
  (catppuccin-reload))

(use-package all-the-icons)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(use-package nerd-icons
  :custom
  (nerd-icons-font-family "JetbrainsMono NFP")
  (nerd-icons-scale-factor 1.3))


(use-package telega)

(require 'telega-emacs-stories)

(telega-emacs-stories-mode 1)

(define-key telega-root-mode-map (kbd "v e") 'telega-view-emacs-stories)

;; Отображение начального экрана
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-banner-logo-title "pank-su Emacs")
  (dashboard-center-content t)
  (dashboard-display-icons-p t)
  (dashboard-icon-type 'nerd-icons)
  ;;(dashboard-set-heading-icons t)
  (dashboard-items '(
		     (recents   . 5)
                     (projects  . 5)
                     (agenda    . 5)
		     ))
  ;;(dashboard-set-file-icons t)
  ;; Картинка
  (dashboard-startup-banner "~/.config/emacs/me/god.png")
  ;; Цитатки
  (dashboard-footer-messages
  '("Emacs - это не просто редактор, это образ жизни."
    "Только Emacs может понять истинную глубину вашей души."
    "С Emacs вы можете править код, писать стихи, и даже управлять миром."
    "Vim? Кто это? Мы тут Emacs используем."
    "Emacs настолько крут, что ему не нужен GUI."
    "Если вы не можете понять Emacs, значит вы не достаточно умны."
    "Emacs - это Сила."
    "Emacs - это Матрица."
    "Emacs готов к работе! А вы?"
    "Наслаждайтесь Emacs! (Или не наслаждайтесь, это ваше дело.)"
    "Emacs - лучший редактор для удаленной работы."
    "Emacs поможет вам пережить пандемию."
    "Emacs - ваш верный друг в эти непростые времена."
    "Emacs - это не редактор, это динозавр."
    "Emacs настолько тяжелый, что он может сломать ваш компьютер."
    "Emacs - это черная дыра, из которой невозможно выбраться."
    )
  )
)

(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-group-by-projectile-project)
  :custom
  (centaur-tabs-set-icons t)
  ;;(centaur-tabs-style "wave")
  (centaur-tabs-set-modified-marker t)

  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  ("C-S-<prior>" . centaur-tabs-move-current-tab-to-left)
  ("C-S-<next>" . centaur-tabs-move-current-tab-to-right))



(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-major-mode-color-icon t)
  (doom-modeline-icon t)
  (doom-modeline-time-icon t)
  (doom-modeline-time-live-icon t)
  (doom-modeline-modal-modern-icon t)
  (doom-modeline-env-version t)
  (doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
  (doom-modeline-lsp-icon t)
  (doom-modeline-buffer-state-icon t)

)




;; Для работы русских букв в сочетаниях клавиш
(use-package char-fold
  :custom
  (char-fold-symmetric t)
  (search-default-mode #'char-fold-to-regexp))
(use-package reverse-im
  :ensure t ; install `reverse-im' using package.el
  :demand t ; always load it
  :after char-fold ; but only after `char-fold' is loaded
  :bind
  ("M-T" . reverse-im-translate-word) ; fix a word in wrong layout
  :custom
  (reverse-im-char-fold t) ; use lax matching
  (reverse-im-read-char-advice-function #'reverse-im-read-char-include)
  (reverse-im-input-methods '("russian-computer")) ; translate these methods
  :config
  (reverse-im-mode t)) ; turn the mode on






;; Настройка org-mode
(setq org-edit-src-content-indentation 0)

(use-package org-bullets
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

(setq org-agenda-files '("~/Documents/agenda/"))
(global-set-key (kbd "C-c a") #'org-agenda)

(with-eval-after-load 'org-mode
  (define-key org-mode-map "\M-q" 'toggle-truncate-lines)
  )

(add-hook 'org-mode-hook 'flyspell-mode)

(use-package ob-kotlin)

(use-package org-modern
  :hook (org-mode-hook . org-modern-mode)
  )

(setq org-plantuml-jar-path "~/.emacs.d/plantuml.jar")

(use-package ox-reveal
  :config (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"))


;; Работа org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sql . t)
   (java . t)
   (kotlin . t)
   (shell . t)
   (plantuml . t)
   (python . t)
   (octave . t)
  )
 )

;; Адекватная вставка картинок в org-mode
(use-package org-download
    :after org
    :defer nil
    :custom
    (org-download-method 'directory)
    (org-download-image-dir "images")
    (org-download-heading-lvl nil)
    ;; (org-download-timestamp "%Y%m%d-%H%M%S_")
    (org-image-actual-width 300)
    (org-download-screenshot-method "magick clipboard: \"%s\"")
    :bind
    ("C-M-y" . org-download-screenshot)
    :config
    (require 'org-download)
    (add-hook 'dired-mode-hook 'org-download-enable)
    )

;; Правила безопасности org-babel
(defun my-org-confirm-babel-evaluate (lang body)
  (not (string= lang "octave"))) 
(setq org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)

(setq org-babel-default-header-args:sql '(
					  (:dbuser . "org-mode")
					  (:dbpassword . "org-mode")
					  ))

;; Отображение блоков кода в Latex с помощью данной билиотеки
(use-package engrave-faces
  :config (setq engrave-faces-preset-styles (engrave-faces-generate-preset)
	       )
  )


(require 'printing)

(setq ps-multibyte-buffer :bdf-font)
(setq bdf-directory-list "/usr/share/emacs/fonts/bdf")

 
;; (setq org-latex-image-default-option '(("float" "wrap")))


(setq org-latex-default-figure-position "H"
      org-export-default-language "ru"
      
      org-latex-default-packages-alist
   '(("AUTO" "inputenc" t
      ("pdflatex"))
     ("T2A" "fontenc" t
      ("pdflatex"))
     ("" "fontspec" t
      ("xelatex"))
     ("" "graphicx" t nil)
     ("" "longtable" nil nil)
     ("" "wrapfig" nil nil)
     ("" "rotating" nil nil)
     ("normalem" "ulem" t nil)
     ("" "amsmath" t nil)
     ("" "amssymb" t nil)
     ("" "capt-of" nil nil)
     ("" "hyperref" nil nil)))

(use-package ox-gost
  :load-path "./ox-gost"
  :config (setq org-gost-education-organization "ГУАП"
	        org-gost-department "КАФЕДРА №1"
		org-gost-teacher-position "старший преподаватель"
		org-gost-city "Санкт-Петербург"
		org-gost-group "М412"))




;; Подсказки
(use-package corfu
  :init (global-corfu-mode)
  (corfu-popupinfo-mode)
  :config
  (setq corfu-auto t
	corfu-quit-no-match 'separator))

(use-package kind-icon
  :ensure t
  :after corfu
  ;:custom
  ; (kind-icon-blend-background t)
  ; (kind-icon-default-face 'corfu-default) ; only needed with blend-background
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-dict)
  (add-hook 'completion-at-point-functions #'cape-emoji)
  (add-hook 'completion-at-point-functions #'cape-history)
  (add-hook 'completion-at-point-functions #'cape-keyword)
  )

(use-package yasnippet-capf
  :after cape
  :config
  (add-to-list 'completion-at-point-functions #'yasnippet-capf))

(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function. As an alternative,
  ;; try `cape-dict'.
  ;;(text-mode-ispell-word-completion nil)

  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

;; Остальные полезные библиотеки
(use-package magit)
(use-package forge)

(use-package smooth-scroll)
(use-package nyan-mode)
(use-package svg-lib)
(use-package fireplace)
(use-package multiple-cursors)


(use-package elcord)
(use-package gradle-mode
  :config (gradle-mode 1))
(use-package csv-mode)
(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))



(use-package flycheck-inline
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

(use-package projectile
  :config (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c r") 'projectile-run-project)
  (projectile-register-project-type 'kotlin '("settings.gradle.kts")
                                  :project-file "settings.gradle.kts"
				  :compile "./gradlew assembly"
				  ;;:test "npm test"
				  :run "./gradlew run"
				  )
  )


(use-package rust-mode
  :config
  ;(setq rust-mode-treesitter-derive t)
  (add-hook 'rust-mode-hook #'flycheck-rust-setup))

(use-package which-key
  :config
  (setq which-key-idle-delay 1.0)
  (which-key-mode))

(use-package selectrum
  :config (selectrum-mode +1))


(use-package treemacs
  :config (treemacs-project-follow-mode))

(use-package treemacs-projectile
  :config (setq projectile-switch-project-action #'treemacs))


(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-tab-bar
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))


(use-package yasnippet
  :config
  (yas-global-mode 1))
(use-package yasnippet-snippets
  )

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(use-package dockerfile-mode)

;;(use-package ros
  ;;:config
  ;;(setq ros-workspaces (list (ros-dump-workspace :tramp-prefix (format "/docker:root@%s:" "b9269ccc9e7d") :workspace "/ws" :extends '("/opt/ros/humble/")))))

(use-package eglot
  :config
  (define-key eglot-mode-map (kbd "C-c r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c o") 'eglot-code-action-organize-imports)
  (define-key eglot-mode-map (kbd "C-c h") 'eldoc)
  (define-key eglot-mode-map (kbd "<f6>") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "M-RET") 'eglot-code-action-quickfix)
  (define-key eglot-mode-map (kbd "C-M-l") 'eglot-format)
  
  (add-hook 'rust-mode-hook 'eglot-ensure)
  (setq eglot-connect-timeout 999999)
  (with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(kotlin-ts-mode . ("kotlin-language-server" :initializationOptions (:formatting (:ktfmt (:continuationIndent 4)))))))
  )
  



(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist)
  (global-treesit-auto-mode)
  (setq treesit-auto-langs '(kotlin)))


(use-package nov
    :init
    (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

;;(use-package ros
  ;;)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-latex-caption-above '(table src-block))
 '(package-selected-packages
   '(org yasnippet-snippets yasnippet-capf yascroll which-key use-package-ensure-system-package treesit-auto treemacs-tab-bar treemacs-projectile treemacs-magit telega smooth-scroll selectrum rust-mode reverse-im ox-reveal org-modern org-download org-bullets ob-kotlin nyan-mode nov multiple-cursors kind-icon gradle-mode forge flycheck-inline fireplace engrave-faces elcord doom-modeline dockerfile-mode docker dashboard csv-mode corfu centaur-tabs catppuccin-theme cape all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
