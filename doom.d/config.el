;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Abe Peters"
      user-mail-address "hey@abepeters.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-henna)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/sy/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq org-roam-directory "~/syStudy/slipbox")
(add-hook 'after-init-hook 'org-roam-mode)
(remove-hook 'find-file-hook #'+org-roam-open-buffer-maybe-h)

(add-to-list 'default-frame-alist '(fullscreen . maximized))
 (setq doom-font (font-spec :family "Iosevka" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Product Sans" :size 16)
      doom-big-font (font-spec :size 28 ))


 (setq global-vi-tilde-fringe-mode nil ) ; removes the tildas

(set-frame-parameter (selected-frame) 'alpha '(97 95)) ;sets tranparency
(add-to-list 'default-frame-alist '(alpha 97 95))

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      inhibit-compacting-font-caches t            ; When there are lots of glyphs, keep them in memory
      truncate-string-ellipsis "…")              ; Unicode ellispis are nicer than "...", and also save /precious/ space

(display-time-mode 1)                             ; Enable time in the mode-line
(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))                       ; On laptops it's nice to know how much power you have
(global-subword-mode 1)                           ; Iterate through CamelCase words
(setq-default line-spacing 5)
(remove-hook 'after-init-hook #'doom-modeline-mode)
(setq org-indent-indentation-per-level 4)

(setq org-startup-folded nil)
 (add-hook 'org-mode-hook 'visual-line-mode)
 (add-hook 'org-mode-hook 'olivetti-mode)
 (setq olivetti-body-width 85)
 ;(add-hook 'org-mode-hook 'org-sticky-header-mode)
 (add-hook 'org-mode-hook 'org-superstar-mode)
; (add-hook 'org-mode-hook 'mixed-pitch-mode)

 (setq org-hide-emphasis-markers t)
 (setq org-superstar-headline-bullets-list '(" " " " "-" "·" "-" "·"))
 (setq org-export-with-section-numbers nil)
 (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

 (setq org-emphasis-alist
  '(("*" (bold :slant italic :weight black :foreground "#1ABC9C" )) ; blue-green
    ("/" (italic :foreground "#F3CA40" ))
    ("_" (:underline t  )) ; light green
    ("=" (:foreground "#E74C3C")) ;red
    ("~" (:foreground "#53df83" )) ; lime green
    ("+" (:strike-through nil :foreground "#FFC300" )))) ;orange

(setq deft-extensions '("txt" "tex" "org"))
(setq deft-directory "~/sySync/slipbox/")
(setq deft-recursive t)
(global-set-key [f8] 'deft)

(defun org-make-olist (arg)
    (interactive "P")
    (let ((n (or arg 1)))
      (when (region-active-p)
        (setq n (count-lines (region-beginning)
                             (region-end)))
        (goto-char (region-beginning)))
      (dotimes (i n)
        (beginning-of-line)
        (insert (concat (number-to-string (1+ i)) ". "))
        (forward-line))))
(map! :leader
      :desc "Create a Numbered List"
      "C-|" #'org-make-olist )

(with-eval-after-load 'command-log-mode (setq clm/log-command-exceptions* (append clm/log-command-exceptions*
                                          '(evil-next-line
                                            evil-previous-line
                                            evil-forward-char
                                            mouse-set-point
                                            evil-backward-char))))

(add-hook 'markdown-mode-hook #'olivetti-mode)
(add-hook 'markdown-mode-hook #'visual-line-mode)

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(defun my-nov-font-setup ()
(face-remap-add-relative :family "Product Sans"
                         :size 26
                         :height 1.5))
(add-hook 'nov-mode-hook 'olivetti-mode)
(add-hook 'nov-mode-hook 'visual-line-mode)

(defun pulse-line (&rest _)
      "Pulse the current line."
      (pulse-momentary-highlight-one-line (point)))

(dolist (command '(scroll-up-command scroll-down-command
                   recenter-top-bottom other-window))
  (advice-add command :after #'pulse-line))

;; If you installed via MELPA
(require 'org-roam-bibtex)
(add-hook 'after-init-hook #'org-roam-bibtex-mode)

;; If you cloned the repository
(require 'org-roam-bibtex)
(add-hook 'after-init-hook #'org-roam-bibtex-mode)

;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;'(org-document-title ((t (:inherit default :weight bold :foreground "#eff0f1" :font "Product Sans" :underline nil))))
;'(org-level-1 ((t (:inherit default :foreground "#eff0f1" :font "Product Sans Bold" :height 1.33))))
;'(org-level-2 ((t (:inherit default :foreground "#eff0f1" :font "Product Sans" :height 1.25))))
;'(org-level-3 ((t (:inherit default :foreground "#eff0f1" :font "Product Sans Bold" :height 1.2))))
;'(org-level-4 ((t (:inherit default :foreground "#eff0f1" :font "Product Sans" :height 1.1))))
;'(org-level-5 ((t (:inherit default :foreground "#eff0f1" :font "Product Sans Bold" :height 1.0))))
;'(org-level-6 ((t (:inherit default :foreground "#eff0f1" :font "Product Sans" :height 1.0))))
;'(org-level-7 ((t (:inherit default :foreground "#eff0f1" :font "Product Sans" :height 1.0))))
;'(org-level-8 ((t (:inherit default :foreground "#eff0f1" :font "Product Sans" :height 1.0))))
;)

'(org-agenda-files nil)
'(org-indent-indentation-per-level 4)
'(org-pomodoro-long-break-frequency 4)
'(org-pomodoro-long-break-length 1)
'(org-pomodoro-short-break-length 1)
'(org-pomodoro-clock-break t)
'(org-pomodoro-length 24)
'(org-roam-bibtex-mode t)

(setq  bibtex-completion-bibliography "~/syStudy/slipbox/MyLibrary.bib"
       bibtex-completion-library-path "~/syStudy/slipbox"
       bibtex-completion-notes-path   "~/syStudy/slipbox/bib-notes.org"
      )
(setq reftex-default-bibliography   '"~/syStudy/slipbox/MyLibrary.bib")
(setq org-ref-bibliography-notes     "~/syStudy/slipbox/bib-notes.org"
      org-ref-default-bibliography '("~/syStudy/slipbox/MyLibrary.bib")
      org-ref-pdf-directory "~/syStudy/books")
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (start-process "open" "*open*" "open" fpath)))

(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.x?html?\\'" . "brave %s")
        ("\\.epub\\'" . "foliate \"%s\"")
        ("\\.epub::\\([0-9]+\\)\\'" . "foliate \"%s\" -p %1")
        ))

;(set-frame-parameter nil 'internal-border-width 50)

(with-eval-after-load "org-tree-slide"
  (define-key org-tree-slide-mode-map (kbd "<f9>") 'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<f10>") 'org-tree-slide-move-next-tree)
  )

(global-set-key (kbd "<f5>") #'org-pomodoro)
