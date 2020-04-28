(define-key prelude-mode-map (kbd "s-r") nil) ;; instead C-c f
(define-key prelude-mode-map (kbd "M-s-r") 'crux-recentf-find-file)
(define-key prelude-mode-map (kbd "s-p") nil) ;; instead C-c p

(define-key prelude-mode-map (kbd "s-j") nil)
(define-key prelude-mode-map (kbd "M-s-j") 'crux-top-join-line)
(define-key prelude-mode-map (kbd "s-k") nil)
(define-key prelude-mode-map (kbd "M-s-k") 'crux-kill-whole-line)

(define-key prelude-mode-map (kbd "s-m") nil)
(define-key prelude-mode-map (kbd "s-m m") nil)
(define-key prelude-mode-map (kbd "M-s-m m") 'magit-status)
(define-key prelude-mode-map (kbd "s-m l") nil)
(define-key prelude-mode-map (kbd "M-s-m l") 'magit-log)
(define-key prelude-mode-map (kbd "s-m f") nil)
(define-key prelude-mode-map (kbd "M-s-m f") 'magit-log-buffer-file)
(define-key prelude-mode-map (kbd "s-m b") nil)
(define-key prelude-mode-map (kbd "M-s-m b") 'magit-blame)
(define-key prelude-mode-map (kbd "s-o") nil)
(define-key prelude-mode-map (kbd "M-s-o") 'crux-smart-open-line-above) ;; M-o normal open line
(define-key prelude-mode-map (kbd "C-c y") nil)

(global-set-key (kbd "s-w") nil) ;; ace-window
(global-set-key (kbd "s-.") nil) ;; avy goto word subword hh instead
(global-set-key (kbd "s-y") nil)
(global-set-key (kbd "M-s-y") 'browse-kill-ring)
;;  i u
;; clock in and out

(key-chord-define-global "hh" 'avy-goto-word-1) ;; First letter word
(key-chord-define-global "HH" 'crux-switch-to-previous-buffer)
(key-chord-define-global "GG" 'ace-window)
(key-chord-define-global "hf" 'avy-goto-char) ;; any char
(key-chord-define-global "hF" 'avy-goto-line) ;; any line
(key-chord-define-global "qq" 'avy-pop-mark) ;; pop back to last mark
(key-chord-define-global "kk" 'undo-tree-visualize)

;; Custom
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-M-SPC") 'easy-mark)
(global-set-key (kbd "C-x M-m") 'multi-term-dedicated-open)
