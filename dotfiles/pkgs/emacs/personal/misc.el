(require 'use-package)

;;(desktop-save-mode 1)
(scroll-bar-mode -1)

;; More sane line-number behaviour
(use-package display-line-numbers
  :hook ((prog-mode . display-line-numbers-mode)
         (org-mode . display-line-numbers-mode)
         (artist-mode . (lambda () (display-line-numbers-mode -1))))
  :config
  (setq
   display-line-numbers-grow-only 1
   display-line-numbers-width-start 1))

;; Calendar settings
(use-package calendar
  :config
  (setq calendar-date-style "european"
        calendar-week-start-day 1))

;; Ivy
(use-package counsel
  :config
  (setq
   ivy-count-format "(%d/%d) ")
  :bind (:map global-map
              (("M-x" . helm-M-x))))

;;Export Clock Entries
(use-package org-clock-csv
  :ensure t)

;; TS
(use-package typescript-mode
  :config (setq ts-comint-program-command "~/.yarn/bin/tsun")
  :bind (:map typescript-mode-map
              (("C-x C-e" . ts-send-last-sexp))))

(use-package web-mode
  :hook (web-mode . (lambda ()
                      (flycheck-add-mode 'typescript-tslint 'web-mode)
                      (when (string-equal "tsx" (file-name-extension buffer-file-name))
                        (prelude-ts-mode-defaults))))
  :init
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode)))

;;JS2
(use-package js2-mode
  :config (setq js2-basic-offset 2))

;; (use-package zig-mode
;;   :hook (zig-mode . (lambda ()
;;                        (lsp)
;;                        (company-mode)
;;                        (flycheck-mode))))

;; Window numbering
(use-package window-numbering
  :ensure t
  :config
  (window-numbering-mode))


;; Projectile
(use-package projectile
  :bind (:map projectile-mode-map
              (("M-s-p r" . helm-projectile-rg)
               ("M-s-p p" . helm-projectile))))

;; (use-package drag-stuff
;;   :enable t
;;   :bind (:map global-map
;;               (("M-<up>" . "drag-stuff-up"
;;                 "M-<down>" . "drag-stuff-down"))))

;; Circe IRC
(use-package circe
  :config
  (setq circe-network-options
        `(("Freenode"
           :tls t
           :nick "ja0nz"
           :sasl-username "ja0nz"
           :sasl-password ,(shell-command-to-string "gpg2 -q --for-your-eyes-only --no-tty -d ~/.gnupg/shared/freenode.gpg")
           :channels ("#nim" "#guile" "#guix" "#home-manager" "#sway")))))

;; Slime nav
(use-package slime
  :ensure t
  :commands (slime slime-lisp-mode-hook)
  :config
  (slime-setup)
  (add-hook 'slime-repl-mode-hook #'smartparens-strict-mode))
(add-hook 'emacs-lisp-mode-hook #'elisp-slime-nav-mode)
(add-hook 'ielm-mode-hook #'elisp-slime-nav-mode)

;; Multi term
(use-package multi-term
  :ensure t
  :config (setq multi-term-program "/usr/bin/fish"))

;; Clojure
(prelude-install-search-engine "CLJDocs" "https://clojuredocs.org/search?q=" "Search CLJ Docs: ")

(use-package clojure-mode
  :ensure t
  :bind
  (("M-<up>" . paredit-backward-up)
   ("M-<down>" . paredit-forward-down)
   ("M-<right>" . paredit-forward)
   ("M-<left>" . paredit-backward))
  :hook (clojure-mode . (lambda ()
                          (clj-refactor-mode)
                          (parinfer-mode)
                          (yas-minor-mode)
                          (cljr-add-keybindings-with-prefix "C-c C-m")))
  :init
  (progn
    (setq cider-cljs-lein-repl
          "(do (require 'figwheel-sidecar.repl-api)
                (figwheel-sidecar.repl-api/start-figwheel!)
                (figwheel-sidecar.repl-api/cljs-repl))")))

(use-package parinfer
  :ensure t
  :bind
  (("M-s-," . parinfer-toggle-mode)
   ("M-s-i" . parinfer-auto-fix))
  :config (setq parinfer-auto-switch-indent-mode t)
  :hook ((emacs-lisp-mode . parinfer-mode)
         (common-lisp-mode . parinfer-mode)
         (scheme-mode . parinfer-mode)
         (lisp-mode . parinfer-mode))
  :init
  (progn
    (setq parinfer-extensions
          '(defaults       ; should be included.
             pretty-parens  ; different paren styles for different modes.
             ;; lispy         ; If you use Lispy. With this extension, you should install Lispy and do not enable lispy-mode directly.
             ;; paredit        ; Introduce some paredit commands.
             ;; smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
             smart-yank))))   ; Yank behavior depend on mode.


;; Purescript
(prelude-install-search-engine "Pursuit" "https://pursuit.purescript.org/search?q=" "Search Pursuit: ")
;; Umbrella
(prelude-install-search-engine "Umbrella" "https://docs.thi.ng/umbrella/" "Search Umbrella Repo: ")

;; ensure psc-ide package
(use-package purescript-mode
  :ensure t
  :bind (("M-s-SPC" . company-complete))
  :config (setq psc-ide-rebuild-on-save t)
  :hook (purescript-mode . (lambda ()
                             (psc-ide-mode)
                             (company-mode)
                             (flycheck-mode)
                             (turn-on-purescript-indentation))))

(use-package nix-mode
  :mode "\\.nix\\'")

;; Rust
(use-package lsp-mode
  :hook (rust-mode . lsp)
;;  :hook (zig-mode . lsp)
  :commands lsp)

(use-package rust-mode
  :config (setq company-tooltip-align-annotations t
                company-minimum-prefix-length 1
                indent-tabs-mode nil)
  :hook (rust-mode . (lambda ()
                       (lsp)
                       (company-mode)
                       (flycheck-mode)
                       (cargo-minor-mode))))

;; set Iosevka font only if it available
(defun rag-set-face (frame)
  "Configure faces on frame creation"
  (select-frame frame)
  (if (display-graphic-p)
      (progn
        (when (member "Iosevka" (font-family-list))
          (progn
            (set-frame-font "Iosevka-12" nil t))))))
(add-hook 'after-make-frame-functions #'rag-set-face)

;; set frame font when running emacs normally
(when (member "Iosevka" (font-family-list))
  (progn
    (set-frame-font "Iosevka-12" nil t)))
