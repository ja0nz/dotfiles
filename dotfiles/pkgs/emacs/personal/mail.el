(require 'use-package)
(require 'mu4e-context)
(require 'smtpmail)

(defvar xdg-config "~/.config"
  "The XDG config base directory.")

(use-package use-package-ensure-system-package
  :ensure t)

(use-package mu4e
  :ensure nil
  :ensure-system-package (mu mbsync pandoc)
  :custom
  (mu4e-attachment-dir "~/Downloads")
  (mu4e-change-filenames-when-moving t)
  (mu4e-confirm-quit nil)
  (mu4e-completing-read-function 'ivy-completing-read)
  (mu4e-compose-dont-reply-to-self t)
  (mu4e-compose-signature-auto-include nil)
  (mu4e-get-mail-command (format "mbsync -a" xdg-config))
  (mu4e-maildir "~/Maildir")
  (mu4e-context-policy 'pick-first)
  (mu4e-compose-context-policy nil)
  (mu4e-html2text-command "iconv -c -t utf-8 | pandoc -f html -t plain")
  (mu4e-contexts `( ,(make-mu4e-context
                      :name "Home"
                      :enter-func (lambda () (mu4e-message "Enter Home context"))
                      :leave-func (lambda () (mu4e-message "Leaving Home context"))
                      :match-func (lambda (msg)
                                    (when msg
                                      (mu4e-message-contact-field-matches msg :to "mail@ja.nz")))
                      :vars '((user-mail-address . "mail@ja.nz")
                              (user-full-name . "Jan Peteler")
                              (mu4e-refile-folder . "/mail@ja.nz/Archive")
                              (mu4e-sent-folder . "/mail@ja.nz/Sent")
                              (mu4e-trash-folder . "/mail@ja.nz/Trash")
                              (mu4e-drafts-folder . "/mail@ja.nz/Drafts")
                              (mu4e-maildir-shortcuts . (("/mail@ja.nz/Inbox" . ?i)
                                                         ("/mail@ja.nz/Archive" . ?I)
                                                         ("/mail@ja.nz/Trash" . ?d)
                                                         ("/mail@ja.nz/Drafts" . ?D)
                                                         ("/mail@ja.nz/Sent" . ?s)))
                              ;; SMTP
                              (smtpmail-smtp-server . "smtp.purelymail.com")
                              (smtpmail-smtp-service . 587)
                              (smtpmail-smtp-user . "mail@ja.nz")
                              (smtpmail-stream-type . starttls)))))
  ;;(mu4e-sent-messages-behavior 'delete) -> If use with GMAIL!
  (mu4e-update-interval 300)
  (mu4e-use-fancy-chars t)
  (mu4e-view-show-addresses t)
  (mu4e-view-show-images t)
  (message-citation-line-format "\nOn %a, %d %b %Y at %R, %f wrote:\n")
  (message-citation-line-function 'message-insert-formatted-citation-line)
  :config
  (add-to-list 'mu4e-headers-actions '("org-contact-add" . mu4e-action-add-org-contact) t)
  (add-to-list 'mu4e-view-actions '("org-contact-add" . mu4e-action-add-org-contact) t)
  (add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t))

(use-package org-mu4e
  :ensure nil
  :custom
  (org-mu4e-convert-to-html t))

(use-package message
  :ensure nil
  :custom (send-mail-function 'smtpmail-send-it))

(use-package gnus-dired
  :defer t
  :bind
  (("M-s-a" . gnus-dired-attach))
  :custom (gnus-dired-mail-mode 'mu4e-user-agent)
  :hook (dired-mode . turn-on-gnus-dired-mode)
  :config
  ;; make the `gnus-dired-mail-buffers' function also work on
  ;; message-mode derived modes, such as mu4e-compose-mode
  (defun gnus-dired-mail-buffers ()
    "Return a list of active message buffers."
    (let (buffers)
      (save-current-buffer
        (dolist (buffer (buffer-list t))
          (set-buffer buffer)
          (when (and (derived-mode-p 'message-mode)
                  (null message-sent-message-via))
            (push (buffer-name buffer) buffers))))
      (nreverse buffers))))

;; (use-package mu4e-alert
;;   :after mu4e
;;   :hook ((after-init . mu4e-alert-enable-mode-line-display)
;;          (after-init . mu4e-alert-enable-notifications))
;;   :config (mu4e-alert-set-default-style 'libnotify))
