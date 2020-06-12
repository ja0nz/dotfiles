(require 'use-package)
;; org-mode
;; Show lot of clocking history so it's easy to pick items off the `C-c I` list
;; (setq org-clock-history-length 23)

(use-package org-mru-clock
  :ensure t
  :bind (("M-s-t i" . org-mru-clock-in)
         ("M-s-t r" . org-mru-clock-select-recent-task))
         ("M-s-t t" . org-clock-in)
         ("M-s-t o" . org-clock-out)
         ("M-s-t u" . org-update-all-dblocks)
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

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))

(use-package org
  :init (require 'helm-org)
  :hook ((org-mode . (lambda () (org-bullets-mode) (org-indent-mode) (turn-on-visual-line-mode)))
         (org-shiftup-final . windmove-up)
         (org-shiftdown-final . windmove-down)
         (org-shiftleft-final . windmove-left)
         (org-shiftright-final . windmove-right))
  :bind (:map org-mode-map ("M-s-g g" . counsel-org-goto))
  :config
  (setq org-directory "~/Dropbox/org/"
        org-agenda-files
        (cons
         "~/Dropbox/org/_tags.org"
         (directory-files
          org-directory t
          (concat "^W" (format-time-string "%V"))))
        org-complete-tags-always-offer-all-agenda-tags t
        org-agenda-start-with-clockreport-mode t
        org-agenda-clockreport-parameter-plist '(:link t :maxlevel 2 :fileskip0 t :compact t :narrow 80 :tags t)
        org-capture-templates
        '(
          ;; ("a" "Appointment" entry (file  "~/emacs/gcal.org") "* %?\n  :PROPERTIES:\n  :calendar-id: jan.peteler@gmail.com\n  :END:\n:org-gcal:\n%^T--%^T\n:END:\n")
          ;; ("l" "Timeline - current buffer!" entry (file+headline (lambda () (buffer-file-name)) "Timeline")) "* %t\n- %?" :prepend t)
          ;; ("c" "TODOs - current buffer!" entry (file+headline (lambda () (buffer-file-name)) "TODOs") "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))" :prepend t)
          ;; ("w" "writing" entry (file+headline "~/Dropbox/org/writings.org" "UNSORTED") "* %?\n%U" :prepend t)
          ;; ("t" "todo" entry (file+headline "~/Dropbox/org/todos.org" "UNSORTED") "* TODO [#A] %?\nSCHEDULED: %t\n%a\n" :prepend t)
          ;; ("s" "scratch" entry (file "~/Dropbox/org/scratch.org") "* %?\n%u" :prepend t)
          ("b" "bookmark" entry (file+headline "~/Dropbox/org/20200812162016-bookmarks.org" "UNSORTED") "* %?\n%u")
          ("p" "project" entry (file+headline "~/Dropbox/org/20200823100043-projects.org" "UNSORTED") "* %?\n%u"))
        org-support-shift-select 'always
        org-goto-interface 'outline-path-completion
        org-outline-path-complete-in-steps nil
        org-refile-targets
        '(("~/Dropbox/org/bookmarks.org" :maxlevel . 1)
          ("~/Dropbox/org/todos.org" :maxlevel . 1)
          ("~/Dropbox/org/writings.org" :maxlevel . 1)
          ("~/Dropbox/org/projects.org" :maxlevel . 1))))


(use-package org-roam
  :hook
  (after-init . org-roam-mode)
  :init (require 'org-roam-protocol)
  :custom
  (org-roam-directory "~/Dropbox/org/")
  :bind (:map org-roam-mode-map
              (("M-s-s l" . org-roam) ;; show links
               ("M-s-s g" . org-roam-graph)) ;; show in browser
              :map org-mode-map
              (("M-s-s i" . org-roam-insert)) ;; insert links in org documents
              :map global-map
              (("M-s-s f" . org-roam-find-file)))) ;; quickly jump in / New

(use-package org-journal
  :ensure t
  :config
  (setq org-journal-date-prefix "#+title: "
        org-journal-time-prefix "* "
        org-journal-date-format "W%V_%Y-%m-%d"
        org-journal-file-format "W%V_%Y-%m-%d.org"
        ;;org-journal-file-format (concat org-journal-date-format ".org")
        ;;org-journal-skip-carryover-drawers (list "LOGBOOK")
        org-journal-dir "~/Dropbox/org/")
  :bind (:map org-journal-mode-map
              (("M-s-n b" . org-journal-previous-entry)
               ("M-s-n f" . org-journal-next-entry)
               ("M-s-n s" . org-journal-search))
              :map global-map
              (("M-s-n n" . org-journal-new-entry)
               ("M-s-n m" . org-journal-new-scheduled-entry))))

(defun clocktable-by-tag/shift-cell (n)
  (let ((str ""))
    (dotimes (i n)
      (setq str (concat str "| ")))
    str))

(defun clocktable-by-tag/insert-tag (params)
  (let ((tag (plist-get params :tags)))
    (insert "|--\n")
    (insert (format "| %s | *Tag time* |\n" tag))
    (let ((total 0))
      (mapcar
       (lambda (file)
         (let ((clock-data (with-current-buffer (find-file-noselect file)
                             (org-clock-get-table-data (buffer-name) params))))
           (when (> (nth 1 clock-data) 0)
             (setq total (+ total (nth 1 clock-data)))
             (insert (format "| | File *%s* | %.2f |\n"
                             (file-name-nondirectory file)
                             (/ (nth 1 clock-data) 60.0)))
             (dolist (entry (nth 2 clock-data))
               (insert (format "| | . %s%s | %s %.2f |\n"
                               (org-clocktable-indent-string (nth 0 entry))
                               (nth 1 entry)
                               (clocktable-by-tag/shift-cell (nth 0 entry))
                               (/ (nth 4 entry) 60.0)))))))
       (org-agenda-files))
      (save-excursion
        (re-search-backward "*Tag time*")
        (org-table-next-field)
        (org-table-blank-field)
        (insert (format "*%.2f*" (/ total 60.0)))))
    (org-table-align)))

(defun org-dblock-write:clocktable-by-tag (params)
  (insert "| Tag | Headline | Time (h) |\n")
  (insert "|     |          | <r>  |\n")
  (let ((tags (plist-get params :tags)))
    (mapcar (lambda (tag)
              (clocktable-by-tag/insert-tag (plist-put (plist-put params :match tag) :tags tag)))
            tags)))