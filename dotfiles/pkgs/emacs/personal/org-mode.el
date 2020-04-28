(require 'use-package)
;; org-mode
;; Show lot of clocking history so it's easy to pick items off the `C-c I` list
;; (setq org-clock-history-length 23)

(use-package org-mru-clock
  :ensure t
  :bind* (("M-s-i" . org-mru-clock-in)
          ("M-s-a" . org-mru-clock-select-recent-task)
          ("M-s-u" . org-clock-out)
          ("M-s-e" . org-update-all-dblocks))
  :init
  (setq org-mru-clock-how-many 100
        org-mru-clock-completing-read #'ivy-completing-read))

;; (use-package org-gcal
;;   :ensure t
;;   :hook (org-agenda-mode . org-gcal-sync)
;;   :bind ("C-c M-k" . org-gcal-delete-at-point)
;;   :config
;;   (setq org-gcal-client-id "27237116424-qrn48jq6lt96ffci0c4u2refdl4bsogr.apps.googleusercontent.com"
;;         org-gcal-client-secret "123"
;;         org-gcal-file-alist '(("jan.peteler@gmail.com" .  "~/emacs/gcal.org"))))

(use-package org
  :hook ((org-mode . (lambda () (org-bullets-mode) (org-indent-mode) (turn-on-visual-line-mode)))
         (org-shiftup-final . windmove-up)
         (org-shiftdown-final . windmove-down)
         (org-shiftleft-final . windmove-left)
         (org-shiftright-final . windmove-right))
  :bind ("C-c M-j" . counsel-org-goto)
  :config
  (progn
    (setq org-agenda-files (list "~/Dropbox/org/todos.org" "~/Dropbox/org/projects.org")
          org-capture-templates
          '(
            ;; ("a" "Appointment" entry (file  "~/emacs/gcal.org") "* %?\n  :PROPERTIES:\n  :calendar-id: jan.peteler@gmail.com\n  :END:\n:org-gcal:\n%^T--%^T\n:END:\n")
            ;; ("l" "Timeline - current buffer!" entry (file+headline (lambda () (buffer-file-name)) "Timeline")) "* %t\n- %?" :prepend t)
            ;; ("c" "TODOs - current buffer!" entry (file+headline (lambda () (buffer-file-name)) "TODOs") "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))" :prepend t)
            ("w" "writing" entry (file+headline "~/Dropbox/org/writings.org" "UNSORTED") "* %?\n%U" :prepend t)
            ("t" "todo" entry (file+headline "~/Dropbox/org/todos.org" "UNSORTED") "* TODO [#A] %?\nSCHEDULED: %t\n%a\n" :prepend t)
            ("s" "scratch" entry (file "~/Dropbox/org/scratch.org") "* %?\n%u" :prepend t)
            ("b" "bookmark" entry (file+headline "~/Dropbox/org/bookmarks.org" "UNSORTED") "* %?\n%u")
            ("p" "project" entry (file+headline "~/Dropbox/org/projects.org" "UNSORTED") "* %?\n%u"))
          org-support-shift-select 'always
          org-goto-interface 'outline-path-completion
          org-outline-path-complete-in-steps nil
          org-refile-targets
          '(("~/Dropbox/org/bookmarks.org" :maxlevel . 1)
            ("~/Dropbox/org/todos.org" :maxlevel . 1)
            ("~/Dropbox/org/writings.org" :maxlevel . 1)
            ("~/Dropbox/org/projects.org" :maxlevel . 1)))))


(use-package org-roam
  :hook
  (after-init . org-roam-mode)
  :init (require 'org-roam-protocol)
  :custom
  (org-roam-directory "~/Dropbox/org-roam/")
  (org-roam-index-file "./index.org")
  :bind (:map org-roam-mode-map
              (("M-s-t l" . org-roam)
               ("M-s-t f" . org-roam-find-file)
               ("M-s-t g" . org-roam-graph))
              :map org-mode-map
              (("M-s-t i" . org-roam-insert))))

(use-package org-journal
  :ensure t
  :defer t
  :config
  (setq org-journal-dir "~/Dropbox/org-journal/"
        org-journal-date-format "%A, %d.%m.%Y"
        org-journal-enable-agenda-integration t)
  :bind (:map org-journal-mode-map
              (("M-s-n b" . org-journal-previous-entry)
               ("M-s-n f" . org-journal-next-entry)
               ("M-s-n s" . org-journal-search))
              :map global-map
              (("M-s-n n" . org-journal-new-entry)
               ("M-s-n s" . org-journal-new-scheduled-entry))))
