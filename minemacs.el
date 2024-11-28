(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(show-paren-mode 1)

(setq use-short-answers t)
(setq echo-keystrokes 0.1)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(when (require 'god-mode nil t)
  (god-mode))

;;; Keybind funcs
(defun duplicate-line ()
  "Duplicate the current line."
  (interactive)
  (save-excursion
    (let ((text (buffer-substring (line-beginning-position) (line-end-position))))
      (end-of-line)
      (insert "\n" text)
      (next-line))))

(defun duplicate-region-or-line ()
  "Duplicate the region if active, otherwise duplicate the current line."
  (interactive)
  (if (use-region-p)
      (progn
        (kill-ring-save (region-beginning) (region-end))
        (goto-char (region-end))
        (yank))
    (duplicate-line)))

(defun start-alacritty ()
  "Start Alacritty terminal and disown it."
  (interactive)
  (start-process "Alacritty" nil "alacritty"))

;; Enable Icomplete mode
(icomplete-mode 1)

;; Enable Icomplete vertical mode for a Vertico-like experience
(when (boundp 'icomplete-vertical-mode)
  (icomplete-vertical-mode 1))

;; Configure Icomplete settings
(setq icomplete-separator "\n"          ;; Use newlines to separate candidates
      icomplete-hide-common-prefix nil ;; Show the full list of candidates
      icomplete-prospects-height 10    ;; Number of candidates to show
      completion-cycle-threshold 3     ;; Enable cycling if more than 3 candidates
      read-file-name-completion-ignore-case t ;; Ignore case in file completion
      read-buffer-completion-ignore-case t)   ;; Ignore case in buffer completion

;;; Keybinds
;; Custom key bindings in pure Emacs Lisp
(global-unset-key (kbd "C-z")) ; Why the fuck is this in Emacs GUI
(global-set-key (kbd "C-c t a") #'ansi-term)
(global-set-key (kbd "C-c t s") #'eshell)
(global-set-key (kbd "C-c C-RET") #'start-alacritty)
(global-set-key (kbd "C-c C-<return>") #'start-alacritty)

(global-set-key (kbd "C-ß") #'toggle-input-method)
(global-set-key (kbd "C-c C-ß") #'set-input-method)

(global-set-key (kbd "C-.") #'undo)
(global-set-key (kbd "C-,") #'undo-redo)
(global-set-key (kbd "C-u") #'undo)
(global-set-key (kbd "M-u") #'undo-redo)
(global-set-key (kbd "C-ä") #'undo)
(global-set-key (kbd "C-ö") #'undo-redo)

(global-set-key (kbd "C-c r") #'replace-string)

(global-set-key (kbd "C-c C-d") #'duplicate-region-or-line)
(global-set-key (kbd "C-c C-z") #'run-python)

(global-set-key (kbd "C-q") #'compile)
(global-set-key (kbd "C-c g g") #'revert-buffer)
(global-set-key (kbd "C-c M-g") #'revert-buffer)

(global-set-key (kbd "C-+") #'text-scale-increase)
(global-set-key (kbd "C--") #'text-scale-decrease)

(global-set-key (kbd "C-c C-x") #'uncomment-region)
(global-set-key (kbd "C-c C-y") #'comment-region)

(global-set-key (kbd "C-c s x") (lambda () (interactive) (switch-to-buffer "*scratch*")))

(global-set-key (kbd "C-x w f") #'tear-off-window)

(global-set-key (kbd "C-M-SPC") #'other-window)
(global-set-key (kbd "C-x o") #'next-window-any-frame)
(global-set-key (kbd "C-x i") #'previous-window-any-frame)
(global-set-key (kbd "C-x <down>") #'next-window-any-frame)
(global-set-key (kbd "C-x <up>") #'previous-window-any-frame)
(global-set-key (kbd "C-x C-<down>") #'next-window-any-frame)
(global-set-key (kbd "C-x C-<up>") #'previous-window-any-frame)

(global-set-key (kbd "M-g") #'goto-line)

(global-set-key (kbd "C-f") #'forward-word)
(global-set-key (kbd "C-b") #'backward-word)

(global-set-key (kbd "C-o") #'newline-and-indent)
(global-set-key (kbd "C-n") #'open-line)
(global-set-key (kbd "C-c C-c") #'recenter-top-bottom)
(global-set-key (kbd "C-p") #'kill-line)
(global-set-key (kbd "M-p") #'kill-sentence)

(global-set-key (kbd "C-j") #'next-line)
(global-set-key (kbd "C-k") #'previous-line)
(global-set-key (kbd "C-l") #'forward-char)

(global-set-key (kbd "C-(") #'backward-paragraph)
(global-set-key (kbd "C-)") #'forward-paragraph)

(global-set-key (kbd "C-x C-h") #'previous-buffer)
(global-set-key (kbd "C-x C-l") #'next-buffer)

(global-set-key (kbd "C-d") #'delete-forward-char)

(global-set-key (kbd "C-x C-d") #'dired)
(global-set-key (kbd "C-x C-v") #'switch-to-buffer)

(global-set-key (kbd "<escape>") #'god-mode-all)
(global-set-key (kbd "C-z") #'god-mode-all)

;; Remap `C-h` to `backward-char`
(define-key key-translation-map [?\C-h] [?\C-h])
(global-set-key (kbd "C-#") help-map)
(global-unset-key (kbd "C-h"))
(global-set-key (kbd "C-h") #'backward-char)


;;; Theme in file
;; Disable default configuration
(setq inhibit-default-init t)

;; Define Gruvbox color palette
(let* ((gruvbox-bg "#282828")
       (gruvbox-fg "#ebdbb2")
       (gruvbox-dark1 "#3c3836")
       (gruvbox-dark2 "#504945")
       (gruvbox-gray "#928374")
       (gruvbox-light1 "#ebdbb2")
       (gruvbox-light2 "#d5c4a1")
       (gruvbox-bright_red "#fb4933")
       (gruvbox-bright_green "#b8bb26")
       (gruvbox-bright_yellow "#fabd2f")
       (gruvbox-bright_blue "#83a598")
       (gruvbox-bright_purple "#d3869b")
       (gruvbox-bright_aqua "#8ec07c")
       (gruvbox-bright_orange "#fe8019"))

  ;; Set faces for Gruvbox
  (set-face-attribute 'default nil :background gruvbox-bg :foreground gruvbox-fg)
  (set-face-attribute 'cursor nil :background gruvbox-light1)
  (set-face-attribute 'region nil :background gruvbox-dark2)
  (set-face-attribute 'mode-line nil :background gruvbox-dark1 :foreground gruvbox-light2)
  (set-face-attribute 'mode-line-inactive nil :background gruvbox-bg :foreground gruvbox-gray)
  (set-face-attribute 'fringe nil :background gruvbox-bg)
  (set-face-attribute 'minibuffer-prompt nil :foreground gruvbox-bright_yellow)
  (set-face-attribute 'font-lock-comment-face nil :foreground gruvbox-gray :slant 'italic)
  (set-face-attribute 'font-lock-function-name-face nil :foreground gruvbox-bright_blue)
  (set-face-attribute 'font-lock-keyword-face nil :foreground gruvbox-bright_red)
  (set-face-attribute 'font-lock-string-face nil :foreground gruvbox-bright_green)
  (set-face-attribute 'font-lock-type-face nil :foreground gruvbox-bright_aqua)
  (set-face-attribute 'font-lock-variable-name-face nil :foreground gruvbox-bright_orange)
  (set-face-attribute 'font-lock-constant-face nil :foreground gruvbox-bright_purple)
  (set-face-attribute 'font-lock-builtin-face nil :foreground gruvbox-bright_red))
