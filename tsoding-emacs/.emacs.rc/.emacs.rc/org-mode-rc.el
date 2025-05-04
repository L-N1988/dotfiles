(global-set-key (kbd "C-x a") 'org-agenda)
(global-set-key (kbd "C-c C-x j") #'org-clock-jump-to-current-clock)
(add-hook 'org-mode-hook #'(visual-line-mode))

(defun insert-org-header ()
  "Insert Org mode title and author tags."
  (interactive)
  (insert "#+title: \n#+author: L-N1988\n")
  (previous-line 2)  ; Move cursor to title line
  (end-of-line))     ; Move cursor to end of title line

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c l") 'org-store-link)
  (define-key org-mode-map (kbd "C-c C-l") 'org-insert-link)
  ;; Bind to a key, e.g., C-c h
  (define-key org-mode-map (kbd "C-c h") 'insert-org-header)
  ;; Set Org block background to match Monokai's dark theme
  (set-face-attribute 'org-block nil 
                      :background "#181818"
                      :foreground "#F8F8F2")
  ;; Resize Org headings
  (dolist (face '((org-level-1 . 1.35)
                  (org-level-2 . 1.3)
                  (org-level-3 . 1.2)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "EB Garamond" :weight 'bold :height (cdr face)))
  ;; Make the document title a bit bigger
  (set-face-attribute 'org-document-title nil :font "LXGW Wen Kai" :weight 'bold :height 1.8)
  )

(setq org-startup-folded 'content)
(add-hook 'org-mode-hook
          (lambda ()
            (org-cycle '(4)))) ; Simulates TAB to fold all headings
(add-hook 'org-mode-hook
          (lambda ()
            (org-global-cycle 1))) ; Collapses everything
(setq org-hide-block-startup t)

(setq org-agenda-files (list "~/Documents/Agenda/"))

(setq org-export-backends '(md))

(defun clean-zotero-citations ()
  "Clean Zotero citations in the current buffer or region.
   Converts from ([Author, Year, p. XX](zotero://...)) to (Author, Year, p. XX)"
  (interactive)
  (let ((start (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max))))
    (save-excursion
      ;; Replace citation links
      (goto-char start)
      (while (re-search-forward "\\(\\[\\(.*?\\)\\](zotero://[^)]*?)\\)" end t)
        (replace-match "\\2" nil nil))
      
      ;; Remove PDF links
      (goto-char start)
      (while (re-search-forward " \\(\\[pdf\\](zotero://[^)]*?)\\)" end t)
        (replace-match "" nil nil)))))

;; Bind it to a key if desired
(global-set-key (kbd "C-c z") 'clean-zotero-citations)

(defun rc/org-increment-move-counter ()
  (interactive)

  (defun default (x d)
    (if x x d))

  (let* ((point (point))
         (move-counter-name "MOVE_COUNTER")
         (move-counter-value (-> (org-entry-get point move-counter-name)
                                 (default "0")
                                 (string-to-number)
                                 (1+))))
    (org-entry-put point move-counter-name
                   (number-to-string move-counter-value)))
  nil)

(defun rc/org-get-heading-name ()
  (nth 4 (org-heading-components)))

(defun rc/org-kill-heading-name-save ()
  (interactive)
  (let ((heading-name (rc/org-get-heading-name)))
    (kill-new heading-name)
    (message "Kill \"%s\"" heading-name)))

(global-set-key (kbd "C-x p w") 'rc/org-kill-heading-name-save)

(setq org-agenda-custom-commands
      '(("u" "Unscheduled" tags "+personal-SCHEDULED={.+}-DEADLINE={.+}/!+TODO"
         ((org-agenda-sorting-strategy '(priority-down))))
        ("p" "Personal" ((agenda "" ((org-agenda-tag-filter-preset (list "+personal"))))))
        ("w" "Work" ((agenda "" ((org-agenda-tag-filter-preset (list "+work"))))))
        ))

;;; org-cliplink

(rc/require 'org-cliplink)

(global-set-key (kbd "C-x p i") 'org-cliplink)

(defun rc/cliplink-task ()
  (interactive)
  (org-cliplink-retrieve-title
   (substring-no-properties (current-kill 0))
   '(lambda (url title)
      (insert (if title
                  (concat "* TODO " title
                          "\n  [[" url "][" title "]]")
                (concat "* TODO " url
                        "\n  [[" url "]]"))))))
(global-set-key (kbd "C-x p t") 'rc/cliplink-task)

;;; org-capture

(setq org-capture-templates
      '(("p" "Capture task" entry (file "~/Documents/Agenda/Tasks.org")
         "* TODO %?\n  SCHEDULED: %t\n")
        ("K" "Cliplink capture task" entry (file "~/Documents/Agenda/Tasks.org")
         "* TODO %(org-cliplink-capture) \n  SCHEDULED: %t\n" :empty-lines 1)))
(define-key global-map "\C-cc" 'org-capture)

;;; org-bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
