(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine 'xetex)
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Zathura")
     (output-html "xdg-open")))
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes '(monokai))
 '(custom-safe-themes
   '("37c8c2817010e59734fe1f9302a7e6a2b5e8cc648cf6a6cc8b85f3bf17fececf" default))
 '(fringe-mode '(1 . 1) nil (fringe))
 '(global-auto-revert-mode t)
 '(menu-bar-mode nil)
 '(org-agenda-files '("~/2022sum.org" "~/环境水力学/material.org"))
 '(package-selected-packages '(exec-path-from-shell auctex company pyim))
 '(pyim-dicts
   '((:name "bigDict" :file "~/pyim-bigdict/pyim-bigdict.pyim")))
 '(scroll-bar-mode nil)
 '(send-mail-function 'mailclient-send-it)
 '(tab-width 8)
 '(tool-bar-mode nil)
 '(tool-bar-position 'top))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#242424" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 200 :width normal :foundry "GOOG" :family "Noto Mono")))))
(require 'pyim)
(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
(setq default-input-method "pyim")
;; (global-set-key (kbd "C-\\") 'toggle-input-method)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; solve evil-mode chinese input conflict
(defun evil-toggle-input-method ()
  "when toggle on input method, switch to evil-insert-state if possible.
when toggle off input method, switch to evil-normal-state if current state is evil-insert-state"
  (interactive)
  (if (not current-input-method)
      (if (not (string= evil-state "insert"))
          (evil-insert-state))
    (if (string= evil-state "insert")
        (evil-normal-state)))
  (toggle-input-method))
(global-set-key (kbd "C-\\") 'evil-toggle-input-method)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq debug-on-error t)
; stop creating ~ files
(setq make-backup-files nil) 

;; Load fancy-dabbrev.el:
(add-to-list 'load-path "~/.emacs.d/elpa/fancy-dabbrev/")
(let ((default-directory  "~/.emacs.d/elpa/fancy-dabbrev/"))
  (normal-top-level-add-subdirs-to-load-path))
(require 'fancy-dabbrev)

;; Enable fancy-dabbrev previews everywhere:
(global-fancy-dabbrev-mode)

;; Bind fancy-dabbrev-expand and fancy-dabbrev-backward to your keys of
;; choice, here "TAB" and "Shift+TAB":
(global-set-key (kbd "TAB") 'fancy-dabbrev-expand)
(global-set-key (kbd "<backtab>") 'fancy-dabbrev-backward)

;; If you want TAB to indent the line like it usually does when the cursor
;; is not next to an expandable word, use 'fancy-dabbrev-expand-or-indent
;; instead of `fancy-dabbrev-expand`:
(global-set-key (kbd "TAB") 'fancy-dabbrev-expand-or-indent)
(global-set-key (kbd "<backtab>") 'fancy-dabbrev-backward)

;; Let dabbrev searches ignore case and expansions preserve case:
(setq dabbrev-case-distinction nil)
(setq dabbrev-case-fold-search t)
(setq dabbrev-case-replace nil)

;; font for chinese charaters
(add-to-list 'load-path "~/.emacs.d/cnfonts")
(require 'cnfonts)
;; 让 cnfonts 在 Emacs 启动时自动生效。
(cnfonts-mode 1)
;; 添加两个字号增大缩小的快捷键
;; (define-key cnfonts-mode-map (kbd "C--") #'cnfonts-decrease-fontsize)
;; (define-key cnfonts-mode-map (kbd "C-=") #'cnfonts-increase-fontsize)
(setq cnfonts-profiles
    '("program" "org-mode" "read-book"))

;; Ser evil-mode
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;; Set line numbers
(global-display-line-numbers-mode)

;; Set C indent style
(setq c-default-style "linux"
      c-basic-offset 4)

;; Add monokai themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai' t)

;; Configuration for access recent edited files
(recentf-mode 1)
(defun ido-choose-from-recentf ()
  "Use ido to select a recently visited file from the `recentf-list'"
  (interactive)
  (find-file (ido-completing-read "Open file: " recentf-list nil t)))

;; bind it to "C-c f"
(global-set-key (kbd "C-c f") 'ido-choose-from-recentf)

;; make Emacs PATH identical with shell PATH (brute force way!)
(exec-path-from-shell-initialize)

;; out magic for latex files
(add-hook 'latex-mode-hook
          (lambda ()
            (outline-minor-mode 1)
            (setq-local outline-regexp "\\\\\\(sub\\)*section\\>")
            (setq-local outline-level (lambda () (- (outline-level) 7)))))
