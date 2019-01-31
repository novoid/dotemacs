

;; enforce utf-8
;; from https://www.masteringemacs.org/article/working-coding-systems-unicode-emacs
;; http://ergoemacs.org/emacs/emacs_encoding_decoding_faq.html
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
  ;; better menu names
  (use-package uniquify
    :defer 3
    :config
    (setq uniquify-buffer-name-style 'forward))


  ;; use hippie to search and find buffers
  ;; I actually really don't like this b/c it expands *everything* as an html tag if 
  ;; accidentally pressed.  removing
  ;; (global-set-key (kbd "M-/") 'hippie-expand)
  (defun mwp-base-settings ()
    "For now, just turn on a bunch of key bindings and basic settings.
       In the future, maybe turn this into a minor mode the way Kaushal does. "

    ;; Highlight matching parentheses when the point is on them.
    (show-paren-mode 1)
  ;;;; show line and column number in mode line
    (setq column-number-mode t)
  ;;;; display line number in left column
    (linum-mode -1)
    ;; Highlight matching parentheses when the point is on them.

    ;; hsow buffer name in window title
    (when window-system
      (setq frame-title-format '(buffer-file-name "%f" ("%b")))
      (tooltip-mode -1)
      (blink-cursor-mode -1))


    ;; this is still really nice to have though.  Keeping
    (global-set-key (kbd "C-x C-b") 'ibuffer)

    ;; use regexes in search --this works but also ocmplicates. consider changing
    (global-set-key (kbd "C-s") 'isearch-forward-regexp)
    (global-set-key (kbd "C-r") 'isearch-backward-regexp)
    (global-set-key (kbd "C-M-s") 'isearch-forward)
    (global-set-key (kbd "C-M-r") 'isearch-backward)

    (setq-default indent-tabs-mode nil)
    (setq x-select-enable-clipboard t
          x-select-enable-primary t
          ;; one-line fix for disappearing clipboard entries 
          ;; Often I copy something in Firefox and then go to emacs, but in between I kill some text. Then when I want to
          ;;paste/yank in the ff text, it's gone and I have to recopy.  This one-line setting fixes that:
          save-interprogram-paste-before-kill t
          apropos-do-all t
          ;; this next one sometimes fucks me up, consider changing
          mouse-yank-at-point t
          save-place-file (concat user-emacs-directory "places")
          ;; backup-directory-alist `(("." . ,(concat user-emacs-directory
          ;;                                          "backups")))
          )

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; this stuff is from magnar
    ;; Move files to trash when deleting

    (setq delete-by-moving-to-trash t)


    ;; Also auto refresh dired, but be quiet about it
    (setq global-auto-revert-non-file-buffers t)
    (setq auto-revert-verbose nil)
    ;; Real emacs knights don't use shift to mark things
    ;; this is bs, commenting out
    ;; (setq shift-select-mode nil)
    (setq org-support-shift-select t)

    ;; Answering just 'y' or 'n' will do
    (defalias 'yes-or-no-p 'y-or-n-p)
    ;; UTF-8 please
    (setq locale-coding-system 'utf-8-emacs) ; pretty
    (set-terminal-coding-system 'utf-8-emacs) ; pretty
    (set-keyboard-coding-system 'utf-8-emacs) ; pretty
    (set-selection-coding-system 'utf-8-emacs) ; please
    (prefer-coding-system 'utf-8-emacs) ; with sugar on top
    
    ;; I don't know what this means
    ;; Don't highlight matches with jump-char - it's distracting

    ;; (setq jump-char-lazy-highlight-face nil)

    ;; Lines should be 80 characters wide, not 72
    (setq fill-column 80)
    ;; Save minibuffer history
    (savehist-mode 1)
    (setq history-length 1400)

    ;; Undo/redo window configuration with C-c <left>/<right>
    ;; worth coming back to this & rationalizing window management
    ;; commented out for now
    ;; (winner-mode 1)

    ;; Never insert tabs
    (set-default 'indent-tabs-mode nil)

    ;; Show me empty lines after buffer end
    (set-default 'indicate-empty-lines t)

    ;; Show active region
    (transient-mark-mode 1)
    (make-variable-buffer-local 'transient-mark-mode)
    (put 'transient-mark-mode 'permanent-local t)
    (setq-default transient-mark-mode t)


    )

  (mwp-base-settings)

  ;; Auto refresh buffers
  (global-auto-revert-mode 1)

  ;; Transparently open compressed files
  (auto-compression-mode t)

  ;; Enable syntax highlighting for older Emacsen that have it off
  (global-font-lock-mode t)


  ;; Save a list of recent files visited. (open recent file with C-x f)
  (use-package recentf
    :config

    (setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
    (recentf-mode 1)
    (global-set-key "\C-x\ \C-r" 'recentf-open-files)
    (setq recentf-max-saved-items 200) ;; just 20 is too recent
    )


  ;; Easily navigate sillycased words
  ;; (global-subword-mode 1)
  (defvar subword-mode nil)
  ;; Don't break lines for me, please
  (setq-default truncate-lines t)

  ;; Keep cursor away from edges when scrolling up/down
  ;; (require 'smooth-scrolling)

  ;; Allow recursive minibuffers
  (setq enable-recursive-minibuffers t)

  ;; Don't be so stingy on the memory, we have lots now. It's the distant future.
  (setq gc-cons-threshold 20000000)


  ;; Fontify org-mode code blocks
  (setq org-src-fontify-natively t)

  ;; Represent undo-history as an actual tree (visualize with C-x u)
  (setq undo-tree-mode-lighter "")
  (require 'undo-tree)
  (global-undo-tree-mode)

  ;; Sentences do not need double spaces to end. Period.
  (set-default 'sentence-end-double-space nil)


  ;; A saner ediff
  (setq ediff-diff-options "-w")
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)

  ;; Nic says eval-expression-print-level needs to be set to nil (turned off) so
  ;; that you can always see what's happening.
  (setq eval-expression-print-level nil)

  ;; When popping the mark, continue popping until the cursor actually moves
  ;; Also, if the last command was a copy - skip past all the expand-region cruft.
  ;; I don't understand al lthisstuff and it may becausing problems, worth figuring out.

  ;; new versions fromKaushal, maybe better:
      ;;;; Popping marks
  ;; http://endlessparentheses.com/faster-pop-to-mark-command.html
  ;; https://github.com/magnars/expand-region.el/issues/159#issuecomment-83538021
  (defun modi/multi-pop-to-mark (orig-fun &rest args)
    "When popping the mark, continue popping until the cursor actually moves.
      Try the repeated popping up to 10 times."
    (let ((p (point)))
      (dotimes (i 10)
        (when (= p (point))
          (apply orig-fun args)))))
  (advice-add 'pop-to-mark-command :around #'modi/multi-pop-to-mark)

  ;; Ensure that we can quickly pop the mark several times by typing
  ;; C-u C-SPC C-SPC, instead of having to type C-u C-SPC C-u C-SPC.
  (setq set-mark-command-repeat-pop t)

;; (require) your ELPA packages, configure them as normal

;; C-= to expand selection by semantic unit
;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :commands er/expand-region)

;; replaced below with the fantastic iedit-mode, much more powerful.
;;(use-package highlight-symbol )

;; essential for all html exports
(use-package htmlize
  :commands (htmlize-region htmlize-buffer htmlize-file htmlize-many-files htmlize-many-files-dired))


;; I don't actually use this much
;; and it appears ot cause errors, so squashing for now!
;; (use-package markdown-mode )
;; multiple cursors extras
;; not using right now
;; (use-package mc-extras )


;; this has become super important -- allows me to go back to any previous state of buffer
(use-package undo-tree
  :commands undo-tree-visualize)


;; modern replacement for flymake
;; flycheck is dependent on external tools. Not set up properly yet
;; http://www.flycheck.org/manual/latest/Quickstart.html#Quickstart
;; This really needs its own lesson, it's fantastic!
(use-package flycheck
  :hook
  (after-init . global-flycheck-mode))
;; (add-hook 'after-init-hook #'global-flycheck-mode)

;; automatically indenting yanked text if in programming-modes
(use-package dash
  :config 
  (defvar yank-indent-modes '(prog-mode
                              sgml-mode
                              js2-mode)
    "Modes in which to indent regions that are yanked (or yank-popped)")

  (defvar yank-advised-indent-threshold 1000
    "Threshold (# chars) over which indentation does not automatically occur.")

  (defun yank-advised-indent-function (beg end)
    "Do indentation, as long as the region isn't too large."
    (if (<= (- end beg) yank-advised-indent-threshold)
        (indent-region beg end nil)))

  (defadvice yank (after yank-indent activate)
    "If current mode is one of 'yank-indent-modes, indent yanked text (with prefix arg don't indent)."
    (if (and (not (ad-get-arg 0))
             (--any? (derived-mode-p it) yank-indent-modes))
        (let ((transient-mark-mode nil))
          (yank-advised-indent-function (region-beginning) (region-end)))))

  (defadvice yank-pop (after yank-pop-indent activate)
    "If current mode is one of 'yank-indent-modes, indent yanked text (with prefix arg don't indent)."
    (if (and (not (ad-get-arg 0))
             (member major-mode yank-indent-modes))
        (let ((transient-mark-mode nil))
          (yank-advised-indent-function (region-beginning) (region-end)))))

  (defun yank-unindented ()
    (interactive)
    (yank 1)))

;; kill region if active, otherwise kill backward word

(defun kill-region-or-backward-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

(defun kill-to-beginning-of-line ()
  (interactive)
  (kill-region (save-excursion (beginning-of-line) (point))
               (point)))

;; copy region if active
;; otherwise copy to end of current line
;;   * with prefix, copy N whole lines

(defun copy-to-end-of-line ()
  (interactive)
  (kill-ring-save (point)
                  (line-end-position))
  (message "Copied to end of line"))

(defun copy-whole-lines (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(defun copy-line (arg)
  "Copy to end of line, or as many lines as prefix argument"
  (interactive "P")
  (if (null arg)
      (copy-to-end-of-line)
    (copy-whole-lines (prefix-numeric-value arg))))

(defun save-region-or-current-line (arg)
  (interactive "P")
  (if (region-active-p)
      (kill-ring-save (region-beginning) (region-end))
    (copy-line arg)))

(defun kill-and-retry-line ()
  "Kill the entire current line and reposition point at indentation"
  (interactive)
  (back-to-indentation)
  (kill-line))

;;; editing-defuns.el --- Basic text editing defuns -*- lexical-binding: t; -*-

(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(defun new-line-in-between ()
  (interactive)
  (newline)
  (save-excursion
    (newline)
    (indent-for-tab-command))
  (indent-for-tab-command))

(defun new-line-dwim ()
  (interactive)
  (let ((break-open-pair (or (and (looking-back "{" 1) (looking-at "}"))
                             (and (looking-back ">" 1) (looking-at "<"))
                             (and (looking-back "(" 1) (looking-at ")"))
                             (and (looking-back "\\[" 1) (looking-at "\\]")))))
    (newline)
    (when break-open-pair
      (save-excursion
        (newline)
        (indent-for-tab-command)))
    (indent-for-tab-command)))

(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated."
  (interactive "p")
  (if (region-active-p)
      (let ((beg (region-beginning))
            (end (region-end)))
        (duplicate-region arg beg end)
        (one-shot-keybinding "d" (lambda (duplicate-region 1 beg end))))
    (duplicate-current-line arg)
    (one-shot-keybinding "d" 'duplicate-current-line)))

(defun replace-region-by (fn)
  (let* ((beg (region-beginning))
         (end (region-end))
         (contents (buffer-substring beg end)))
    (delete-region beg end)
    (insert (funcall fn contents))))

(defun duplicate-region (&optional num start end)
  "Duplicates the region bounded by START and END NUM times.
If no START and END is provided, the current region-beginning and
region-end is used."
  (interactive "p")
  (save-excursion
   (let* ((start (or start (region-beginning)))
          (end (or end (region-end)))
          (region (buffer-substring start end)))
     (goto-char end)
     (dotimes (i num)
       (insert region)))))

(defun duplicate-current-line (&optional num)
  "Duplicate the current line NUM times."
  (interactive "p")
  (save-excursion
   (when (eq (point-at-eol) (point-max))
     (goto-char (point-max))
     (newline)
     (forward-char -1))
   (duplicate-region num (point-at-bol) (1+ (point-at-eol)))))

;; toggle quotes

(defun current-quotes-char ()
  (nth 3 (syntax-ppss)))

(defalias 'point-is-in-string-p 'current-quotes-char)

(defun move-point-forward-out-of-string ()
  (while (point-is-in-string-p) (forward-char)))

(defun move-point-backward-out-of-string ()
  (while (point-is-in-string-p) (backward-char)))

(defun alternate-quotes-char ()
  (if (eq ?' (current-quotes-char)) ?\" ?'))

(defun toggle-quotes ()
  (interactive)
  (if (point-is-in-string-p)
      (let ((old-quotes (char-to-string (current-quotes-char)))
            (new-quotes (char-to-string (alternate-quotes-char)))
            (start (make-marker))
            (end (make-marker)))
        (save-excursion
          (move-point-forward-out-of-string)
          (backward-delete-char 1)
          (set-marker end (point))
          (insert new-quotes)
          (move-point-backward-out-of-string)
          (delete-char 1)
          (insert new-quotes)
          (set-marker start (point))
          (replace-string new-quotes (concat "\\" new-quotes) nil start end)
          (replace-string (concat "\\" old-quotes) old-quotes nil start end)))
    (error "Point isn't in a string")))


(defun camelize-buffer ()
  (interactive)
  (goto-char 0)
  (ignore-errors
    (replace-next-underscore-with-camel 0))
  (goto-char 0))

;; kill all comments in buffer
(defun comment-kill-all ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (comment-kill (save-excursion
                    (goto-char (point-max))
                    (line-number-at-pos)))))

(require 's)

(defun incs (s &optional num)
  (let* ((inc (or num 1))
         (new-number (number-to-string (+ inc (string-to-number s))))
         (zero-padded? (s-starts-with? "0" s)))
    (if zero-padded?
        (s-pad-left (length s) "0" new-number)
      new-number)))

(defun change-number-at-point (arg)
  (interactive "p")
  (unless (or (looking-at "[0-9]")
              (looking-back "[0-9]"))
    (error "No number to change at point"))
  (save-excursion
    (while (looking-back "[0-9]")
      (forward-char -1))
    (re-search-forward "[0-9]+" nil)
    (replace-match (incs (match-string 0) arg) nil nil)))

(defun subtract-number-at-point (arg)
  (interactive "p")
  (change-number-at-point (- arg)))

(defun replace-next-underscore-with-camel (arg)
  (interactive "p")
  (if (> arg 0)
      (setq arg (1+ arg))) ; 1-based index to get eternal loop with 0
  (let ((case-fold-search nil))
    (while (not (= arg 1))
      (search-forward-regexp "\\b_[a-z]")
      (forward-char -2)
      (delete-char 1)
      (capitalize-word 1)
      (setq arg (1- arg)))))

(defun snakeify-current-word ()
  (interactive)
  (er/mark-word)
  (let* ((beg (region-beginning))
         (end (region-end))
         (current-word (buffer-substring-no-properties beg end))
         (snakified (snake-case current-word)))
    (replace-string current-word snakified nil beg end)))

(defun transpose-params ()
  "Presumes that params are in the form (p, p, p) or {p, p, p} or [p, p, p]"
  (interactive)
  (let* ((end-of-first (cond
                        ((looking-at ", ") (point))
                        ((and (looking-back ",") (looking-at " ")) (- (point) 1))
                        ((looking-back ", ") (- (point) 2))
                        (t (error "Place point between params to transpose."))))
         (start-of-first (save-excursion
                           (goto-char end-of-first)
                           (move-backward-out-of-param)
                           (point)))
         (start-of-last (+ end-of-first 2))
         (end-of-last (save-excursion
                        (goto-char start-of-last)
                        (move-forward-out-of-param)
                        (point))))
    (transpose-regions start-of-first end-of-first start-of-last end-of-last)))

(defun move-forward-out-of-param ()
  (while (not (looking-at ")\\|, \\| ?}\\| ?\\]"))
    (cond
     ((point-is-in-string-p) (move-point-forward-out-of-string))
     ((looking-at "(\\|{\\|\\[") (forward-list))
     (t (forward-char)))))

(defun move-backward-out-of-param ()
  (while (not (looking-back "(\\|, \\|{ ?\\|\\[ ?"))
    (cond
     ((point-is-in-string-p) (move-point-backward-out-of-string))
     ((looking-back ")\\|}\\|\\]") (backward-list))
     (t (backward-char)))))

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.")

(defun css-expand-statement ()
  (interactive)
  (save-excursion
    (end-of-line)
    (search-backward "{")
    (forward-char 1)
    (let ((beg (point)))
      (newline)
      (er/mark-inside-pairs)
      (replace-regexp ";" ";\n" nil (region-beginning) (region-end))
      (indent-region beg (point)))))

(defun css-contract-statement ()
  (interactive)
  (end-of-line)
  (search-backward "{")
  (while (not (looking-at "}"))
    (join-line -1))
  (back-to-indentation))

;; Defuns for working with files

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(defun copy-current-file-path ()
  "Add current file path to kill ring. Limits the filename to project root if possible."
  (interactive)
  (let ((filename (buffer-file-name)))
    (kill-new (if eproject-mode
                  (s-chop-prefix (eproject-root) filename)
                filename))))

(defun find-or-create-file-at-point ()
  "Guesses what parts of the buffer under point is a file name and opens it."
  (interactive)
  (find-file (file-name-at-point)))

(defun find-or-create-file-at-point-other-window ()
  "Guesses what parts of the buffer under point is a file name and opens it."
  (interactive)
  (find-file-other-window (file-name-at-point)))

(defun file-name-at-point ()
  (save-excursion
    (let* ((file-name-regexp "[./a-zA-Z0-9\-_~]")
           (start (progn
                    (while (looking-back file-name-regexp)
                      (forward-char -1))
                    (point)))
           (end (progn
                  (while (looking-at file-name-regexp)
                    (forward-char 1))
                  (point))))
      (buffer-substring start end))))

(defun touch-buffer-file ()
  (interactive)
  (insert " ")
  (backward-delete-char 1)
  (save-buffer))

;; more of magnar's defuns and modes

;; not using yet, too hard
(use-package mc-extras
  :commands (mc/rect-rectangle-to-multiple-cursors multiple-cursors-mode)
  )
;; https://www.emacswiki.org/emacs/delsel.el
;; allows delete to be used to kill selection
(use-package delsel
:ensure t
:config
(delete-selection-mode 1))

;; (require) your ELPA packages, configure them as normal

;; C-= to expand selection by semantic unit
;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :commands er/expand-region)

;; replaced below with the fantastic iedit-mode, much more powerful.
;;(use-package highlight-symbol )

;; essential for all html exports
(use-package htmlize
  :commands (htmlize-region htmlize-buffer htmlize-file htmlize-many-files htmlize-many-files-dired))


;; I don't actually use this much
;; and it appears ot cause errors, so squashing for now!
;; (use-package markdown-mode )
;; multiple cursors extras
;; not using right now
;; (use-package mc-extras )



;; this has become super important -- allows me to go back to any previous state of buffer
(use-package undo-tree
  :commands undo-tree-visualize)


;; modern replacement for flymake
;; flycheck is dependent on external tools. Not set up properly yet
;; http://www.flycheck.org/manual/latest/Quickstart.html#Quickstart
;; This really needs its own lesson, it's fantastic!
(use-package flycheck
  :hook
  (after-init . global-flycheck-mode))
;; (add-hook 'after-init-hook #'global-flycheck-mode)

;;;; js2-mode
;; js stuff
(use-package js2-mode
  :commands js2-mode
  :mode  "\\.js\\'"
  :config
  (use-package jquery-doc)
  (require 'js-doc)
  (add-hook 'js2-mode-hook
            #'(lambda ()
                (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
                (define-key js2-mode-map "@" 'js-doc-insert-tag)))
  (define-key js2-mode-map (kbd "C-RET") 'js2-line-break)
  (setq js-doc-mail-address "matt.price@utoronto.ca")
  (setq  js-doc-author (format "Matt Price <%s>" js-doc-mail-address))
  (setq   js-doc-url "matt.hackinghistory.ca")
  (setq   js-doc-license "GPL 3.0")
  (add-hook 'js2-mode-hook
      (defun my-js2-mode-setup ()
        (flycheck-mode t)
        (when (executable-find "eslint")
          (flycheck-select-checker 'javascript-eslint))))
  (require 'eslintd-fix)
  (add-hook 'js2-mode-hook 'eslintd-fix-mode)
)

(use-package json-mode )

;; (use-package tide
;;   :ensure t
;;   :after (typescript-mode company flycheck)
;;   :hook ((typescript-mode . tide-setup)
;;          (js2-mode . tide-setup)
;;          (typescript-mode . tide-hl-identifier-mode)
;;          (before-save . tide-format-before-save)
;;          ))

(use-package company-tern
  :ensure t
  :after company 
  :config
  (add-to-list 'company-backends 'company-tern)
  ;; (setq company-tern-property-marker " <p>")
  ;; (setq company-tern-meta-as-single-line t)
  )

(use-package lsp-mode
  :commands lsp
  :config
(require 'lsp-clients)
(setq lsp-auto-guess-root t)
(add-hook 'js2-mode-hook 'lsp)
  )

(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

;; (use-package  lsp-javascript-typescript
;;   :config
;;   (defun my-company-transformer (candidates)
;;     (let ((completion-ignore-case t))
;;       (all-completions (company-grab-symbol) candidates)))

;;   (defun my-js-hook nil
;;     (make-local-variable 'company-transformers)
;;     (push 'my-company-transformer company-transformers))

;;   (add-hook 'js-mode-hook 'my-js-hook)
;;   (add-hook 'js2-mode-hook #'lsp-javascript-typescript-enable)
;;   (add-hook 'typescript-mode-hook #'lsp-javascript-typescript-enable) ;; for typescript support
;;   (add-hook 'js3-mode-hook #'lsp-javascript-typescript-enable) ;; for js3-mode support
;;   ;; (add-hook 'json-mode-hook #'lsp-javascript-typescript-disable) ;;this breaks json mode which is already so slow!!
;;   (add-hook 'rjsx-mode #'lsp-javascript-typescript-enable)) ;; for rjsx-mode support

(use-package lsp-html
:config
(add-hook 'html-mode-hook #'lsp))

;; (use-package lsp-css
;;   :config
;;   (defun my-css-mode-setup ()
;;     (when (eq major-mode 'css-mode)
;;       ;; Only enable in strictly css-mode, not scss-mode (css-mode-hook
;;       ;; fires for scss-mode because scss-mode is derived from css-mode)
;;       (lsp-css-enable)))
;;   ;; (add-hook 'css-mode-hook #'my-css-mode-setup)
  ;; (add-hook 'less-mode-hook #'lsp-less-enable)
  ;; (add-hook 'sass-mode-hook #'lsp-scss-enable)
  ;; (add-hook 'scss-mode-hook #'lsp-scss-enable)
;;  )

(add-hook 'less-mode-hook #'lsp)
(add-hook 'sass-mode-hook #'lsp)
(add-hook 'scss-mode-hook #'lsp)

(setq-default bidi-display-reordering nil)
(use-package so-long
  ;; no config or anything yet, still getting used to this
  :load-path "~/src/solong"
  :pin manual)
(use-package bln-mode
  :after hydra
  :hook
  (so-long-mode . bln-mode)
  :config
  (defhydra hydra-bln ()      "Binary line navigation mode"
    ("j" bln-backward-half "Backward in line")
    ("k" bln-forward-half "Forward in line")
    ("u" bln-backward-half-v "Backward in window")
    ("i" bln-forward-half-v "Forward in window")
    ("h" bln-backward-half-b "Backward in buffer")
    ("l" bln-forward-half-b "Forward in buffer"))
  (define-key bln-mode-map (kbd "M-j") 'hydra-bln/body))

(use-package exec-path-from-shell
:ensure t
    :config
    (when (memq window-system '(mac ns x))
      (exec-path-from-shell-initialize)))

  (use-package indium
    :ensure t
    :config
    ;;(indium-launch-node)
(add-hook 'js-mode-hook #'indium-interaction-mode))

(use-package mocha
:ensure t
)

(use-package impatient-mode
      :commands impatient-mode
      :hook
      ((html-mode . impatient-mode)
       (css-mode . impatient-mode)
       (mhtml-mode . impatient-mode)
       (js2-mode . impatient-mode)
       (web-mode . impatient-mode)
       )
      :config
      (setq imp-default-user-filters
            '((html-mode . nil)
              (web-mode . nil)
              (mhtml-mode . nil)))
      (httpd-start)

      ;; (browse-url "http://localhost:8888/imp/")
)

(use-package emmet-mode
    :commands emmet-mode
    :init
    (add-hook 'css-mode-hook 'emmet-mode)
    (add-hook 'sgml-mode-hook 'emmet-mode)
    :config
    (setq-default emmet-move-cursor-between-quote t)
    (unbind-key "<C-return>" emmet-mode-keymap)

    ;; (unbind-key "C-M-<left>" emmet-mode-keymap)
    ;; (unbind-key "C-M-<right>" emmet-mode-keymap)
    )

;; (use-package hippie-exp
;;   :ensure nil
;;   :defer t
;;   :bind ("<C-return>" . hippie-expand)
;;   :config
;;   (setq-default hippie-expand-try-functions-list
;;                 '(yas-hippie-try-expand emmet-expand-line)))
(use-package yasnippet
  :defer t
  :init
  (add-hook 'js-mode-hook 'yas-minor-mode)
  (add-hook 'sgml-mode-hook 'yas-minor-mode)
  :config
  (setq-default yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-reload-all)
  (define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)

  ;; (unbind-key "TAB" yas-minor-mode-map)
  ;; (unbind-key "<tab>" yas-minor-mode-map)
  )

;; don't use this much but it can be helpufl. Unfortunately it's not possible to set .jsbeautifyrc 
    ;; clobally so tthat restricts the value a bit.
    (use-package web-beautify
      :commands (web-beautify-html web-beautify-js web-beautify-css))
    ;; I seem to be using mhtml-mode now, so getting rid of this now

    ;; returning to web-mode for now. 
    (use-package web-mode

      :mode ("\\.html\\'" "\\.php\\'")
      :bind (:map web-mode-map ("C-c C-v" . browse-url-of-buffer
      ))
)


  (use-package emmet-mode
    :after web-mode
    :hook
    (web-mode . emmet-mode)
    (sgml-mode . emmet-mode)
    (css-mode . emmet-mode)
    (sass-mode . emmet-mode)
    )

    ;; (use-package company-web-html)                          ; load company mode html backend
    ;; (eval-after-load 'company-etags
    ;;   '(progn
    ;;      (add-to-list 'company-etags-modes 'js2-mode)
    ;;      (add-to-list 'company-etags-modes 'web-mode)))

(use-package company
  :ensure t
  :after emojify
      ;;:commands (global-company-mode company-mode)
      ;; :hook
      ;;(after-init . 'global-company-mode)
      :config
      (global-company-mode)
      ;; (setq company-tooltip-limit 20)                      ; bigger popup window
      ;; (setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
      ;; (setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
      ;; (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing -- this scres me up, ocmmenging out
      ;;(global-set-key (kbd "C-c /") 'company-files)        ; Force complete file names on "C-c /" key
        (defun mwp-dont-insert-unicode-emoji ()
          (make-local-variable 'company-emoji-insert-unicode)
          (setq company-emoji-insert-unicode nil))
      ;;   :after (emojify company)
      ;;   :hook
        (add-hook 'org-mode-hook  'mwp-dont-insert-unicode-emoji)
        (add-hook 'markdown-mode-hook  'mwp-dont-insert-unicode-emoji)
        (add-hook 'gfm-mode-hook  'mwp-dont-insert-unicode-emoji)
        (add-hook 'git-commit-mode-hook  'mwp-dont-insert-unicode-emoji)
        (add-to-list 'company-backends 'company-emoji)
      ;;   (markdown-mode . mwp-dont-insert-unicode-emoji)
      ;;   (gfm-mode . mwp-dont-insert-unicode-emoji)
      ;;   (git-commit-mode . mwp-dont-insert-unicode-emoji)
      ;;   :config
      ;;   (add-to-list 'company-backends 'company-emoji)
          )

  (use-package company-quickhelp
        :ensure t
        :after company
        :init 

        :config
        (company-quickhelp-mode)
        :custom
        (company-quickhelp-color-background "#b0b0b0")
        (company-quickhelp-color-foreground "#232333")

  )
    ;; (use-package company-web-html
    ;;   :after company
    ;;   :bind
    ;;   (("C-'" . company-web-html)
    ;;   ("C-c C-/" . company-files)
    ;;   )
    ;;   :config
    ;;   ;; not sure I should keep these, which are taken from
    ;;   ;; https://github.com/osv/company-web and was written at least a year ago
    ;;   ;;  ;; (setq company-minimum-prefix-length 0)            ; WARNING, probably you will get perfomance issue if min len is 0!

    ;;   )

;;;; auto spell correct! much better!
  ;; this has been a godsend
  (defun endless/ispell-word-then-abbrev (p)
    "Call `ispell-word'. Then create an abbrev for the correction made.
    With prefix P, create global abbrev. Otherwise it will be local."
    (interactive "P")
    (let ((bef (downcase (or (thing-at-point 'word) ""))) aft)
      (call-interactively 'ispell-word)
      (setq aft (downcase (or (thing-at-point 'word) "")))
      (unless (string= aft bef)
        (message "\"%s\" now expands to \"%s\" %sally "
                 bef aft (if p "glob" "loc" ))
        (define-abbrev
          (if p global-abbrev-table local-abbrev-table)
          bef aft)))
    (write-abbrev-file))
;;;; abbrev-mode
(use-package abbrev-mode
  :init
  (setq-default abbrev-mode t)
  ;; a hook funtion that sets the abbrev-table to org-mode-abbrev-table
  ;; whenever the major mode is a text mode
  (defun mwp-set-text-mode-abbrev-table ()
    (if (derived-mode-p 'text-mode)
        (setq local-abbrev-table org-mode-abbrev-table)))
  (add-hook 'abbrev-mode-hook #'mwp-set-text-mode-abbrev-table)

  :commands abbrev-mode
  ;; :hook
  ;; (abbrev-mode . mwp-set-text-mode-abbrev-table)
  :config
  ;; (setq default-abbrev-mode t)
  (setq abbrev-file-name "~/.emacs.d/abbrev_defs")
  (read-abbrev-file "~/.emacs.d/abbrev_defs")       ;; reads the abbreviations file on startup
  (setq save-abbrevs 'silently)              ;; now I won't be asked


  )

(let ((org-tempo-keywords-alist nil))
(use-package org-tempo
  :after (org)
  :load-path "/home/matt/src/org-mode/emacs/site-lisp/org"
  :preface 
  (setq org-tempo-keywords-alist nil)
  (customize-set-variable 'org-structure-template-alist '(("a" . "export ascii")
                                       ;; ("c" . "center")
                                       ("C" . "comment")
                                       ("E" . "example")
                                       ("e" . "src emacs-lisp")
                                       ("H" . "export html")
                                       ("l" . "export latex")
                                       ("q" . "quote")
                                       ("s" . "src")
                                       ("v" . "verse")
                                       ("i" . "index")
                                       ("j" . "src js")
                                       ("c" . "src css")
                                       ("n" . "notes")
                                       ("h" . "src html")))
  :init
  (setq org-tempo-keywords-alist nil)

  :config
  ;; (setq org-tempo-keywords-alist '(("L" . "latex")
  ;;                                  ("H" . "html")
  ;;                                  ("A" . "ascii")
  ;;                                  ("i" . "index")
  ;;                                  ("j" . "src js")
  ;;                                  ("c" . "src css")
  ;;                                  ("" . "src emacs-lisp")
  ;;                                  ("h" . "src html")))
  ))

;;

;; paredit stuff.  belongs in setup-paredit, oh well
  ;; difficult but cool
(use-package paredit
  :hook
  ((emacs-lisp-mode . enable-paredit-mode)
   (eval-expression-minibuffer-setup . enable-paredit-mode)
   (ielm-mode . enable-paredit-mode)
   (lisp-mode . enable-paredit-mode)
   (lisp-interaction-mode . enable-paredit-mode)
   (scheme-mode . enable-paredit-mode))
  :config
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  :bind
    (:map paredit-mode-map
    ("M-s" . nil)
    ("M-s s" . paredit-splice-sexp)))

(defun paredit-or-smartparens ()
      "Enable either paredit or smartparens strict mode."
      (if (member major-mode '(emacs-lisp-mode
                               lisp-interaction-mode
                               lisp-mode
                               scheme-mode
                               eval-expression-minibuffer-setup))
          (enable-paredit-mode)
        (smartparens-mode)))

    (add-hook 'prog-mode-hook #'paredit-or-smartparens)
    (add-hook 'text-mode-hook #'electric-pair-local-mode
   )
;; (add-hook 'org-mode-hook #'smartparens-mode)

  (use-package elec-pair
    :config
    (defun mwp-org-mode-electric-inhibit (c)
      (and
       (or (eq ?\< c) (eq ?\[ c ))
       (eq major-mode 'org-mode)))
    (advice-add electric-pair-inhibit-predicate :before-until #'mwp-org-mode-electric-inhibit))




    ;;(remove-hook 'org-mode-hook (lambda () (electric-pair-local-mode -1)))
    (use-package smartparens
      :bind
      (:map smartparens-mode-map
      ("M-s" . nil)
      ("M-s s" . sp-splice-sexp))

      :config
      (require 'smartparens-config)
      (require 'smartparens-javascript)
      (require 'smartparens-org)
      (sp-use-paredit-bindings)
      ;; I don't quite understand this one
      (with-no-warnings
        (defun sp-paredit-like-close-round ()
          "If the next character is a closing character as according to smartparens skip it, otherwise insert `last-input-event'"
          (interactive)
          (let ((pt (point)))
            (if (and (< pt (point-max))
                     (sp--char-is-part-of-closing (buffer-substring-no-properties pt (1+ pt))))
                (forward-char 1)
              (call-interactively #'self-insert-command))))
        (define-key smartparens-mode-map (kbd ")") #'sp-paredit-like-close-round)))

;; trying helpful for now, in the hopes of dropping counsel altogether, since I use helm more. 

;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)

(use-package helpful
  :bind
  ("C-h v" . helpful-variable)
  ("C-h f" . helpful-callable)
  ("C-h k" . helpful-key)
  ("C-c C-d" . helpful-at-point)
  ("C-h F" . helpful-function)
  ("C-h C" . helpful-command)
  ;; :config

  ;; ;; Note that the built-in `describe-function' includes both functions
  ;; ;; and macros. `helpful-function' is functions only, so we provide
  ;; ;; `helpful-callable' as a drop-in replacement.    (global-set-key (kbd "C-h f") #'helpful-callable)

  ;; (global-set-key (kbd "C-h v") #'helpful-variable)
  ;; (global-set-key (kbd "C-h k") #'helpful-key)

  ;; ;; Lookup the current symbol at point. C-c C-d is a common keybinding
  ;; ;; for this in lisp modes.
  ;; (global-set-key (kbd "C-c C-d") #'helpful-at-point)

  ;; ;; Look up *F*unctions (excludes macros).
  ;; ;;
  ;; ;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
  ;; ;; already links to the manual, if a function is referenced there.
  ;; (global-set-key (kbd "C-h F") #'helpful-function)

  ;; ;; Look up *C*ommands.
  ;; ;;
  ;; ;; By default, C-h C is bound to describe `describe-coding-system'. I
  ;; ;; don't find this very useful, but it's frequently useful to only
  ;; ;; look at interactive functions.
  ;; (global-set-key (kbd "C-h C") #'helpful-command)
  )

;; learn some more key bindings with guide-key
;; guide-key

(use-package guide-key
  :after org
  :config
  (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8" "C-x +"))
  (setq guide-key/recursive-key-sequence-flag t)
  (setq guide-key/popup-window-position 'bottom)
  (guide-key-mode 1)
  ;; add some stuff just for org-mode. Hence the :after above
  (defun guide-key/my-hook-function-for-org-mode ()
    (guide-key/add-local-guide-key-sequence "C-c")
    (guide-key/add-local-guide-key-sequence "C-c C-x")
    (guide-key/add-local-highlight-command-regexp "org-"))
  :hook
  (org-mode . guide-key/my-hook-function-for-org-mode)
  ;; (add-hook 'org-mode-hook 'guide-key/my-hook-function-for-org-mode)
  )

;;;; add eldoc for python
(add-hook 'python-mode-hook
          '(lambda () (eldoc-mode 1)) t)
;;;;; indent yanked code
;; this replicates other functionality, let's just get rid of this to 
;; avoid problems
;; (dolist (command '(yank yank-pop))
;;   (eval `(defadvice ,command (after indent-region activate)
;;            (and (not current-prefix-arg)
;;                 (member major-mode '(emacs-lisp-mode lisp-mode
;;                                                      clojure-mode    scheme-mode
;;                                                      haskell-mode    ruby-mode
;;                                                      rspec-mode      python-mode
;;                                                      c-mode          c++-mode
;;                                                      objc-mode       latex-mode
;;                                                      plain-tex-mode))
;;                 (let ((mark-even-if-inactive transient-mark-mode))
;;                   (indent-region (region-beginning) (region-end) nil))))))

;;;; Find a Function Definition
;; A simple lambda function to search and find the definition of a function or variable.  Only works In Elisp.  Bound to C-c f.
;; not sure this makes much sense; I think use *helpful* instead.
;; (global-set-key (kbd "C-c f")
;;                 (lambda ()
;;                   (interactive)
;;                   (use-package finder)
;;                   (let ((thing (intern (thing-at-point 'symbol))))
;;                     (if (functionp thing)
;;                         (find-function thing)
;;                       (find-variable thing)))))

(use-package loccur
    :ensure t
    :bind
    (("M-s l" . loccur-current)
     ("M-s L" . loccur)
     ("M-s M-l" . loccur-previous-match))
    :config
    (defvar loccur-fill-word t
      "whether or not to fill in the current word at prompt")
    (setq loccur-fill-word nil)
    (defun loccur-prompt ()
  "Return the default value of the prompt.

Default value for prompt is a current word or active region(selection),
if its size is 1 line"
  (let ((prompt
         (if (and transient-mark-mode
                  mark-active)
             (let ((pos1 (region-beginning))
                   (pos2 (region-end)))
               ;; Check if the start and the end of an active region is on
               ;; the same line
               (when (save-excursion
                       (goto-char pos1)
                       (<= pos2 (line-end-position)))
                   (buffer-substring-no-properties pos1 pos2)))
           (if loccur-fill-word 
               (current-word) nil))))
    prompt))
    )

;; anzu -- pretty text replacement
(use-package anzu
  :config
  (global-anzu-mode)
  (global-set-key (kbd "M-%") 'anzu-query-replace)
  (global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp))

;; wrap-region
(use-package wrap-region
  :ensure t
  :config
  (wrap-region-add-wrappers
   '(("*" "*" nil org-mode)
     ("~" "~" nil org-mode)
     ("/" "/" nil org-mode)
     ("=" "=" nil org-mode)
     ("_" "_" nil org-mode)
     ("$" "$" nil (org-mode latex-mode))))
  (add-hook 'org-mode-hook 'wrap-region-mode)
  (add-hook 'latex-mode-hook 'wrap-region-mode))

(scroll-bar-mode 1)           
  (set-scroll-bar-mode 'right)
(setq
 scroll-margin 0
 scroll-conservatively 100000
 scroll-preserve-screen-position 1)

;;; backup and autosave
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq make-backup-files t)       ; enable backup file
;;;; put packups in ~/.backup
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.backup"))
            backup-directory-alist))

(setq version-control t)     ; enable versions of backup
(setq kept-new-versions 5)   ; how many keep new verisons
(setq kept-old-versions 5)   ; how many keep old versions
(setq delete-old-versions t) ; delete old version without asking
(setq vc-make-backup-files t) ; still make a backup for version-controled files

;;;;; Autosave in .backup dir
(setq auto-save-file-name-transforms
      '(("\\([^/]*/\\)*\\([^/]*\\)\\'" "~/.backup/\\2" t)))

;; make emacs remember where it is in the file you just closed
(use-package saveplace 
  :init
  ;; (setq-default save-place t)
  (save-place-mode)
  ;; (setq save-place-file (expand-file-name "places" user-emacs-directory))
   :config
  (setq server-visit-hook (quote (save-place-find-file-hook)))
  (setq save-place-forget-unreadable-files nil)
  )

;; persistent-scratch
(use-package persistent-scratch
  :config
  (persistent-scratch-setup-default)
  (setq persistent-scratch-backup-directory "~/.backup/persistent-scratch"))

;;;; iswitchb-mode
;; I want to be able to conmute between a split and a single window (sort of "C-x 1" for the one on focus)
(iswitchb-mode 1)
(defun my-iswitchb-select()
  "Jump to buffer without having to hit 'RET' key or C-j. The binding to C-2 is more ergonomic"
  (interactive)
  (if (window-minibuffer-p (selected-window))
      (iswitchb-select-buffer-text)))

(define-key global-map (kbd "C-2") 'my-iswitchb-select)


(defun my-iswitchb-close()
  "Open iswitchb or, if in minibuffer go to next match. Handy way to cycle through the ring."
  (interactive)
  (if (window-minibuffer-p (selected-window))
      (keyboard-escape-quit)))

;;;; tramp mode
 (use-package tramp
   :defer)

(defun jcs-kill-a-buffer (askp)
      (interactive "P")
      (if askp
          (call-interactively #'kill-buffer)
        (kill-buffer (current-buffer))))

    (global-set-key (kbd "C-x k") 'jcs-kill-a-buffer)
;;  (global-set-key (kbd "C-x k") 'kill-this-buffer)

(global-set-key (kbd "C-x w") 'delete-frame)

(defun make-parent-directory ()
  "Make sure the directory of `buffer-file-name' exists."
  (make-directory (file-name-directory buffer-file-name) t))

(add-hook 'find-file-not-found-functions #'make-parent-directory)

(defun xah-toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Always cycle in this order: Init Caps, ALL CAPS, all lower.

URL `http://ergoemacs.org/emacs/modernization_upcase-word.html'
Version 2016-01-08"
  (interactive)
  (let (
        (deactivate-mark nil)
        -p1 -p2)
    (if (use-region-p)
        (setq -p1 (region-beginning)
              -p2 (region-end))
      (save-excursion
        (skip-chars-backward "[:alnum:]")
        (setq -p1 (point))
        (skip-chars-forward "[:alnum:]")
        (setq -p2 (point))))
    (when (not (eq last-command this-command))
      (put this-command 'state 0))
    (cond
     ((equal 0 (get this-command 'state))
      (upcase-initials-region -p1 -p2)
      (put this-command 'state 1))
     ((equal 1  (get this-command 'state))
      (upcase-region -p1 -p2)
      (put this-command 'state 2))
     ((equal 2 (get this-command 'state))
      (downcase-region -p1 -p2)
      (put this-command 'state 0)))))
      (global-set-key  (kbd "C-9") 'xah-toggle-letter-case)

;; here's a quick macro to select and copy a buffer
;; F6 copy whole buffer
(defun mwp-copy-whole-buffer ()
  "Copy the whole buffer into the kill ring"
  (interactive)
  (mark-whole-buffer)
  (copy-region-as-kill(region-beginning) (region-end))
  )
(global-set-key (quote [f6]) 'mwp-copy-whole-buffer)

(use-package mwim 
  :ensure t
  :bind 
  (("C-a" . mwim-beginning)
   ("C-e" . mwim-end)))

;; Font lock dash.el
;; dash.el is amazing, maybe to oadvanced for me
(use-package dash
  :no-require t
  :config
  (dash-enable-font-lock))

;; ;; Emacs server
(use-package server
  :config
  (or (eq (server-running-p) t)
    (server-start))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; some stuff form magnars,
;; https://github.com/magnars/.emacs.d/blob/master/key-bindings.el
;; this should be moved to own file keybindings.el

;; this is old, and some of this gets written over later in the process.
;; (use-package misc)
;; (global-set-key (kbd "s-.") 'copy-from-above-command)

;; find function!  a must
(global-set-key (kbd "C-h C-f") 'find-function)
;; M-i for back-to-indentation; may not be necessary anymore and I don't use it
;; (global-set-key (kbd "M-i") 'back-to-indentation)

;; Turn on the menu bar for exploring new modes ;; this is cool
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)

;; transposing -- these are neat
;; Transpose stuff with M-t
(global-unset-key (kbd "M-t")) ;; which used to be transpose-words
(global-set-key (kbd "M-t l") 'transpose-lines)
(global-set-key (kbd "M-t w") 'transpose-words)
(global-set-key (kbd "M-t s") 'transpose-sexps)
(global-set-key (kbd "M-t p") 'transpose-params)

;; Killing text -- I don't use this, commenting out
;; (global-set-key (kbd "C-S-k") 'kill-and-retry-line)
;; (global-set-key (kbd "C-w") 'kill-region-or-backward-word)
;; (global-set-key (kbd "C-c C-w") 'kill-to-beginning-of-line)

;; Use M-w for copy-line if no active region
(global-set-key (kbd "M-w") 'save-region-or-current-line)
;; (global-set-key (kbd "s-w") 'save-region-or-current-line)
(global-set-key (kbd "M-W") (lambda (save-region-or-current-line 1)))

;; Make shell more convenient, and suspend-frame less
(global-set-key (kbd "C-z") 'shell)
(global-set-key (kbd "C-x M-z") 'suspend-frame)

;; Zap to char -- npt usoing right now so commenting out
;; (global-set-key (kbd "M-z") 'zap-up-to-char)
;; (global-set-key (kbd "s-z") (lambda (char) (interactive "cZap up to char backwards: ") (zap-up-to-char -1 char)))

;; (global-set-key (kbd "M-Z") (lambda (char) (interactive "cZap to char: ") (zap-to-char 1 char)))
;; (global-set-key (kbd "s-Z") (lambda (char) (interactive "cZap to char backwards: ") (zap-to-char -1 char)))

;; Jump to a definition in the current file. (This is awesome)
;; I'm using this keybinding for spell correcton though. Need to set to something else.

;; we don't use ido ever!
;; (global-set-key (kbd "C-x C-h") 'ido-imenu)

;; Perform general cleanup.
(global-set-key (kbd "C-c n") 'cleanup-buffer)
(global-set-key (kbd "C-c C-n") 'cleanup-buffer)
(global-set-key (kbd "C-c C-<return>") 'delete-blank-lines)

;; add ful lpath of current buffer to kill ring
(defun mwp-get-buf-path ()
  (interactive)
  (kill-new (buffer-file-name)))

;; modeline appearance
;; this enables smart-mode-line, which colorizes the modeline.
;; it's pretty helpful.  
;; (sml/setup)
;; (setq sml/no-confirm-load-theme t)

  ;;;; visual line mode
;; enable visual line mode for text modes
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(remove-hook 'org-mode-hook (lambda () (visual-line-mode -1)))


;;; use accents dammit!
;; this is a little imperfect but I still need it
(use-package iso-transl)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
  ;;;; word counts
;; word counts
(defun wc (&optional start end)
  "Prints number of lines, words and characters in region or whole buffer."
  (interactive)
  (let ((n 0)
        (start (if mark-active (region-beginning) (point-min)))
        (end (if mark-active (region-end) (point-max))))
    (save-excursion
      (goto-char start)
      (while (< (point) end) (if (forward-word 1) (setq n (1+ n)))))
    (message "%3d %3d %3d" (count-lines start end) n (- end start))))

;; unfilling paras
  ;;; switching window configurations
(defun toggle-windows-split()
  "Switch back and forth between one window and whatever split of windows we might have in the frame. The idea is to maximize the current buffer, while being able to go back to the previous split of windows in the frame simply by calling this command again."
  (interactive)
  (if (not(window-minibuffer-p (selected-window)))
      (progn
        (if (< 1 (count-windows))
            (progn
              (window-configuration-to-register ?u)
              (delete-other-windows))
          (jump-to-register ?u))))
  (my-iswitchb-close))

;; Then, the convenient key binding:
(define-key global-map (kbd "C-`") 'toggle-windows-split)
(define-key global-map (kbd "C-~") 'toggle-windows-split)
(define-key global-map (kbd "C-|") 'toggle-windows-split) ; same key, on a spanish keyword mapping since I commute a lot between both

(defun back-window ()
  (interactive)
  (other-window -1))
(define-key global-map (kbd "C-x O") 'back-window)

  ;;;; unfill paragraph
;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

  ;;;
;; hippie expand
;; (global-set-key [remap dabbrev-expand] 'hippie-expand)

(defun mwp-copy-file-name-to-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(define-fringe-bitmap 'flycheck-fringe-bitmap-ball
  (vector #b000000000
          #b000000000
          #b000000000
          #b000000000
          #b000111000
          #b001111100
          #b011111100
          #b111111111
          #b111111111
          #b111111111
          #b011111100
          #b001111000
          #b000110000
          #b000000000
          #b000000000
          #b000000000
          #b000000000
          #b000000000))

(define-fringe-bitmap 'flycheck-fringe-bitmap-ball
  (vector #b000000000000
          #b000000000000
          #b000001100000
          #b000111111000
          #b001111111100
          #b011111111110
          #b111111111111
          #b011111111110
          #b001111111100
          #b000111111000
          #b000011110000
          #b000001100000
          #b000000000000
          #b000000000000
          #b000000000000))

(flycheck-define-error-level 'error
  :severity 100
  :compilation-level 2
  :overlay-category 'flycheck-error-overlay
  :fringe-bitmap 'flycheck-fringe-bitmap-ball
  :fringe-face 'flycheck-fringe-error
  :error-list-face 'flycheck-error-list-error)

(flycheck-define-error-level 'warning
  :severity 10
  :compilation-level 1
  :overlay-category 'flycheck-warning-overlay
  :fringe-bitmap 'flycheck-fringe-bitmap-ball
  :fringe-face 'flycheck-fringe-warning
  :error-list-face 'flycheck-error-list-warning)

(flycheck-define-error-level 'info
  :severity -10
  :compilation-level 0
  :overlay-category 'flycheck-info-overlay
  :fringe-bitmap 'flycheck-fringe-bitmap-ball
  :fringe-face 'flycheck-fringe-info
  :error-list-face 'flycheck-error-list-info)

;; this corrects an error I used to have. 
(setq print-length 10000)


;; makes file name completion in the minibuffer case-insensitive
(setq read-file-name-completion-ignore-case t)

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode)
  ;;:config
  ;; 
  ;; (set-face-attribute 'rainbow-delimiters-unmatched-face nil
  ;;                     :foreground 'unspecified
  ;;                     :inherit 'error)
  )

(defun dcaps-to-scaps ()
  "Convert word in DOuble CApitals to Single Capitals."
  (interactive)
  (and (= ?w (char-syntax (char-before)))
       (save-excursion
         (and (if (called-interactively-p)
                  (skip-syntax-backward "w")
                (= -3 (skip-syntax-backward "w")))
              (let (case-fold-search)
                (looking-at "\\b[[:upper:]]\\{2\\}[[:lower:]]"))
              (let ((words (if subword-mode 2 1))) (capitalize-word words))))))

;; (add-hook 'pre-abbrev-expand-hook #'dcaps-to-scaps nil 'local)
;; (add-hook 'post-self-insert-hook #'dcaps-to-scaps nil 'local)
;; (remove-hook 'post-self-insert-hook #'dcaps-to-scaps 'local)

(define-minor-mode dubcaps-mode
  "Toggle `dubcaps-mode'.  Converts words in DOuble CApitals to
Single Capitals as you type."
  :init-value nil
  :lighter (" DC")
  (if dubcaps-mode
      (progn
        (add-hook 'post-self-insert-hook #'dcaps-to-scaps nil 'local)
        ;; (add-hook 'pre-abbrev-expand-hook #'dcaps-to-scaps nil 'local)
)
    (remove-hook 'post-self-insert-hook #'dcaps-to-scaps 'local)
    ;; (remove-hook 'pre-abbrev-expand-hook #'dcaps-to-scaps 'local)
    ))

 (add-hook 'text-mode-hook #'dubcaps-mode)

(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

(global-set-key [remap kill-ring-save] 'easy-kill)

;; actually diminish is loaded above, just being configured here, osmewhat wierdly. 
 ;; these need to be moved to the appropriate other declarations. sigh. 
 (eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
 (eval-after-load "eldoc" '(diminish 'eldoc-mode))
 (eval-after-load "paredit" '(diminish 'paredit-mode))
 (eval-after-load "tagedit" '(diminish 'tagedit-mode))
 (eval-after-load "elisp-slime-nav" '(diminish 'elisp-slime-nav-mode))
 (eval-after-load "skewer-mode" '(diminish 'skewer-mode))
 (eval-after-load "skewer-css" '(diminish 'skewer-css-mode))
 (eval-after-load "skewer-html" '(diminish 'skewer-html-mode))
 (eval-after-load "smartparens" '(diminish 'smartparens-mode))
 (eval-after-load "guide-key" '(diminish 'guide-key-mode))

 (defmacro rename-modeline (package-name mode new-name)
   `(eval-after-load ,package-name
      '(defadvice ,mode (after rename-modeline activate)
         (setq mode-name ,new-name))))

 (rename-modeline "js2-mode" js2-mode "JS2")
 (rename-modeline "clojure-mode" clojure-mode "Clj")

;;; macros
;;;; mwp/org-insert-example
(fset 'mwp/org-insert-example
   [?# ?+ ?B ?E ?G ?I ?N ?_ ?E ?X ?A ?M ?P ?L ?E return return ?# ?+ ?E ?N ?D ?_ ?E ?X ?A ?M ?P ?L ?E up])

(global-set-key (kbd "C-c M-2") 'mwp/org-insert-example)
;;;; mwp/org-insert-quote
(fset 'mwp/org-insert-quote
   [?# ?+ ?B ?E ?G ?I ?N ?_ ?Q ?U ?O ?T ?E return return ?# ?+ ?E ?N ?D ?_ ?Q ?U ?O ?T ?E up])

(global-set-key (kbd "C-c M-1") 'mwp/org-insert-quote)

;;;; mwp/org-insert-iframe
(fset 'mwp/org-insert-iframe
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([35 43 98 101 103 105 110 95 104 116 109 108 return 60 105 102 114 97 109 101 32 119 105 100 116 104 61 34 56 48 48 112 120 right 32 104 101 105 103 104 116 61 34 52 53 48 112 120 right 32 115 114 99 61 34 right 62 60 47 105 102 114 97 109 101 62 return 35 61 backspace 43 101 110 100 95 104 116 109 108 return up left left left left left left left left left left left left] 0 "%d")) arg)))

;; (global-set-key (kbd "C-c M-0") 'mwp/org-insert-iframe)
;;;; save a macro
;; keyboard macro function
(defun save-macro (name)                  
  "save a macro. Take a name as argument
     and save the last defined macro under 
     this name at the end of your .emacs"
  (interactive "SName of the macro :")  ; ask for the name of the macro    
  (kmacro-name-last-macro name)         ; use this name for the macro    
  (find-file "/home/matt/.emacs")                   ; open ~/.emacs or other user init file 
  (goto-char (point-max))               ; go to the end of the .emacs
  (newline)                             ; insert a newline
  (insert-kbd-macro name)               ; copy the macro 
  (newline)                             ; insert a newline
  (switch-to-buffer nil))               ; return to the initial buffer

;; Keyboard macro to insert quotes. not bound yet to anything
(fset 'insert_quote

      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([35 43 66 69 71 73 78 95 81 85 79 84 69 return return 35 43 69 78 68 95 81 85 79 84 69 up] 0 "%d")) arg)))

(fset 'mwp/org-insert-js
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([35 43 66 69 71 73 78 95 83 82 67 32 108 97 110 103 117 97 103 101 61 106 97 118 97 115 99 114 105 112 116 return return 35 43 69 78 68 95 83 82 67 up] 0 "%d")) arg)))

(fset 'mwp/org-insert-html
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([35 43 66 69 71 73 78 95 83 82 67 32 104 116 109 108 13 13 35 43 69 78 68 95 83 82 67 up] 0 "%d")) arg)))

;;; fix html export xml declaration so OOo can read it
(setq org-export-html-xml-declaration
      '(("html" . "")
        ("php" . "<?php echo \"<?xml version=\\\"1.0\\\" encoding=\\\"%s\\\" ?>\";
?>")))

(fset 'grading-template
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([42 42 32 return 124 32 79 114 103 97 110 105 122 97 116 105 111 110 32 124 32 124 32 backspace tab 67 108 97 114 105 116 121 32 111 102 32 84 104 101 115 105 115 tab tab 80 114 101 115 101 110 116 97 116 105 111 110 32 111 102 32 69 118 105 100 101 110 99 101 32 124 32 124 backspace backspace backspace backspace tab tab 71 114 97 109 109 97 114 32 97 110 100 32 83 112 101 108 108 105 110 103 tab tab 83 116 121 108 101 tab tab 67 105 116 97 116 105 111 110 115 tab tab 70 117 114 116 104 101 114 32 67 111 109 109 101 110 116 115 tab tab 71 114 97 100 101 tab up up up up up up up up 32] 0 "%d")) arg)))

(defvar modi/org-version-select 'dev
    "Variable to choose the version of Org to be loaded.
      Valid values are `dev', `elpa' and `emacs'.

      When set to `dev', the development version of Org built locally
      is loaded.
      When set to `elpa', Org is installed and loaded from Org Elpa.
      When set to `emacs', the Org version shipped with Emacs is used.

      The value is defaulted to `elpa' as few things in this config
      need Org version to be at least 9.x.")
  ;; Mark packages to *not* to be updated
  ;; http://emacs.stackexchange.com/a/9342/115
  (defvar modi/package-menu-dont-update-packages '(org)
    "List of packages for which the package manager should not look for updates.
      Example: '(org org-plus-contrib).")
  ;; Do not upgrade Org using the package manager if it's set to *not* use the
  ;; Elpa version of Org.
  (unless (eq modi/org-version-select 'elpa)
    (add-to-list 'modi/package-menu-dont-update-packages 'org-plus-contrib))



  (defun modi/package-menu-remove-excluded-packages (orig-fun &rest args)
    "Remove the packages listed in `modi/package-menu-dont-update-packages' from
      the `tabulated-list-entries' variable."
    (let ((included (-filter
                     (lambda (entry)
                       (let ((pkg-name (package-desc-name (car entry))))
                         (not (member pkg-name modi/package-menu-dont-update-packages))))
                     tabulated-list-entries)))
      (setq-local tabulated-list-entries included)
      (apply orig-fun args)))
  (advice-add 'package-menu--find-upgrades :around #'modi/package-menu-remove-excluded-packages)
  ;; (advice-remove 'package-menu--find-upgrades #'modi/package-menu-remove-excluded-packages)
  (defvar modi/default-lisp-directory "/usr/share/emacs/27.0.50/lisp/"
    "Directory containing lisp files for the Emacs installation.

      This value must match the path to the lisp/ directory of your
      Emacs installation.  If Emacs is installed using
      --prefix=\"${PREFIX_DIR}\" this value would typically be
      \"${PREFIX_DIR}/share/emacs/<VERSION>/lisp/\".")

  (defvar org-dev-lisp-directory "/home/matt/src/org-mode/emacs/site-lisp/org"
    "Directory containing lisp files for dev version of Org.

      This value must match the `lispdir' variable in the Org local.mk.
      By default the value is \"$prefix/emacs/site-lisp/org\", where
      `prefix' must match that in local.mk too.")

  (defvar org-dev-info-directory "/home/matt/src/org-mode/info"
    "Directory containing Info manual file for dev version of Org.
      This value must match the `infodir' variable in the Org local.mk.")

  (when (and org-dev-lisp-directory
             org-dev-info-directory)
    (with-eval-after-load 'package
      ;; If `modi/org-version-select' is *not* `emacs', remove the Emacs
      ;; version of Org from the `load-path'.
      (unless (eq modi/org-version-select 'emacs)
        ;; Remove Org that ships with Emacs from the `load-path'.
        (let ((default-org-path (expand-file-name "org" modi/default-lisp-directory)))
          (setq load-path (delete default-org-path load-path))))

      ;; If `modi/org-version-select' is *not* `elpa', remove the Elpa
      ;; version of Org from the `load-path'.

      (unless (eq modi/org-version-select 'elpa)
        (dolist (org-elpa-install-path (directory-files-recursively
                                        package-user-dir
                                        "\\`org\\(-plus-contrib\\)*-[0-9.]+\\'"
                                        :include-directories))
          (setq load-path (delete org-elpa-install-path load-path))
          ;; Also ensure that the associated path is removed from Info
          ;; search list.
          (setq Info-directory-list (delete org-elpa-install-path Info-directory-list))))

      (let ((dev-org-path (directory-file-name org-dev-lisp-directory))
            (dev-org-info (directory-file-name org-dev-info-directory)))
        (if (eq modi/org-version-select 'dev)
            (progn
              (add-to-list 'load-path dev-org-path)
              ;; It's possible that `org-dev-info-directory' is set to an
              ;; unconventional value, in which case, it will not be
              ;; automatically added to `Info-directory-alist'. So to ensure
              ;; that the correct Org Info is used, add it to
              ;; `Info-directory-alist' manually.
              (add-to-list 'Info-directory-list dev-org-info))
          ;; If `modi/org-version-select' is *not* `dev', remove the
          ;; development version of Org from the `load-path'.
          (setq load-path (delete dev-org-path load-path))
          (with-eval-after-load 'info
            ;; Also ensure that the associated path is removed from Info search
            ;; list.
            (setq Info-directory-list (delete dev-org-info Info-directory-list)))))))


  (use-package org
    :ensure t
    :load-path "/home/matt/src/org-mode/emacs/site-lisp/org"
    :pin manual
    ;; :load-path (org-lisp org-contrib)
    :preface
    (setq org-tempo-keywords-alist nil)
    ;;:init
    ;;(setq org-export-backends '(ascii beamer html hugo icalendar md gfm reveal latex odt org))
    :hook
    ((org-mode . (lambda () (flyspell-mode 1)))
     (org-mode . turn-off-auto-fill))
    :mode ("\\.org" . org-mode)
    :bind 
    (("C-c l" . 'org-store-link)
     ("C-c a" . 'org-agenda))
    :commands (org-mode org-capture org-agenda )
    :config
    (message "at the beginning of config section oforg-mode use-package")
    (display-warning 'org-mode "at the beginning of config section oforg-mode use-package" :debug)

    ;; Targets include this file and any file contributing to the agenda - up to 5 levels deep
    (setq org-refile-targets
          (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5)
                  ("/home/matt/org/.org2blog.el" :maxlevel . 1)
                  ("/home/matt/Dropbox/Work/History/HackingHistory/Grades.org" :maxlevel . 5))))

    (defun add-pcomplete-to-capf ()
      (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))

    (add-hook 'org-mode-hook #'add-pcomplete-to-capf)
    ;; Targets start with the file name - allows creating level 1 tasks
    (setq org-refile-use-outline-path (quote file))

    ;; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
    (setq org-outline-path-complete-in-steps t)

    ;; Allow refile to create parent tasks with confirmation
    (setq org-refile-allow-creating-parent-nodes (quote confirm))
    (require 'ox)
    (load  "~/src/org-mode/emacs/site-lisp/org/ox-md")
    (with-eval-after-load "ox-md" 
      (require 'ox-gfm)
      (add-to-list 'org-export-backends 'md)
      (add-to-list 'org-export-backends 'gfm)
      (load "~/src/ox-slack/ox-slack.el") ;; (use-package ox-slack
           ;; :load-path "~/src/ox-slack"
           ;; :pin manual
           ;; :defer nil
           ;; ;; :preface
           ;; ;; (require 'ox-md)
           ;; ;; (require 'ox-gfm)
           ;; ;; :after (org )
           ;; ;; :bind
           ;; ;; ("C-c W s" . org-slack-export-to-clibpoard-as-slack)
           ;; )
)

    )
  ;; agenda config
  (use-package org-agenda
    :after org
    :config
    ;; agenda diary stuff
    (setq org-agenda-diary-file "~/Dropbox/GTD/diary.org")
    (setq org-agenda-include-diary t)

    (setq org-agenda-custom-commands
          '(("g" . "GTD contexts")
            ("ge" "email" tags-todo "email/+ACTION")
            ("gc" "Computer" tags-todo "computer/+ACTION")
            ("go" "Office" tags-todo "office/+ACTION")
            ("gp" "Phone" tags-todo "phone/+ACTION")
            ("gh" "Home" tags-todo "home/+ACTION")
            ("gr" "Errands" tags-todo "errand/+ACTION")
            ("E" "EDGI Tasks" tags "edgi")
            ("G" "GTD Block Agenda"
             ((tags-todo "phone/+ACTION")
              (tags-todo "office/+ACTION")
              (tags-todo "email/+ACTION")
              (tags-todo "computer/+ACTION")
              (tags-todo "home/+ACTION")
              (tags-todo "errand/+ACTION")
              (tags-todo "-phone-office-email-computer-home-office/+ACTION"))
             nil                      ;; i.e., no local settings
             ("~/next-actions.html")) ;; exports block to this file with C-c a e
            ;; ("T" "Teaching Block Agenda"
            ;;  ((tags-todo "phone+teaching/+ACTION")
            ;;   (tags-todo "office+teaching/+ACTION")
            ;;   (tags-todo "email+teaching/+ACTION")
            ;;   (tags-todo "computer+teaching/+ACTION")
            ;;   (tags-todo "home+teaching/+ACTION")
            ;;   (tags-todo "errand+teaching/+ACTION")
            ;;   (tags-todo "-phone-office-email-computer-home-office+teaching/+ACTION"))
            ;;  nil                      ;; i.e., no local settings
            ;;  ("~/next-actions.html"))
            ;; exports block to this file with C-c a e
            ("H" "GTD Block Agenda"
             ((tags-todo "+history+phone/+ACTION|BLOCKED")
              (tags-todo "+history+office/+ACTION|BLOCKED")
              (tags-todo "+history+email/+ACTION|BLOCKED")
              (tags-todo "+history+computer/+ACTION|BLOCKED")
              (tags-todo "+history+home/+ACTION+|BLOCKED")
              (tags-todo "+history+errand/+ACTION|BLOCKED")
              (tags-todo "+history-phone-office-email-computer-home-office/+ACTION|BLOCKED"))
             nil                              ;; i.e., no local settings
             ("~/history-next-actions.html")) ;; exports block to this file with C-c a e
            ("W" "WAITING block Agenda"
             ((tags-todo "phone/+WAITING")
              (tags-todo "email/+WAITING")
              (tags-todo "computer/+WAITING")
              (tags-todo "office/+WAITING")
              (tags-todo "home/+WAITING")
              (tags-todo "errand/+WAITING"))
             nil                      ;; i.e., no local settings
             ("~/next-actions.html")) ;; exports block to this file with C-c a e
            ;; ..other commands here
            ;; ("t" agenda "Teaching Agenda"
            ;;  (( org-agenda-filter-preset '("+teaching") )  ) )
            ("p" "Projects" todo "PROJECT")
            )))


      ;;;; Org-mode hooks
  ;; (add-hook 'org-mode-hook
  ;;   (lambda()
  ;;     (flyspell-mode 1)))
  ;; (add-to-list 'auto-mode-alist '("\\.org" . org-mode))

  ;; still need to load org2blog
  (use-package xml-rpc
    :load-path "~/src/xml-rpc"
    :no-require)
  (use-package org2blog
    :after (:all xml-rpc (:any org org-plus-contrib))
    :load-path  ("/home/matt/src/org2blog" "/home/matt/src/xml-rpc"))

  (use-package org2blog-autoloads
    :after org2blog
    )
  ;; this should turhn auto-fill off?
  ;; (add-hook 'org-mode-hook 'turn-off-auto-fill)
  ;;org-mouse.el -- an extra
  (use-package org-mouse
    :after (:any org org-plus-contrib))

  (use-package ox-odt
    :after (:any org org-plus-contrib)
    :defer 10
    :config
    (setq org-odt-styles-dir "/home/matt/src/org-mode/etc/styles/")
    ;; (setq org-odt-schema-dir "/home/matt/.emacs.d/Templates/")
    (setq org-odt-styles-file "/home/matt/.emacs.d/Templates/New113Syllabus.odt")
    ;; this needs to be set here, but the fn definition is actually below
    (add-to-list 'org-export-filter-timestamp-functions 'matt-org-export-filter-timestamp-function)
    )

;; (use-package ox
  ;;   :ensure t
  ;;   :load-path "/home/matt/src/org-mode/emacs/site-lisp/org/ox.el"
  ;;   :pin manual
  ;;   )


  ;;     ;;;; markdown export
  ;; (use-package ox-md
  ;;   :after (org)
  ;;   ;;:defer 7
  ;;   :config
  ;;   (add-to-list 'org-export-backends 'md))
  ;; ;;(setq org-export-backends '(ascii beamer html hugo icalendar md gfm reveal latex odt org)))
  ;; ;; (use-package ox-gfm :after (:any org org-plus-contrib))


  ;; (use-package ox-gfm
  ;;   :after (org)
  ;;   ;;:defer 9
  ;;   (add-to-list 'org-export-backends 'gfm))

;; (require 'ox-md)
;; ;;( org-export-register-backend 'md)
;; (use-package ox-md
;; :load-path "~/src/org-mode/emacs/site-lisp/org"
;; :defer nil
;; :after org
;; :config

;; )

;; (use-package ox-gfm
;; :ensure t
;; :defer nil
;; :after org
;; :config
;; ( org-export-register-backend 'gfm)
;; )

(use-package org-id
  :after org
  :config
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
  (defun eos/org-custom-id-get (&optional pom create prefix)
    "Get the CUSTOM_ID property of the entry at point-or-marker POM.
   If POM is nil, refer to the entry at point. If the entry does
   not have an CUSTOM_ID, the function returns nil. However, when
   CREATE is non nil, create a CUSTOM_ID if none is present
   already. PREFIX will be passed through to `org-id-new'. In any
   case, the CUSTOM_ID of the entry is returned."
    (interactive)
    (org-with-point-at pom
      (let* ((id (org-entry-get nil "CUSTOM_ID"))
             (hinit (org-get-heading t t))
             (headline (downcase
                       (replace-regexp-in-string "[\"\*\/\!]" ""
                                                 (replace-regexp-in-string " " "-"
                                                                           (if (and (> (length hinit) 9) (string= "COMMENT " (substring hinit 0 8))) 
                                                                             (substring hinit  8 nil)
                                                                             (org-get-heading)))))))
        (cond
         ((and id (stringp id) (string-match "\\S-" id))
          id)
         (create
          (setq id (concat headline "-" (substring (org-id-new 'none) 0 4)))
          (org-entry-put pom "CUSTOM_ID" id)
          (org-id-add-location id (buffer-file-name (buffer-base-buffer)))
          id)))))

  (defun eos/org-add-ids-to-headlines-in-file ()
    "Add CUSTOM_ID properties to all headlines in the
   current file which do not already have one."
    (interactive)
    (org-map-entries (lambda () (eos/org-custom-id-get (point) 'create)))))

(use-package org-protocol
  :after (:any org org-plus-contrib))
(use-package org-protocol-capture-html
  :after org-protocol
  :load-path  "/home/matt/src/org-protocol-capture-html"

  :config
  (setq org-capture-templates 
        '(
          ("t" "Todo Items" )
          ("tt" "Teaching Todo with Schedule & Tags set" entry (file+olp "~/Dropbox/GTD/gtd.org" "Tasks" "Teaching") "* ACTION %^{Description}  %^G:teaching:\nSCHEDULED:%(org-insert-time-stamp (org-read-date nil t \".+1d\"))%?")
          ("tx" "Other Todo entries" entry (file+headline "~/Dropbox/GTD/gtd.org" "Tasks") "* ACTION %^{Description}  %^G\nSCHEDULED:%(org-insert-time-stamp (org-read-date nil t \".+1d\"))%? \n %i \n %l") 
          ("th" "History" entry (file+olp "~/Dropbox/GTD/gtd.org" "Tasks" "History Dept") "* ACTION %^{Description}  %^G\nSCHEDULED:%(org-insert-time-stamp (org-read-date nil t \".+1d\"))%?")     
          ("p" "Password" entry (file "~/GTD/Keep-it-safe.org.gpg") "* %^{Description} \n SITE: %^{URL} \n USER:%^{USER} \n PASS:%^{PASS}\n%? \n")
          ("j" "Journal" entry (file+datetree "~/Dropbox/GTD/Reference.org") "* %?
                  Entered on %U
                  %i
                  %a")
          ("m" "mail-todo" entry (file+headline "~/Dropbox/GTD/Reference.org" "Tasks")
           "* ACTION Reply to  %:fromname %? about %a :email:\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
          ("a" "Appointment" entry (file  "~/Dropbox/GTD/gcal.org" ) "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
          ("w" "Web site" entry
           (file+headline  "~/Dropbox/GTD/Reference.org" "Web")
           "* %a :website:\n\n%U %?\n\n%:initial")
          ))
      ;;;; add some workflow states
  (setq org-todo-keywords
        '((sequence "ACTION(a)" "WAITING(w)" "IN PROGRESS(p)" "BLOCKED(b)" "|" "DONE(d)" "WON'T DO(o)")
          (sequence "PROJECT(p)" "SOMEDAY(s)" "MAYBE(m)" "|" "COMPLETE(c)")))

    ;;;; recolor someo f those states
  (setq org-todo-keyword-faces
        '(("ACTION" . org-warning) ("IN PROGRESS" . "dark orange") ("WAITING" . "dark orange")
          ))
)
    (define-key global-map "\C-cc" 'org-capture)
  ;;(add-to-list 'load-path "/home/matt/src/org-protocol-capture-html")
  ;;(require 'org-protocol-capture-html)


    ;;; REFILING
    ;; Use IDO for target completion
    ;; (setq org-completion-use-ido t)
    ;; stuff from http://www.jboecker.de/2010/04/14/general-reference-filing-with-org-mode.html#sec-1 
    ;; for org-mode remember integration


    ;;; still more agenda
    (defadvice org-agenda-add-entry-to-org-agenda-diary-file
        (after add-to-google-calendar)
      "Add a new Google calendar entry that mirrors the diary entry just created by
    org-mode."
      (let ((type (ad-get-arg 0))
            (text (ad-get-arg 1))
            (d1 (ad-get-arg 2))
            (year1 (nth 2 d1))
            (month1 (car d1))
            (day1 (nth 1 d1))
            (d2 (ad-get-arg 3))
            entry dates)
        (if (or (not (eq type 'block)) (not d2))
            (setq dates (format "%d-%02d-%02d" year1 month1 day1))
          (let ((year2 (nth 2 d2)) (month2 (car d2)) (day2 (nth 1 d2)) (repeats (-
                                                                                 (calendar-absolute-from-gregorian d1)

                                                                                 (calendar-absolute-from-gregorian d2))))
            (if (> repeats 0)
                (setq dates (format "%d-%02d-%02d every day for %d days" year1
                                    month1 day1 (abs repeats)))
              (setq dates (format "%d-%02d-%02d every day for %d days" year1 month1
                                  day1 (abs repeats))))
            ))
        (setq entry (format "/usr/bin/google calendar add --cal org \"%s on %s\"" text dates))
        (message entry)
        (if (not (string= "MYLAPTOPCOMPUTER" mail-host-address))
            (shell-command entry)
          (let ((offline "~/tmp/org2google-offline-entries"))
            (find-file offline)
            (goto-char (point-max))
            (insert (concat entry "\n"))
            (save-buffer)
            (kill-buffer (current-buffer))
            (message "Plain text written to %s" offline)))))
    (ad-activate 'org-agenda-add-entry-to-org-agenda-diary-file)

;;;; export options for org-mode
(setq org-export-with-section-numbers nil
      org-export-with-toc nil
      org-export-preserve-breaks nil
      org-export-email-info nil
      )
  ;;;; Timestamps in Exports
;; removing annoying brackets from timestamp on html export
;; with org-mode set to defer, this has to be added to the use-package :config declaration above 
;; (add-to-list 'org-export-filter-timestamp-functions 'matt-org-export-filter-timestamp-function)
(defun matt-org-export-filter-timestamp-function (timestamp backend info)
  "removes relevant brackets from a timestamp"
    (if (org-export-derived-backend-p backend 'html 'odt )
      (replace-regexp-in-string "&[lg]t;" "" timestamp)
    (replace-regexp-in-string "&[lg]t;\\|[<>]" "" timestamp))
  ;; (pcase backend
  ;;   ((or 'html 'wp 'odt 'reveal 'latex 'hugo 'huveal 'blackfriday 'md 'gfm )
  ;;    )

  ;;   )
  )


(defun org-export-filter-timestamp-remove-brackets (timestamp backend info)
  "removes relevant brackets from a timestamp"
  (cond
   ((org-export-derived-backend-p backend 'latex)
    (replace-regexp-in-string "[<>]\\|[][]" "" timestamp))
   ((or (org-export-derived-backend-p backend 'html) (org-export-derived-backend-p backend 'odt))
    (replace-regexp-in-string "&[lg]t;\\|[][]" "" timestamp))))

(eval-after-load 'ox '(add-to-list
                       'org-export-filter-timestamp-functions
                       'org-export-filter-timestamp-remove-brackets))
;; (when (or  (org-export-derived-backend-p backend 'html)(org-export-derived-backend-p backend 'odt)) 
;;   ;; unfortunatley I can't make emacs regexps work yet.  sigh.  
;;   ;; (replace-regexp-in-string "[][]" "" timestamp)
;;   (replace-regexp-in-string "&[lg]t;\\|[][]" "" timestamp)
;;   ;; (replace-regexp-in-string "&lt;" "" timestamp))


;; removing annoying brackets from timestamp on html export
;; (add-to-list 'org-export-filter-paragraph-functions 'matt-org-export-filter-paragraph-function)
;; (defun matt-org-export-filter-paragraph-function (paragraph backend info)
;;   "removes comments from export"
;;   (when (org-export-derived-backend-p backend 'html) 
;;     ;; unfortunatley I can't make emacs regexps work yet.  sigh.  
;;     (replace-regexp-in-string "^#\+.*$" "" paragraph)
;;     ;; (replace-regexp-in-string "&lt;" "" paragraph)
;; ))

;; org-reveal
(use-package ox-reveal
  :after ox
  :load-path "~/src/org-reveal"
  :defer 12
  :config
  (setq org-reveal-root "file:///home/matt/src/reveal.js"))
;; (add-to-list 'load-path "~/src/org-reveal")
;; (require 'ox-reveal)
;; set local root

(defun mwp-org-reveal-publish-to-html (plist filename pub-dir)
  "Publish an org file to reveal.js HTML Presentation.
FILENAME is the filename of the Org file to be published.  PLIST
is the property list for the given project.  PUB-DIR is the
publishing directory. Returns output file name."
  (let (
        ;;(org-deck-base-url "http://sandbox.hackinghistory.ca/Tools/deck.js/")
        ;;(org-reveal-root "http://sandbox.hackinghistory.ca/Tools/reveal.js/")
        ;;(org-reveal-extra-css "http://sandbox.hackinghistory.ca/Tools/reveal.js/css/local.css")
        (org-reveal-single-file t)
      )   

    (org-publish-org-to 'reveal filename ".html" plist pub-dir))
  )

;;; Org2blog

(setq org2blog/wp-blog-alist
      '(("hh"
         :url "http://2016.hackinghistory.ca/xmlrpc.php"
         :username "matt"
         :default-title "Title"
         :default-categories (nil)
         :tags-as-categories nil)
        ("sik"
         :url "http://sikkim.hackinghistory.ca/xmlrpc.php"
         :username "matt"
         :default-title "Title"
         :default-categories (nil)
         :tags-as-categories nil)
        ("rel"
         :url "http://relsci.hackinghistory.ca/xmlrpc.php"
         :username "matt"
         :default-title "Title"
         :default-categories (nil)
         :tags-as-categories nil)
        ("dig"
         :url "http://digital.hackinghistory.ca/xmlrpc.php"
         :username "matt"
         :default-title "Title"
         :default-categories (nil)
         :tags-as-categories nil)
         ("matt"
         :url "http://matt.hackinghistory.ca/xmlrpc.php"
         :username "matt"
         :default-title ""
         :default-categories (nil)
         :tags-as-categories nil)
        ))


(defun o2bnew ()
  (interactive)
  (org2blog/wp-new-entry))
(defun o2blin ()
  (interactive)
  (org2blog/wp-login))


;;; Org2blog
;; starting org2blog a little more easily
;; example of binding keys only when html-mode is active

;;;; O2B kebybindings
(defun matt-org-mode-keys ()
  "Modify keymaps used by `org-mode'."
  (local-set-key (kbd "C-c <f1>") 'org2blog/wp-mode)
  (local-set-key "\C-c\C-r" 'org-decrypt-entry)
  ;; (local-set-key (kbd "RET") 'org-return-indent)
  ;; insert a NOTES drawer with C-c C-x n
;;  (local-set-key (kbd "C-c C-x n") (org-insert-drawer "NOTE"))

  ;; (local-set-key (kbd "C-c C-p") nil) ; remove a key

  )

;; add to org-mode-hook
;; should configure but 
(add-hook 'org-mode-hook 'matt-org-mode-keys)

;; (define-key org-mode-map "\C-ck" #'endless/insert-key)
(defun endless/insert-key (key)
  "Ask for a key then insert its description.
Will work on both org-mode and any mode that accepts plain html."
  (interactive "kType key sequence: ")
  (let* ((is-org-mode (derived-mode-p 'org-mode))
         (tag (if is-org-mode
                  "@@html:<kbd>%s</kbd>@@"
                "<kbd>%s</kbd>")))
    (if (null (equal key "\r"))
        (insert
         (format tag (help-key-description key nil)))
      (insert (format tag ""))
      (forward-char (if is-org-mode -8 -6)))))

;; export html to tmp dir
(defun mwp-org-html-to-tmp
    (&optional async subtreep visible-only body-only ext-plist)
  "Export current buffer to a HTML file in the tmp directory.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

When optional argument BODY-ONLY is non-nil, only write code
between \"<body>\" and \"</body>\" tags.


EXT-PLIST, when provided, is a property list with external
parameters overriding Org default settings, but still inferior to
file-local settings.

Return output file's name."
  (interactive)
  (let* ((extension (concat "." (or (plist-get ext-plist :html-extension)
                                    org-html-extension
                                    "html")))
;; this is the code I've changed from the original function. 
         (file (org-export-output-file-name extension subtreep "/home/matt/tmp/"))

         (org-export-coding-system org-html-coding-system))
    (org-export-to-file 'html file
      async subtreep visible-only body-only ext-plist)
    (org-open-file file)))

;; (org-defkey org-mode-map
;;             (kbd "C-c 0") 'mwp-org-html-to-tmp)

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))

;; ox-hugo isn't currently on MELPA and also hasn't been incorporated into org-mode. 
;; so for now you'll need to git clone git@github.com:kaushalmodi/ox-hugo.git and add the 
;; location to your load-path

;; (add-to-list 'load-path "~/src/kaushal-ox-hugo/")
(use-package ox-hugo
  :load-path "~/src/kaushal-ox-hugo/"
  :after (:any org org-plus-contrib))

(add-to-list 'load-path "~/src/kaushal-ox-hugo/")
  (use-package ox-hugo-auto-export
    :after ox-hugo
    :defer t)
(use-package ox-reveal-auto-export
  :after ox-reveal
  :defer t)

(defvar *transclude* t "Put overlays on or not")
(setq *transclude* t)

;; (org-link-set-parameters
;;  "transclude"
;;  :face '(:background "gray80")
;;  :follow (lambda (path)
;;            (org-open-link-from-string path))
;;  :keymap (let ((map (copy-keymap org-mouse-map)))
;;            (define-key map [C-mouse-1] (lambda ()
;;                                          (interactive)
;;                                          (setq *transclude* (not *transclude*))
;;                                          (unless *transclude*
;;                                            (ov-clear 'transclude))
;;                                          (font-lock-fontify-buffer)))
;;            map)
;;  :help-echo "Transcluded element. Click to open source. C-mouse-1 to toggle overlay."
;;  :activate-func (lambda (start end path bracketp)
;;                   (if *transclude*
;;                       (let ((ov (make-overlay start end))
;;                             el disp)
;;                         (ov-put ov 'transclude t)
;;                         (save-window-excursion
;;                           (with-temp-buffer
;;                             (insert path)
;;                             (org-open-file
;;                              (org-element-property
;;                               :path
;;                               (org-element-context))
;;                              nil nil
;;                              (org-element-property
;;                               :search-option
;;                               (org-element-context)))

;;                             (setq el (org-element-context))
;;                             (setq disp (buffer-substring
;;                                         (org-element-property :begin el)
;;                                         (- (org-element-property :end el)
;;                                            (or (org-element-property :post-blank el) 0)))))
;;                           (message-box "%s" disp)

;;                           (ov-put ov 'display disp)))
;;                     (ov-clear 'transclude 'any start end))))

(use-package org-zotxt
  :after (:any org org-plus-contrib)
  :config
  ;; zotxt
  (org-add-link-type "zotero"
                     (lambda (rest)
                       (zotxt-select-key (substring rest 15)))
                     (lambda (path desc format)
                       (if (string-match "^@\\(.*\\)$" desc)
                           (cond ((eq format 'latex)
                                  (format "\\cite{%s}" (match-string 1 desc)))
                                 ((eq format 'md)
                                  desc)
                                 ((eq format 'html)
                                  (deferred:$
                                    (zotxt-get-item-bibliography-deferred `(:key , (substring path 15)))
                                    (deferred:nextc it
                                      (lambda (item)
                                        (plist-get item :citation-html)))
                                    (deferred:sync! it)))
                                 ((eq format 'odt)
                                  (xml-escape-string (deferred:$
                                                       (zotxt-get-item-deferred `(:key , (substring path 15)) :248bebf1-46ab-4067-9f93-ec3d2960d0cd)
                                                       (deferred:nextc it
                                                         (lambda (item)
                                                           (plist-get item :248bebf1-46ab-4067-9f93-ec3d2960d0cd)))
                                                       (deferred:sync! it))))
                                 (t nil)
                                 nil)))))



;; a helper function to parse html to org syntax:
(use-package pcase
  :after org-zotxt
  :config


  (defun org-zotxt-parse-htmlstring (html)
    (with-temp-buffer
      (insert html)
      (libxml-parse-html-region (point-min) (point-max))))
  (defun org-zotxt-htmlstring2org (html)
    (org-zotxt-htmltree2org (org-zotxt-parse-htmlstring html)))

  (defun org-zotxt-htmltree2org (html)
    (pcase html
      ((pred (stringp)) html)
      (`(a ,attrs . ,children)
       (format "[[%s][%s]]" (cdr (assq 'href attrs))
               (org-zotxt-htmltree2org children)))
      (`(i ,attrs . ,children)
       (format "/%s/" (org-zotxt-htmltree2org children)))
      (`(b ,attrs . ,children)
       (format "*%s*" (org-zotxt-htmltree2org children)))
      (`(p ,attrs . ,children)
       (format "%s\n\n" (org-zotxt-htmltree2org children)))
      (`(span ,attrs . ,children)
       (pcase (cdr (assq 'style attrs))
         ("font-style:italic;"
          (format "/%s/" (org-zotxt-htmltree2org children)))
         ("font-variant:small-caps;"
          ;; no way?
          (org-zotxt-htmltree2org children))
         (_ (org-zotxt-htmltree2org children))))
      ((or `(html ,attrs . ,children)
           `(body ,attrs . ,children))
       (org-zotxt-htmltree2org children))
      ((pred (lambda (h) (and (listp h)
                              (or (stringp (car h))
                                  (and (listp (car h))
                                       (symbolp (car (car h))))))))
       ;; list of strings or elements
       (mapconcat #'org-zotxt-htmltree2org html "")))))

;; ;;; Thisi s essential for code blocks, etc. 
   ;;(setq org-use-speed-commands (lambda () (and (looking-at org-outline-regexp) (looking-back "^\**"))))
(setq org-use-speed-commands t)

  ;;; Extract Links
  (defun my-org-extract-link ()
    "Extract the link location at point and put it on the killring."
    (interactive)
    (when (org-in-regexp org-bracket-link-regexp 1)
      (kill-new (org-link-unescape (org-match-string-no-properties 1)))))

  ;; incude htmlize.el
  ;;; babel
  (org-babel-do-load-languages
   'org-babel-load-languages
    '( (perl . t)         
       (ruby . t)
       (shell . t)
       (dot . t)
       (python . t)
       (js . t) 
       (emacs-lisp . t)   
     ))

  (use-package flymake-php
    :hook 
    (php-mode . flymake-php-load))
  ;; (require 'flymake-php)
  ;; (add-hook 'php-mode-hook 'flymake-php-load)

  ;; some expand-region stuff


  (defun er/mark-org-heading (level)
    "Marks a heading 0 or more levels up from current subheading"
    (interactive "n" )
    (while (> level 0)
      (org-up-element)
      (setq level (- level 1))
      )
    (org-mark-subtree))

  (defun er/mark-org-parent ()
    "Marks a heading 1 level up from current subheading"
    (interactive  )
    (org-up-element)
    (org-mark-subtree))

  (defun er/mark-org-heading-2 ()
    "Marks a heading 0 or more levels up from current subheading"
    (interactive "n" )
    (let (level 2)
      (while (> level 0)
        (org-up-element)
        (setq level (- level 1))
        ))
    (org-mark-subtree))



  (defun mwp-no-write ()
    (interactive)
    (save-excursion
      (beginning-of-line)
      (when (looking-at org-property-re)
        (let ((myre (match-data) )
              (beg (match-beginning 1))
              (end (match-end 1)))
          (message "actually running")
          (print myre)
          (print beg)
          (print end)
          (put-text-property beg end 'read-only t) ))))
  (defun mwp-write ( )
    (interactive )
    (save-excursion
      (beginning-of-line)
      (when (looking-at org-property-re)
        (let ((myre (match-data) )
              (beg (match-beginning 1))
              (end (match-end 1))
              (inhibit-read-only t))
          (message "actually running")
          (print myre)
          (print beg)
          (print end)
          (remove-text-properties beg end '(read-only)) )))
    )


  ;; open things properly in org-mode
  ;;(setcdr (assq 'system org-file-apps-defaults-gnu ) "xdg-open %s")

;; encryption with easypg
  (use-package epa-file
    :config
    (epa-file-enable)
    (setq epa-file-inhibit-auto-save t)
)


  (use-package org-crypt
    :config
    (org-crypt-use-before-save-magic)
    (setq org-tags-exclude-from-inheritance (quote ("crypt")))
    ;; GPG key to use for encryption
    ;; Either the Key ID or set to nil to use symmetric encryption.
    (setq org-crypt-key nil))

;; add a new timestamp one week later than the previous
  (defun mwp/one-week-later (n)
  )
  ;;; changing timestamps    
  (defun update-org-days (n)
    "Change all org-mode timestamps in the current buffer by N days."
    (interactive "nChange days: ")
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "[[<]" nil t)
        (when (org-at-timestamp-p t)
          (org-timestamp-change n 'day)))))


    (defun mwp-change-dates ()
      (interactive)
      (progn
        (save-excursion
          (setq ts-regex org-element--timestamp-regexp)
          ;; go to timestamp
          (re-search-forward ts-regex)
          (setq mwp-test-value (match-beginning 0))
          (message (number-to-string  (match-beginning 0)))
          (let ((base-date (match-string 1)) ;; this is the timestamp
                (seven-days (seconds-to-time (* 7 24 60 60)))
                (new-ts)
                (week-num 0))
            (message base-date)
            (message "in let!")
            (while (< week-num 12)
              (message "in while!")
              (let ((add-value (seconds-to-time (* week-num 50 24 60 60))))
                (message "in second let")
                (setq new-ts (format-time-string "** <%Y-%m-%d %a>"
                                                 (time-add (date-to-time base-date) add-value)))
                (message new-ts)
                (re-search-forward ts-regex)

                (message (number-to-string  (match-beginning 0)))
                (message (number-to-string  (match-end 0)))
                ;; now we kill the old time stamp, and insert the new one
                (set-mark (match-beginning 0))

                ;; (beginning-of-line)
                (delete-region (match-beginning 0) (match-end 0))
                (insert new-ts)
                (setq week-num (1+ week-num))
                (re-search-forward ts-regex)))
            ))))

    (defun insert-ts+1w ()
      "Insert a timestamp at point that is one week later than the
    last timestamp found in the buffer."
      (interactive)
      (let ((last-ts (car (last (org-element-map (org-element-parse-buffer) 'timestamp
                                  (lambda (timestamp)
                                    (org-element-property :raw-value timestamp)))))))
        (insert last-ts)
        (backward-char 2)
        (org-timestamp-change +7 'day)
        (forward-char 2)
        ))
  (defun insert-ts+7 ()
    (interactive)
    (insert
     (concat ""
             (save-excursion
               (re-search-backward
                (org-re-timestamp 'all))
               (match-string 0)))
     "")
    (org-timestamp-change 7 'day))


;; this is the one I'm currently using
(defun get-ts+7 ()
"returns a string of the form <%Y-%m-d %a> where the date elements are 7 days later
than the previous timestamp in the buffer. No error checking or anything yet."
    (interactive)
    (let ((base-date (save-excursion
                 (re-search-backward
                  (org-re-timestamp 'all))
                 (match-string 0)))
          (result nil))

      (format-time-string "<%Y-%m-%d %a>"
                          (time-add
                           (date-to-time base-date) (days-to-time (1+ 7)))) ))



(defun get-ts+7 (&optional weekly-times)
  "Return a string of the form <%Y-%m-d %a> where the date
elements are 7 days later than the (n - WEEKLY-TIMES timestamp)
in the buffer. That is, if WEEKLY-TIMES is nil or 1, return a
date one week later than the *PREVIOUS* timestamp. If
WEEKLY-TIMES is 2, return a time one week later than the
*SECOND-TO-LAST* timestamp above the previous location.

If there are not enough timestamps, right now it returns the last
found timestamp. "
  (interactive)
  (setq weekly-times (or weekly-times 1))
  (defun ts-search ()
    (save-match-data 
      (goto-char (re-search-backward
                  (org-re-timestamp 'all) nil t))
      (let ((thismatch  (match-string 0)))
        (message "match: %s" thismatch)
        thismatch)))
  (let* (r
         (base-date (save-excursion
                     (cl-dotimes (time weekly-times r)
                       (condition-case nil
                           (progn (setq  r (or (ts-search) r))
                                  (message "r is %s" r))
                         (error
                          (message "Drat, there were %s timestamps, using the last one I found."
                                   (if (= 0 time) "no" time))
                          (return r))))))

        (result nil))
    (message "base-time is %s" base-date)
    (if base-date
        (format-time-string "<%Y-%m-%d %a>"
                            (time-add
                             (date-to-time base-date) (days-to-time (1+ 7))))
      "NO PREVIOUS TIMESTAMP") ))

(defun ts-search-both ()
  (save-match-data
    (let* ((bufts
            (save-match-data
              (set-match-data nil)
              (save-excursion 
                (re-search-backward
                 (org-re-timestamp 'all) nil t)
                (if (match-beginning 0)
                    `(,(match-beginning 0) ,(match-string 0))
                  nil))))
           (ovts (save-match-data (save-excursion  (ts-search-ov)))))
      (cond
       ((and bufts ovts)
        (if (> (car bufts) (car ovts))
            (goto-char (car bufts))
            (cadr bufts)
          (cadr ovts)))
       (bufts
        (goto-char (car bufts))
        (cadr bufts))
       (ovts
        (goto-char (car ovts))
        (cadr ovts))
       (t
        (goto-char (point-min)) nil)
       )
      )))

(defun ts-search-ov ()
  (let* ((ovend   (previous-single-char-property-change (point) 'macro-ov-p))
         (ovs (overlays-at ovend))
         (m  (cl-loop for o in ovs
                      if (string-match (org-re-timestamp 'all) (overlay-get o 'before-string))
                      ;;(goto-char (overlay-start o))
                      return (match-string 0 (overlay-get o 'before-string)))))
    (cond
     (m `(,(point) ,m))
     ((>= (point-min) ovend )
      (goto-char ovend)
      nil)
     (t
      (goto-char ovend)
      (ts-search-ov))
      )))

(defun get-ts+7-inc-ov (&optional weekly-times)
  "Return a string of the form <%Y-%m-d %a> where the date
elements are 7 days later than the (n - WEEKLY-TIMES timestamp)
in the buffer. That is, if WEEKLY-TIMES is nil or 1, return a
date one week later than the *PREVIOUS* timestamp. If
WEEKLY-TIMES is 2, return a time one week later than the
*SECOND-TO-LAST* timestamp above the previous location.

If there are not enough timestamps, right now it returns the last
found timestamp. "
  (interactive)
  (setq weekly-times (or weekly-times 1))
  
  (let* (r
         (base-date (save-excursion
                     (cl-dotimes (time weekly-times r)
                       (condition-case nil
                           (let ((s (ts-search-both)))
                             (if s
                                 (setq r s)
                               (message "Drat, there were %s timestamps, using the last one I found."
                                        (if (= 0 time) "no" time))
                               (return r)))
                         
                         ;; (error
                         ;;  (message "Drat, there were %s timestamps, using the last one I found."
                         ;;           (if (= 0 time) "no" time))
                         ;;  (return r))
                         ))))

        (result nil))
    (message "base-time is %s" base-date)
    (if base-date
        (format-time-string "<%Y-%m-%d %a>"
                            (time-add
                             (date-to-time base-date) (days-to-time (1+ 7))))
      "NO PREVIOUS TIMESTAMP") ))

(defun update-org-days (n)
  "Change all org-mode timestamps in the current buffer by N days."
  (interactive "nChange days: ")
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "[[<]" nil t)
      (when (org-at-timestamp-p t)
        (org-timestamp-change n 'day)))))
;; (update-org-days 200)

(defun insert-ts+1w ()
  "Insert a timestamp at point that is one week later than the
last timestamp found in the buffer."
  (interactive)
  (let ((last-ts (car (last (org-element-map (org-element-parse-buffer) 'timestamp
                              (lambda (timestamp)
                                (org-element-property :raw-value timestamp)))))))
    (insert last-ts)
    (backward-char 2)
    (org-timestamp-change +7 'day)
    ))

(defun mwp-get-ts+7 (initial-list-symbol &optional weekly-times)
  "Return a timestamp 7 days later than the WEEKLY-TIMES-th element of INITIAL-LIST-SYMBOL.
Then add that new date to the value of the list."
  (setq weekly-times (or weekly-times 1))
  (let* ((initial-list (symbol-value initial-list-symbol))
         (base-date (nth (1- weekly-times) initial-list) )
         (new-date (format-time-string  "<%Y-%m-%d %a>" ;; "<%b. %d>"    ;; 
                                       (time-add
                                        (date-to-time base-date) (days-to-time (1+ 7))))))
    (add-to-list initial-list-symbol  new-date )
    ;;(format-time-string "%b . %d" new-date)
    new-date
    ;; (if base-date
    ;;     (format-time-string "<%Y-%m-%d %a>"
    ;;                         (time-add
    ;;                          (date-to-time base-date) (days-to-time (1+ 7))))
    ;;   "NO PREVIOUS TIMESTAMP")
    ))

(defun mwp-show-macros ()
  (interactive)
  (remove-overlays (point-min) (point-max) 'macro-ov-p t)
  (hack-local-variables)
  ;; (message "mwp-classtimes-calibrate: %s" mwp-classtimes-calibrate)
  ;; (message "file-local vars: %s" file-local-variables-alist)
  (save-excursion
    (goto-char (point-min))
    ;; keeping this properties/keywordsstuff b/c I don't quite understand it
    (let* ((keywords nil)
           (properties-regexp (format "\\`EXPORT_%s\\+?\\'"
				      (regexp-opt keywords)))
	   record)
      (while (re-search-forward "{{{[-A-Za-z0-9_]" nil t)
        (unless (save-match-data (org-in-commented-heading-p))
          (let* ((datum (save-match-data (org-element-context)))
	         (type (org-element-type datum))
	         (macro
	          (cond
		   ((eq type 'macro) datum)
		   ;; In parsed keywords and associated node
		   ;; properties, force macro recognition.
		   ((or (and (eq type 'keyword)
			     (member (org-element-property :key datum) keywords))
		        (and (eq type 'node-property)
			     (string-match-p properties-regexp
					     (org-element-property :key datum))))
		    (save-excursion
		      (goto-char (match-beginning 0))
		      (org-element-macro-parser))))))
	    (when macro
	      (let* ((key (org-element-property :key macro))
		     (value (org-macro-expand macro org-macro-templates))
                     (value-ts (ignore-errors
                                 (apply 'encode-time (org-fix-decoded-time
                                                      (org-parse-time-string value)))))
		     (begin (org-element-property :begin macro))
                     (end (save-excursion
                            (goto-char (org-element-property :end macro))
		            (skip-chars-backward " \t")
		            (point)))
		     (signature (list begin
				      macro
				      (org-element-property :args macro))))
	        ;; Avoid circular dependencies by checking if the same
	        ;; macro with the same arguments is expanded at the
	        ;; same position twice.
                (when value-ts
                  (setq value (format-time-string
                               (substring (car org-time-stamp-custom-formats) 1 -1) value-ts)))
	        (cond ((member signature record)
		       (error "Circular macro expansion: %s" key))
		      (value
		       (push signature record)
		       (let ((ov (make-overlay begin end)))
                         (overlay-put ov 'invisible t)
                         (overlay-put ov 'evaporate t)
                         (overlay-put ov 'macro-ov-p t)
		         (overlay-put ov 'before-string value )))
		      ;; Special "results" macro: if it is not defined,
		      ;; simply leave it as-is.  It will be expanded in
		      ;; a second phase.
		      ((equal key "results"))
		      (t
		       ;; (error "Undefined Org macro: %s; aborting"
		       ;;        (org-element-property :key macro))
                       )))))))))
  (org-macro--counter-initialize)
  (setq-local mwp-macro-overlays t)
  (hack-local-variables)
  ;;(run-hooks 'mwp-show-macros-final-hook)
  
  )


(defvar-local mwp-show-macros-final-hook nil )

(defun mwp-hide-macros ()
  (interactive)
  (remove-overlays (point-min) (point-max) 'macro-ov-p t)
  (setq-local mwp-macro-overlays nil)
  )

(defun mwp-toggle-macros ()
  (interactive)
  (if mwp-macro-overlays
      (mwp-hide-macros)
    (mwp-show-macros)) )

(defvar-local mwp-macro-overlays nil)

(defun mwp-macro-advice (&optional a b c d e f &rest g)
  "If hsowing macros, update after doing some things."
  (when mwp-macro-overlays
    (mwp-show-macros)
    ))

;; (advice-add 'org-move-subtree-down :after mwp-macro-advice)

(advice-add 'org-move-subtree-down :after  'mwp-macro-advice)
(advice-add 'org-insert-heading :after  'mwp-macro-advice)
;; (advice-remove 'org-insert-heading   'mwp-macro-advice)
;; (advice-remove 'org-clean-visibility-after-subtree-move  'mwp-macro-advice)

;; helm-bibtex
  (use-package helm

  )
  (use-package helm-org
    :defer 3
    :bind
    (:map org-mode-map ("C-c h o" . helm-org-in-buffer-headings))
)   
  (use-package helm-config
    :after (helm org)
    :config
        (helm-mode 1)

    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
    (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

    (helm-autoresize-mode t)
    (setq helm-buffers-fuzzy-matching t
          helm-recentf-fuzzy-match    t)
    (global-set-key (kbd "M-x") 'helm-M-x)
    (global-set-key (kbd "M-y") 'helm-show-kill-ring)
    (global-set-key (kbd "C-x C-f") 'helm-find-files)
    (global-set-key (kbd "C-x b") 'helm-mini)

    ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
    ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
    ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
    (global-set-key (kbd "C-c h") 'helm-command-prefix)
    (global-unset-key (kbd "C-x c"))


    (when (executable-find "curl")
      (setq helm-google-suggest-use-curl-p nil))

    (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
          helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
          helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
          helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
          helm-ff-file-name-history-use-recentf t)

    (setq helm-grep-ag-command "ag --line-numbers -S --hidden --color --color-match '31;43' --nogroup %s %s %s")
    (setq helm-grep-ag-pipe-cmd-switches '("--color-match '31;43'"))

    ;; (when (executable-find "ack-grep")
    ;;   (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
    ;;         helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))
    (global-set-key (kbd "C-c h c") 'helm-occur)

    (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
    (global-set-key (kbd "C-c h g") 'helm-google-suggest)
    (add-to-list 'helm-completing-read-handlers-alist '(zotxt-completing-read . helm-comp-read )))
  (use-package helm-bibtex
    :after helm-config
    :config

    (defun helm-bibtex-format-pandoc-citation (keys)
      (concat "[" (mapconcat (lambda (key) (concat "@" key)) keys "; ") "]"))

    ;; inform helm-bibtex how to format the citation in org-mode
    ;; (setf (cdr (assoc 'org-mode helm-bibtex-format-citation-functions))
    ;;       'helm-bibtex-format-pandoc-citation)
    (setf (cdr (assoc 'org-mode helm-bibtex-format-citation-functions))
          'helm-bibtex-format-citation-ebib))

(defun helm-swish-e-candidates (query)
  "Generate a list of cons cells (swish-e result . path)."
  (let* ((result (shell-command-to-string
                  (format "swish-e -f ~/.swish-e/index.swish-e -x \"%%r\t%%p\n\" -w %s"
                          (shell-quote-argument query))))
         (lines (s-split "\n" result t))
         (candidates '()))
    (loop for line in lines
          unless (or  (s-starts-with? "#" line)
                      (s-starts-with? "." line))
          collect (cons line (cdr (s-split "\t" line))))))


(defun helm-swish-e (query)
  "Run a swish-e query and provide helm selection buffer of the results."
  (interactive "sQuery: ")
  (helm :sources `(((name . ,(format "swish-e: %s" query))
                    (candidates . ,(helm-swish-e-candidates query))
                    (action . (("open" . (lambda (f)
                                           (find-file (car f)))))))
                   ((name . "New search")
                    (dummy)
                    (action . (("search" . (lambda (f)
                                             (helm-swish-e helm-pattern)))))))))

;;; swish-e.el --- Interface to swish-e

;;; Commentary:
;;

;; This is the configuration file I used.
;; # Example configuration file

;; # where to save the index
;; IndexFile /Users/jkitchin/.swish-e/index-org.swish-e

;; PropertyNames swish-position

;; # Save descriptions for context on search results.
;; StoreDescription XML <desc> 500
;; StoreDescription XML* <desc> 500

;; # index all tags for searching
;; UndefinedMetaTags auto
;; UndefinedXMLAttributes auto

;; Run the index command as:
;; swish-e -c ~/.swish-e/swish-org.conf -S prog -i ~/bin/swish-org-documents.el

;;; Code:

(defvar swish-e-index
  "~/.swish-e/index-org.swish-e"
  "Path to the index for searching.")


(defun helm-swish-e-candidates (query)
  "Generate a list of cons cells (swish-e result . path)."
  (let* ((result (shell-command-to-string
		  (format "swish-e -f %s -x \"<swishrank>\t<swishdocpath>\t<swish-position>\t<swishtitle>\t<swishdescription>\n\" -w %s"
			  swish-e-index
			  (shell-quote-argument query))))
	 (lines (s-split "\n" result t))
	 (candidates '()))
    (loop for line in lines
	  unless (or  (s-starts-with? "#" line)
		      (s-starts-with? "." line))
	  collect  (let* ((fields (s-split "\t" line))
			  (rank (nth 0 fields))
			  (docpath (nth 1 fields))
			  (position (nth 2 fields))
			  (title (nth 3 fields))
			  (description (nth 4 fields)))
		     (cons (format "%4s %s%s\n%s\n"
				   rank title (if (not (string= "" position))
						  (concat  "::" position)
						"")
				   description)
			   docpath)))))


(defun helm-swish-e (query)
  "Run a swish-e query and provide helm selection buffer of the results.
Example queries:
paragraph=foo
src-block.language=python
not foo
foo near5 bar
see http://swish-e.org/docs/swish-search.html
"
  (interactive "sQuery: ")
  (helm :sources `(((name . ,(format "swish-e: %s" query))
		    (multiline)
		    (candidates . ,(helm-swish-e-candidates query))
		    (action . (("open" . (lambda (f)
					   (org-open-link-from-string f))))))
		   ((name . "New search")
		    (dummy)
		    (action . (("search" . (lambda (f)
					     (helm-swish-e helm-pattern)))))))))

(defun swish-e-todo ()
  (interactive)
  (helm-swish-e "todo-keyword=TODO"))

(provide 'swish-e)

;;; swish-e.el ends here

(use-package ox-slack
      :load-path "~/src/ox-slack"
      :pin manual
      :defer nil
      ;; :preface
      ;; (require 'ox-md)
      ;; (require 'ox-gfm)
      ;; :after (org )
      ;; :bind
      ;; ("C-c W s" . org-slack-export-to-clibpoard-as-slack)
      )

(defun ora-org-to-html-to-clipboard ()
  "Export region to HTML, and copy it to the clipboard."
  (interactive)
  (let
      ((org-html-postamble nil)
       (org-html-xml-declaration nil)
       (org-html-preamble nil))

    (org-export-to-file 'html "/tmp/org.html")
    (apply ; comment
     'start-process "xclip" "*xclip*"
     (split-string
      "xclip -verbose -i /tmp/org.html -t text/html -selection clipboard" " "))))

(defun ora-org-to-slack-to-clipboard ()
  "Export region to md, and copy it to the clipboard."
  (interactive)
  (let
      ((org-html-postamble nil)
       (org-html-xml-declaration nil)
       (org-html-preamble nil))

    (org-export-to-file 'slack "/tmp/org.slack")
    (apply
     'start-process "xclip" "*xclip*"
     (split-string
      "xclip -verbose -i /tmp/org.slack -t text/plain -selection clipboard" " "))))

(defun ora-org-export-to-clipboard-as-slack ()
  "Export region to FMT, and copy to the kill ring for pasting into other programs."
  (interactive)
  (let* ((org-export-with-toc nil)
         (org-export-with-smart-quotes nil))
    (kill-new (org-export-as 'slack) ))
  )

(defun mwp-org-export-to-clipboard (fmt)
  "Export region to FMT, and copy to the kill ring for pasting into other programs."
  (interactive)
  (let* ((org-export-with-toc nil)
         (org-export-with-smart-quotes nil))
    (kill-new (org-export-as fmt nil nil t))
    )
  )

;; (use-package ox-md
;;   :load-path: "~/src/org-mode/emacs/site-lisp/org/"
;;   :after org
;;   :config
;;   (org-export-register-backend 'md)
;;   (require 'ox-gfm)

;;   )
;; ;;  (require 'ox-md)
;; ;;(org-export-register-backend 'gfm)
;; ;; (with-eval-after-load "ox-md" )
;; (with-eval-after-load "ox-gfm" (org-export-register-backend 'gfm))




;; ;;(global-set-key (kbd  "C-c W h") 'ora-org-to-html-to-clipboard)

;;(global-set-key (kbd "C-c W s") 'ora-org-export-to-clipboard-as-slack)

nil

(defun mwp/html2org-clipboard ()
  "Convert clipboard contents from HTML to Org and then paste (yank)."
  (interactive)
  (kill-new (shell-command-to-string "xclip -o -t TARGETS | grep -q text/html && (xclip -o -t text/html | pandoc -f html -t json | pandoc -f json -t org) || xclip -o"))
  (yank))

(global-set-key (kbd "C-M-y") 'mwp/html2org-clipboard)

;; ibuffer
(use-package ibuffer
  :config


  (setq ibuffer-saved-filter-groups
        (quote (("default"
                 ("dired" (mode . dired-mode))
                 ("java" (mode . java-mode))
                 ("org" (mode . org-mode))
                 ("JS" (or (mode . js2-mode) (mode . json-mode)))
                 ("web" (or (mode . web-mode) (mode . html-mode) (mode . css-mode)))
                 ("mu4e" (name . "\*mu4e\*"))
                 ("elisp" (mode . emacs-lisp-mode))
                 ("xml" (mode . nxml-mode))))))    

  (setq ibuffer-show-empty-filter-groups nil)

  (add-hook 'ibuffer-mode-hook 
            (lambda () 
              (ibuffer-switch-to-saved-filter-groups "default")
              (ibuffer-filter-by-filename ".")))) ;; to show only dired and files buffers


;; org-mobile
(setq org-mobile-directory "~/Dropbox/MobileOrg")
;; ace
;; 
;; enable a more powerful jump back function from ace jump mode
;;
(define-key global-map (kbd "C-c C-SPC") 'ace-jump-mode)
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x C-SPC") 'ace-jump-mode-pop-mark)

;; which function mode
(use-package which-func)
;;(add-to-list 'which-func-modes 'org-mode)
(which-func-mode 1)


;; open links
;; (setcdr (assq 'system org-file-apps-defaults-gnu ) '(call-process "xdg-open" nil 0 nil file))
;; ox-reveal, change initialization options


;; github (pull requests!!! )

(defun endless/visit-pull-request-url ()
  "Visit the current branch's PR on Github."
  (interactive)
  (browse-url
   (format "https://github.com/%s/pull/new/%s"
           (replace-regexp-in-string
            "\\`.+github\\.com:\\(.+\\)\\.git\\'" "\\1"
            (magit-get "remote"
                       (magit-get-push-remote)
                       "url"))
           (magit-get-current-branch))))

;; (defun endless/visit-pull-request-url ()
;;   "Visit the current branch's PR on Github."
;;   (interactive)
;;   (browse-url
;;    (format "https://github.com/%s/compare/%s"
;;            (replace-regexp-in-string
;;             "\\`.+github\\.com:\\(.+\\)\\.git\\'" "\\1"
;;             (magit-get "remote"
;;                        (magit-get-current-remote)
;;                        "url"))
;;            (magit-get-current-branch))))

(eval-after-load 'magit
  '(define-key magit-mode-map "V"
     #'endless/visit-pull-request-url))


;; change default c-u values for C-c C-l
(defun mwp-org-insert-link (&optional complete-file link-location default-description)
  "insert a link at location, but insert a letave link by default, and absolute one only by necessity."
  (interactive)
  (cond
   ((eq current-prefix-arg nil)
    (let ((current-prefix-arg 4)) 
      (call-interactively 'org-insert-link)))
   (t
    (let ((current-prefix-arg nil)) 
      (call-interactively 'org-insert-link)))
   ;;(t (call-interactively 'org-insert-link))
   ))

;; enable HTML email from org
(use-package org-mime
  :ensure t
  :load-path "~/src/org-mime/"
  :config
  ;; pretty blockquotes
  (add-hook 'org-mime-html-hook
            (lambda ()
              (org-mime-change-element-style
               "blockquote" "margin: 0 0 0 .8ex; border-left: 1px solid #ccc; padding-left: 1ex;")))
  (setq org-mime-library 'mu4e)
  (setq org-mime-debug t)
  ;; setup org-mime for wanderlust
  ;; (setq org-mime-library 'semi)
  ;; or for gnus/message-mode
  (setq org-mime-library 'mu4e))

;; easy access to htmlize in message-mode
(add-hook 'message-mode-hook
          (lambda ()
            (local-set-key "\C-c\M-o" 'org-mime-htmlize)))

;; uncomment this to use the org-mome native functions for htmlizing.
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (local-set-key "\C-c\M-o" 'org-mime-org-buffer-htmlize)))

;; uncomment to displyay src blocks with a dark background
;; (add-hook 'org-mime-html-hook
;;           (lambda ()
;;             (org-mime-change-element-style
;;              "pre" (format "color: %s; background-color: %s; padding: 0.5em;"
;;                            "#E6E1DC" "#232323"))))


(setq user-mail-address "matt.price@utoronto.ca"
      user-full-name "Matt Price")

(defun mwp-org-get-parent-headline ()
  "Acquire the parent headline & return."
  (save-excursion
    (org-mark-subtree)
    (re-search-backward  "^\\* ")
    (nth 4 (org-heading-components))))

(defun mwp-send-subtree-with-attachments ()
  "org-mime-subtree and HTMLize"
  (interactive)
  ;;(org-mark-subtree)
  (let ((attachments (mwp-org-attachment-list))
        (subject  (mwp-org-get-parent-headline)))
    ;;(insert "Hello " (nth 4 org-heading-components) ",\n")
    ;;(org-mime-subtree)
    (org-mime-send-subtree)
    (insert "\nBest,\nMP.\n")
    (message-goto-body)
    (insert "Hello,\n\nAttached are the comments from your assignment.\n")
    ;; (message "subject is" )
    ;; (message subject)
    ;;(message-to)
    (org-mime-htmlize)
    ;; (mu4e-compose-mode)
    ;; this comes from gnorb
    ;; I will reintroduce it if I want to reinstate questions.
    ;; (map-y-or-n-p
    ;;  ;; (lambda (a) (format "Attach %s to outgoing message? "
    ;;  ;;                    (file-name-nondirectory a)))
    ;; (lambda (a)
    ;;   (mml-attach-file a (mm-default-file-encoding a)
    ;;                    nil "attachment"))
    ;; attachments
    ;; '("file" "files" "attach"))
    ;; (message "Attachments: %s" attachments)
    (dolist (a attachments) (message "Attachment: %s" a) (mml-attach-file a (mm-default-file-encoding a) nil "attachment"))
    (message-goto-to)
    ))

;; add a keybinding for org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\C-c\M-o" 'mwp-send-subtree-with-attachments)))

;; stolen from gnorb; finds attachments in subtree
(defun mwp-org-attachment-list (&optional id)
  "Get a list of files (absolute filenames) attached to the
current heading, or the heading indicated by optional argument ID."
  (when (featurep 'org-attach)
    (let* ((attach-dir (save-excursion
                         (when id
                         (org-id-goto id))
                         (org-attach-dir t)))
           (files
            (mapcar
             (lambda (f)
               (expand-file-name f attach-dir))
             (org-attach-file-list attach-dir))))
      files)))

(use-package org-download)
(use-package org-attach
  :config
  (defun org-attach-attach (file &optional visit-dir method)
  "Move/copy/link FILE into the attachment directory of the current task.
If VISIT-DIR is non-nil, visit the directory with dired.
METHOD may be `cp', `mv', `ln', `lns' or `url' default taken from
`org-attach-method'."
  (interactive
   (list
    (read-file-name "File to keep as an attachment:"
                    (or (progn
                          (require 'dired-aux)
                          (dired-dwim-target-directory))
                        default-directory))
    current-prefix-arg
    nil))
  (setq method (or method org-attach-method))
  (let ((basename (file-name-nondirectory file)))
    (when (and org-attach-file-list-property (not org-attach-inherited))
      (org-entry-add-to-multivalued-property
       (point) org-attach-file-list-property basename))
    (let* ((attach-dir (org-attach-dir t))
           (fname (expand-file-name basename attach-dir)))
      (cond
       ((eq method 'mv) (rename-file file fname))
       ((eq method 'cp) (copy-file file fname))
       ((eq method 'ln) (add-name-to-file file fname))
       ((eq method 'lns) (make-symbolic-link file fname t))
       ((eq method 'url) (url-copy-file file fname)))
      (when org-attach-commit
        (org-attach-commit))
      (org-attach-tag)
      (cond ((eq org-attach-store-link-p 'attached)
             (org-attach-store-link fname))
            ((eq org-attach-store-link-p t)
             (org-attach-store-link file)))
      (if visit-dir
          (dired attach-dir)
        (message "File %S is now a task attachment." basename))))))
;; extending the dnd functionality
;; but doesn't actually work... 
(defun mwp-org-file-link-dnd (uri action)
    "When in `org-mode' and URI points to local file, 
  add as attachment and also add a link. Otherwise, 
  pass URI and Action back to dnd dispatch"
    (let ((img-regexp "\\(png$\\|jp[e]?g$\\)")
          (newuri (replace-regexp-in-string "file:///" "/" uri)))
      (cond ((eq major-mode 'org-mode)
             (message "Hi! newuri: %s " (file-relative-name newuri))
             (cond ((string-match img-regexp newuri)
                    (insert "#+ATTR_ORG: :width 300\n")
                    (insert (concat  "#+CAPTION: " (read-input "Caption: ") "\n"))
                    (insert (format "[[%s]]" uri))
                    (org-display-inline-images t t))
                   (t 
                    (org-attach-new newuri)
                    (insert (format "[[%s]]" uri))))
             )
            (t
             (let ((dnd-protocol-alist
                    (rassq-delete-all
                     'mwp-org-file-link-dnd
                     (copy-alist dnd-protocol-alist))))
               (dnd-handle-one-url nil action uri)))
            )))

  ;; add a new function that DOESN'T open the attachment!
(defun org-attach-new-dont-open (file)
    "Create a new attachment FILE for the current task.
  The attachment is created as an Emacs buffer."
    (interactive "sCreate attachment named: ")
    (when (and org-attach-file-list-property (not org-attach-inherited))
      (org-entry-add-to-multivalued-property
       (point) org-attach-file-list-property file))
    )

(defun mwp-org-file-link-enable ()
    "Enable file drag and drop attachments."
    (unless (eq (cdr (assoc "^\\(file\\)://" dnd-protocol-alist))
                'mwp-org-file-link-dnd)
      (setq dnd-protocol-alist
            `(("^\\(file\\)://" . mwp-org-file-link-dnd) ,@dnd-protocol-alist))))

(defun mwp-org-file-link-disable ()
  "Enable file drag and drop attachments."
  (if (eq (cdr (assoc "^\\(file\\)://" dnd-protocol-alist))
              'mwp-org-file-link-dnd)
      (rassq-delete-all
       'mwp-org-file-link-dnd
       dnd-protocol-alist)

    ))

(mwp-org-file-link-enable)

(org-add-link-type
   "attachfile"
   (lambda (link-string) (org-open-file link-string))
   ;; formatting
   (lambda (keyword desc format)
     (cond
      ((eq format 'html) (source-data-uri keyword)); no output for html
      ((eq format 'latex)
       ;; write out the latex command
       (format "\\attachfile{%s}" keyword)))))

(  defun source-data-uri (source)
    "Encode the string in SOURCE to a data uri."
    (format
     "<a class=\"org-source\" href=\"data:text/plain;charset=US-ASCII;base64,%s\">source</a>"
     (base64-encode-string source)))

;; wrapper for save-buffer ignoring arguments
(defun bjm/save-buffer-no-args ()
  "Save buffer ignoring arguments"
  (save-buffer))

(use-package pdf-tools
 ;; :pin manual ;; manually update
 :config
 ;; initialise
 (pdf-tools-install)
 ;; open pdfs scaled to fit page
 ;; not quite sure I want this
 ;; (setq-default pdf-view-display-size 'fit-page)
 ;; automatically annotate highlights
 ;; when set to true this makes highlighting also open up a comment box
 (setq pdf-annot-activate-created-annotations nil)
 ;; use normal isearch
 ;; (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
 (define-key pdf-view-mode-map (kbd "M-h") 'pdf-annot-add-highlight-markup-annotation)
 (define-key pdf-view-mode-map (kbd "<tab>") 'pdf-annot-add-highlight-markup-annotation)
 ;; keyboard shortcuts
 (define-key pdf-view-mode-map (kbd "h") 'pdf-annot-add-highlight-markup-annotation)
 (define-key pdf-view-mode-map (kbd "t") 'pdf-annot-add-text-annotation)
 (define-key pdf-view-mode-map (kbd "D") 'pdf-annot-delete)
 ;; wait until map is available
 (with-eval-after-load "pdf-annot"
   (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<return>") 'pdf-annot-edit-contents-commit)
   (define-key pdf-annot-edit-contents-minor-mode-map (kbd "<S-return>") 'newline)
   ;; DON;T ACTUALLY OD THIS BY DEFAULT
   ;; (setq pdf-annot-activate-created-annotations t)
   ;; save after adding comment
   (advice-add 'pdf-annot-edit-contents-commit :after 'bjm/save-buffer-no-args)

 ))
;; better learn the right place to put this code!
    (eval-after-load 'org '(use-package org-pdfview))
  (add-to-list 'org-file-apps '("\\.pdf\\'" . (lambda (file link) (org-pdfview-open link))))

;; modified from https://github.com/politza/pdf-tools/pull/133 

(defun mwp/pdf-multi-extract (sources)
  "Helper function to print highlighted text from a list of pdf's, with one org header per pdf, 
and links back to page of highlight."
  (let (
        (output ""))
    (dolist (thispdf sources)
      (setq output (concat output (pdf-annot-markups-as-org-text thispdf nil level ))))
    (princ output))
  )

;; this is stolen from https://github.com/pinguim06/pdf-tools/commit/22629c746878f4e554d4e530306f3433d594a654
(defun pdf-annot-edges-to-region (edges)
  "Attempt to get 4-entry region \(LEFT TOP RIGHT BOTTOM\) from several edges.
We need this to import annotations and to get marked-up text, because annotations
are referenced by its edges, but functions for these tasks need region."

  (let ((left0 (nth 0 (car edges)))
        (top0 (nth 1 (car edges)))
        (bottom0 (nth 3 (car edges)))
        (top1 (nth 1 (car (last edges))))
        (right1 (nth 2 (car (last edges))))
        (bottom1 (nth 3 (car (last edges))))
        (n (safe-length edges)))
    ;; we try to guess the line height to move
    ;; the region away from the boundary and
    ;; avoid double lines
    (list left0
          (+ top0 (/ (- bottom0 top0) 2))
          right1
          (- bottom1 (/ (- bottom1 top1) 2 )))))

(defun pdf-annot-markups-as-org-text (pdfpath &optional title level)
  "Acquire highligh annotations as text, and return as org-heading"

  (interactive "fPath to PDF: ")  
  (let* ((outputstring "") ;; the text to be returned
         (title (or title (replace-regexp-in-string "-" " " (file-name-base pdfpath ))))
         (level (or level (1+ (org-current-level)))) ;; I guess if we're not in an org-buffer this will fail
         (levelstring (make-string level ?*)) ;; set headline to proper level
         (annots (sort (pdf-info-getannots nil pdfpath)  ;; get and sort all annots
                       'pdf-annot-compare-annotations))
         )
    ;; create the header
    (setq outputstring (concat levelstring " Quotes From " title "\n\n")) ;; create heading

    ;; extract text
    (mapc
     (lambda (annot) ;; traverse all annotations
       (if (eq 'highlight (assoc-default 'type annot))
           (let* ((page (assoc-default 'page annot))
                  ;; use pdf-annot-edges-to-region to get correct boundaries of highlight
                  (real-edges (pdf-annot-edges-to-region
                               (pdf-annot-get annot 'markup-edges)))
                  (text (or (assoc-default 'subject annot) (assoc-default 'content annot)
                            (replace-regexp-in-string "\n" " " (pdf-info-gettext page real-edges nil pdfpath)
                                                      ) ))

                  (height (nth 1 real-edges)) ;; distance down the page
                  ;; use pdfview link directly to page number
                  (linktext (concat "[[pdfview:" pdfpath "::" (number-to-string page) 
                                    "++" (number-to-string height) "][" title  "]]" ))
                  )
             (setq outputstring (concat outputstring text " ("
                                        linktext ", " (number-to-string page) ")\n\n"))
             )))
     annots)
    outputstring ;; return the header
    )
  )

(org-add-link-type "pdfquote" 'org-pdfquote-open 'org-pdfquote-export)

(defun org-pdfquote-open (link)
  "Open a new buffer with all markup annotations in an org headline."
  (interactive)
  (pop-to-buffer
   (format "*Quotes from %s*"
           (file-name-base link)))
  (org-mode)
  (erase-buffer)
  (insert (pdf-annot-markups-as-org-text link nil 1))
  (goto-char 0)
  )

(defun org-pdfquote-export (link description format)
  "Export the pdfview LINK with DESCRIPTION for FORMAT from Org files."
  (let* ((path (when (string-match "\\(.+\\)::.+" link)
                 (match-string 1 link)))
         (desc (or description link)))
    (when (stringp path)
      (setq path (org-link-escape (expand-file-name path)))
      (cond
       ((eq format 'html) (format "<a href=\"%s\">%s</a>" path desc))
       ((eq format 'latex) (format "\href{%s}{%s}" path desc))
       ((eq format 'ascii) (format "%s (%s)" desc path))
       (t path)))))

(defun org-pdfquote-complete-link ()
  "Use the existing file name completion for file.
Links to get the file name, then ask the user for the page number
and append it."                                  

  (replace-regexp-in-string "^file:" "pdfquote:" (org-file-complete-link)))

(eval-after-load 'pdf-view 
                    '(define-key pdf-view-mode-map (kbd "M-h") 'pdf-annot-add-highlight-markup-annotation))
(eval-after-load 'pdf-view 
                    '(define-key pdf-view-mode-map (kbd "<tab>") 'pdf-annot-add-highlight-markup-annotation))

(use-package pdf-virtual
:defer t ;; wil lbe loaded by pdf-tools so defer t is ok
:config
(pdf-virtual-global-minor-mode)
;; probably a good idea to add some key bindings too
)

(defvar mwp-pdf-selected-pages '())

(defun mwp-pdf-select-page ()
  "Add current page to list of selected pages."
  (interactive)
  (add-to-list 'mwp-pdf-selected-pages (pdf-view-current-page) t)
  (message "added current page to selection"))

(defun mwp-pdf-extract-selected-pages (file)
  "Save selected pages to FILE."
  (interactive "FSave as: ")
  (setq mwp-pdf-selected-pages (sort mwp-pdf-selected-pages #'<))
  (start-process "pdfjam" "*pdfjam*"
                 "pdfjam"
                 (buffer-file-name)
                 (mapconcat #'number-to-string
                            mwp-pdf-selected-pages
                            ",")
                 "-o"
                 (expand-file-name file)))

(define-key pdf-view-mode-map "S" #'mwp-pdf-select-page)

(use-package elfeed
  :commands elfeed 
  :config
  (define-key elfeed-search-mode-map (kbd "<tab>") 'mwp/elfeed-star)
  (define-key elfeed-search-mode-map (kbd "C-S-u") 'elfeed-search-fetch)
  (define-key elfeed-search-mode-map (kbd "x") 'elfeed-search-update--force)
  (define-key elfeed-search-mode-map (kbd "d") 'elfeed-search-untag-all-unread)

  (defun mwp/elfeed-star ()
    "add a star tag to marked"

    (interactive)
    (elfeed-search-tag-all (list starred))
    )

  (defun mwp/elfeed-star ()
    "Apply TAG to all selected entries."
    (interactive )
    (let* ((entries (elfeed-search-selected))
           (tag (intern "starred")))

      (cl-loop for entry in entries do (elfeed-tag entry tag))
      (mapc #'elfeed-search-update-entry entries)
      (unless (use-region-p) (forward-line))))

  (setq elfeed-use-curl t)
  ;; (use-package elfeed-goodies)

  ;; (elfeed-goodies/setup)
  )

(defface elfeed-search-starred-title-face
 '((t :foreground "#f77"))
 "Marks a starred Elfeed entry.")

(use-package org-grading
  :load-path "/home/matt/src/org-grading"
  :after (:any org org-plus-contrib)
  :config )

(use-package org-lms
  :load-path "/home/matt/src/org-grading"
  :pin manual
  ;; :ensure t
  :after org
  ;; :commands (org-lms-setup org-lms-get-courseid)
  :config 
  (setq org-lms-baseurl "https://q.utoronto.ca/api/v1/")
  (setq org-lms-token (password-store-get "q.utoronto.ca")) )

(add-to-list 'org-file-apps '("\\.docx\\'" . "/usr/bin/libreoffice %s"))
(add-to-list 'org-file-apps '("\\.doc\\'" . "/usr/bin/libreoffice %s"))
(add-to-list 'org-file-apps '("\\.odt\\'" . "/usr/bin/libreoffice %s"))

(if (require 'toc-org nil t)
    (add-hook 'org-mode-hook 'toc-org-enable)
  (warn "toc-org not found"))

;; abbrevs
;; improved autocorrect, with a decent keybinding
(define-key ctl-x-map "\C-i" 'endless/ispell-word-then-abbrev)

;; (use-package key-chord)
;; (key-chord-mode 1) 
;; This one was drifing me crazy! 
;; (key-chord-define-global "FF" 'helm-find-files)
;; (key-chord-define-global "BB" 'helm-mini)

(setq package-check-signature nil)


(use-package org-gcal
  :ensure t
  :after org
  :config
  (setq org-gcal-client-id "335456863204-npccoru6jvb94ka8u6emlrct66m2ous2.apps.googleusercontent.com"
        org-gcal-client-secret "3yjcG1N1KnFzdn_XP4n28UXW"
        org-gcal-file-alist '(("moptop99@gmail.com" .  "~/Dropbox/GTD/gcal.org")
                              ("2qkj7vq2514glpmq3c7mn3ro90@group.calendar.google.com" . "~/Dropbox/GTD/Maceo-cal.org")
                              ("ekvdm17nis4qd2j4h4djrdfvh0@group.calendar.google.com" . "~/Dropbox/GTD/EDGI-cal.org")))
  (add-to-list 'org-agenda-files "~/Dropbox/GTD/gcal.org")
  (add-to-list 'org-agenda-files "~/Dropbox/GTD/Maceo-cal.org")
  (add-to-list 'org-agenda-files "~/Dropbox/GTD/EDGI-cal.org")
  (add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))
  (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync) )))

(defun org-meta-return (&optional arg)
  "Insert a new heading or wrap a region in a table.
Calls `org-insert-heading', `org-insert-item' or
`org-table-wrap-region', depending on context.  When called with
an argument, unconditionally call `org-insert-heading'."
  (interactive "P")
  (org-check-before-invisible-edit 'insert)
  (or (run-hook-with-args-until-success 'org-metareturn-hook)
      (call-interactively (cond (arg #'org-insert-heading)
                                ((org-at-table-p) #'org-table-wrap-region)
                                ((org-in-item-p) #'org-insert-item)
                                ((org-in-src-block-p)
                                 (lambda ()
                                   (interactive)
                                   (org-babel-demarcate-block)
                                   (org-insert-heading)))
                                (t #'org-insert-heading)))))

(use-package org 
  :config
  (setq org-src-restore-window-config nil)
  (defun org-edit-src-exit ()
    "Kill current sub-editing buffer and return to source buffer."
    (interactive)
    (unless (org-src-edit-buffer-p) (error "Not in a sub-editing buffer"))
    (let* ((beg org-src--beg-marker)
	   (end org-src--end-marker)
	   (write-back org-src--allow-write-back)
	   (remote org-src--remote)
	   (coordinates (and (not remote)
			     (org-src--coordinates (point) 1 (point-max))))
	   (code (and write-back (org-src--contents-for-write-back))))
      (set-buffer-modified-p nil)
      ;; Switch to source buffer.  Kill sub-editing buffer.
      (let ((edit-buffer (current-buffer))
	    (source-buffer (marker-buffer beg)))
        (unless source-buffer (error "Source buffer disappeared.  Aborting"))
        (org-src-switch-to-buffer source-buffer 'exit)
        (kill-buffer edit-buffer))
      ;; Insert modified code.  Ensure it ends with a newline character.
      (org-with-wide-buffer
       (when (and write-back (not (equal (buffer-substring beg end) code)))
         (undo-boundary)
         (goto-char beg)
         (delete-region beg end)
         (let ((expecting-bol (bolp)))
	   (insert code)
	   (when (and expecting-bol (not (bolp))) (insert "\n")))))
      ;; If we are to return to source buffer, put point at an
      ;; appropriate location.  In particular, if block is hidden, move
      ;; to the beginning of the block opening line.
      (unless remote
        (goto-char beg)
        (cond
         ;; Block is hidden; move at start of block.
         ((cl-some (lambda (o) (eq (overlay-get o 'invisible) 'org-hide-block))
		   (overlays-at (point)))
	  (beginning-of-line 0))
         (write-back (org-src--goto-coordinates coordinates beg end))))
      ;; Clean up left-over markers and restore window configuration.
      (set-marker beg nil)
      (set-marker end nil)
      (unless (eq 'current-window org-src-window-setup)
        (when org-src--saved-temp-window-config
          (set-window-configuration org-src--saved-temp-window-config)
          (setq org-src--saved-temp-window-config nil)))))
          (setq org-src-window-setup 'current-window))

(use-package org
:config
(defun endless/org-eob ()
  "Move to end of content, then end of buffer."
  (interactive)
  (unless (use-region-p)
    (push-mark))
  (if (looking-at-p "\n\\* COMMENT Footer")
      (goto-char (point-max))
    (goto-char (point-min))
    (if (search-forward "\n* COMMENT Footer"
                        nil 'noerror)
        (goto-char (match-beginning 0))
      (goto-char (point-max)))))
(define-key org-mode-map [remap end-of-buffer]
  #'endless/org-eob))

(defun disable-flycheck-in-org-src-block ()
  (setq-local flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(add-hook 'org-src-mode-hook 'disable-flycheck-in-org-src-block)
(remove-hook 'org-src-mode-hook 'disable-fylcheck-in-org-src-block)

(use-package org-table
  :defer t
  :config
  (progn
;;;; Table Field Marking
    (defun org-table-mark-field ()
      "Mark the current table field."
      (interactive)
      ;; Do not try to jump to the beginning of field if the point is already there
      (when (not (looking-back "|[[:blank:]]?"))
        (org-table-beginning-of-field 1))
      (set-mark-command nil)
      (org-table-end-of-field 1))

    (defhydra hydra-org-table-mark-field
      (:body-pre (org-table-mark-field)
       :color red
       :hint nil)
      " ^^      ^up^     ^^
   ^^      _p_     ^^
left _b_  selection  _f_ right \rarr          | Org table mark field |
   ^^      _n_     ^^
   ^^      ^down^     ^^ "
      ("x" exchange-point-and-mark "exchange point/mark")
      ("f" (lambda (arg)
             (interactive "p")
             (when (eq 1 arg)
               (setq arg 2))
             (org-table-end-of-field arg)))
      ("b" (lambda (arg)
             (interactive "p")
             (when (eq 1 arg)
               (setq arg 2))
             (org-table-beginning-of-field arg)))
      ("n" next-line)
      ("p" previous-line)
      ("q" nil "cancel" :color blue))

    (bind-keys
     :map org-mode-map
     :filter (org-at-table-p)
     ("S-SPC" . hydra-org-table-mark-field/body))))

(use-package ob-html-chrome
  :ensure t)

(use-package ob-browser
  :ensure t)

(defun org-html--format-image (source attributes info)
  "Return \"img\" tag with given SOURCE and ATTRIBUTES.
SOURCE is a string specifying the location of the image.
ATTRIBUTES is a plist, as returned by
`org-export-read-attribute'.  INFO is a plist used as
a communication channel."
  ;; (org-html--svg-image source attributes info)
  (org-html-close-tag
   "img"
   (org-html--make-attribute-string
    (org-combine-plists
     (list :src source
	   :alt (if (string-match-p "^ltxpng/" source)
		    (org-html-encode-plain-text
		     (org-find-text-property-in-string 'org-latex-src source))
		  (file-name-nondirectory source)))
     attributes))
   info))

(use-package scimax-utils
  :load-path "~/src/scimax"
  :pin manual
  :bind
  ("<f9>" . hotspots)
  :config
  (setq scimax-user-hotspot-locations
        '(("init file" . "~/.emacs.d/emacs-init.org")
          ("Reference File" . "~/GTD/Reference.org")
          ("Scratch Buffer" . "*scratch*")
          ("Password Safe" . "~/GTD/keep-it-safe.org.gpg")
          ("DH Lectures" . "~/DH/Lectures.org")
          ))
  (setq scimax-user-hotspot-commands
        '(("open mu4e" . mu )
          ("bury buffer" . bury-buffer
          )))
  (add-to-list 'process-environment "EMACS_CHILD=t"))

(use-package hydra
  :ensure t
  )

;; adapted from https://github.com/abo-abo/hydra/blob/master/hydra-ox.el
  ;;; hydra-ox.el --- Org mode export widget implemented in Hydra

  ;; Copyright (C) 2015  Free Software Foundation, Inc.

  ;; Author: Oleh Krehel

  ;; This file is part of GNU Emacs.

  ;; GNU Emacs is free software: you can redistribute it and/or modify
  ;; it under the terms of the GNU General Public License as published by
  ;; the Free Software Foundation, either version 3 of the License, or
  ;; (at your option) any later version.

  ;; GNU Emacs is distributed in the hope that it will be useful,
  ;; but WITHOUT ANY WARRANTY; without even the implied warranty of
  ;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ;; GNU General Public License for more details.

  ;; You should have received a copy of the GNU General Public License
  ;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

  ;;; Commentary:
  ;;
  ;; This shows how a complex dispatch menu can be built with Hydra.

  ;;; Code:

  (require 'hydra)
  (require 'org)
  (declare-function org-html-export-as-html 'ox-html)
  (declare-function org-html-export-to-html 'ox-html)
  (declare-function org-latex-export-as-latex 'ox-latex)
  (declare-function org-latex-export-to-latex 'ox-latex)
  (declare-function org-latex-export-to-pdf 'ox-latex)
  (declare-function org-ascii-export-as-ascii 'ox-ascii)
  (declare-function org-ascii-export-to-ascii 'ox-ascii)

  (defhydradio hydra-ox ()
    (body-only "Export only the body.")
    (export-scope "Export scope." [buffer subtree])
    (async-export "When non-nil, export async.")
    (visible-only "When non-nil, export visible only")
    (force-publishing "Toggle force publishing"))

  (defhydra hydra-ox-html (:color blue)
    "ox-html"
    ("H" (org-html-export-as-html
          hydra-ox/async-export
          (eq hydra-ox/export-scope 'subtree)
          hydra-ox/visible-only
          hydra-ox/body-only)
         "As HTML buffer")
    ("h" (org-html-export-to-html
          hydra-ox/async-export
          (eq hydra-ox/export-scope 'subtree)
          hydra-ox/visible-only
          hydra-ox/body-only) "As HTML file")
    ("o" (org-open-file
          (org-html-export-to-html
           hydra-ox/async-export
           (eq hydra-ox/export-scope 'subtree)
           hydra-ox/visible-only
           hydra-ox/body-only)) "As HTML file and open")
    ("b" hydra-ox/body "back")
    ("q" nil "quit"))

  (defhydra hydra-ox-gfm (:color blue)
    "ox-gfm"
    ("M" (org-gfm-export-as-markdown
          hydra-ox/async-export
          (eq hydra-ox/export-scope 'subtree)
          hydra-ox/visible-only
          hydra-ox/body-only)
         "As GFM buffer")
    ("m" (org-gfm-export-to-markdown
          hydra-ox/async-export
          (eq hydra-ox/export-scope 'subtree)
          hydra-ox/visible-only
          hydra-ox/body-only) "As GFM file")
    ("o" (org-open-file
          (org-gfm-export-to-markdown
           hydra-ox/async-export
           (eq hydra-ox/export-scope 'subtree)
           hydra-ox/visible-only
           hydra-ox/body-only)) "As GFM file and open")
    ("b" hydra-ox/body "back")
    ("q" nil "quit"))

  (defhydra hydra-ox-latex (:color blue)
    "ox-latex"
    ("L" org-latex-export-as-latex "As LaTeX buffer")
    ("l" org-latex-export-to-latex "As LaTeX file")
    ("p" org-latex-export-to-pdf "As PDF file")
    ("o" (org-open-file (org-latex-export-to-pdf)) "As PDF file and open")
    ("b" hydra-ox/body "back")
    ("q" nil "quit"))

  (defhydra hydra-ox-text (:color blue)
    "ox-text"
    ("A" (org-ascii-export-as-ascii
          nil nil nil nil
          '(:ascii-charset ascii))
         "As ASCII buffer")

    ("a" (org-ascii-export-to-ascii
          nil nil nil nil
          '(:ascii-charset ascii))
         "As ASCII file")
    ("L" (org-ascii-export-as-ascii
          nil nil nil nil
          '(:ascii-charset latin1))
         "As Latin1 buffer")
    ("l" (org-ascii-export-to-ascii
          nil nil nil nil
          '(:ascii-charset latin1))
         "As Latin1 file")
    ("U" (org-ascii-export-as-ascii
          nil nil nil nil
          '(:ascii-charset utf-8))
         "As UTF-8 buffer")
    ("u" (org-ascii-export-to-ascii
          nil nil nil nil
          '(:ascii-charset utf-8))
         "As UTF-8 file")
    ("b" hydra-ox/body "back")
    ("q" nil "quit"))

(defhydra hydra-ox-hugo (:color blue)
  "ox-hugo"
  ("H" (org-hugo-export-wim-to-md
        hydra-ox/async-export
        (eq hydra-ox/export-scope 'subtree)
        hydra-ox/visible-only
        hydra-ox/body-only)
       "As HTML buffer")
  ("h" (org-hugo-export-to-md
        hydra-ox/async-export
        (eq hydra-ox/export-scope 'subtree)
        hydra-ox/visible-only
        hydra-ox/body-only) "As HTML file")
  ("o" (org-open-file
        (org-hugo-export-to-md
         hydra-ox/async-export
         (eq hydra-ox/export-scope 'subtree)
         hydra-ox/visible-only
         hydra-ox/body-only)) "As HTML file and open")
  ("b" hydra-ox/body "back")
  ("q" nil "quit"))

(defhydra hydra-ox-reveal (:color blue)
  "ox-reveal"
  ("R" (org-reveal-export-as-html
        hydra-ox/async-export
        (eq hydra-ox/export-scope 'subtree)
        hydra-ox/visible-only
        hydra-ox/body-only)
       "As REVEAL buffer")
  ("r" (org-reveal-export-to-html
        hydra-ox/async-export
        (eq hydra-ox/export-scope 'subtree)
        hydra-ox/visible-only
        hydra-ox/body-only) "As REVEAL file")
  ("o" (org-open-file
        (org-reveal-export-to-html
         hydra-ox/async-export
         (eq hydra-ox/export-scope 'subtree)
         hydra-ox/visible-only
         hydra-ox/body-only)) "As REVEAL file and open")
  ("b" hydra-ox/body "back")
  ("q" nil "quit"))


  (defhydra hydra-ox ()
    "
  _C-b_ Body only:    % -15`hydra-ox/body-only^^^ _C-v_ Visible only:     %`hydra-ox/visible-only
  _C-s_ Export scope: % -15`hydra-ox/export-scope _C-f_ Force publishing: %`hydra-ox/force-publishing
  _C-a_ Async export: %`hydra-ox/async-export

  "
    ("C-b" (hydra-ox/body-only) nil)
    ("C-v" (hydra-ox/visible-only) nil)
    ("C-s" (hydra-ox/export-scope) nil)
    ("C-f" (hydra-ox/force-publishing) nil)
    ("C-a" (hydra-ox/async-export) nil)
    ("g" hydra-ox-gfm/body "Export to Github Flavoured Markdown"  :exit t)
    ("H" hydra-ox-hugo/body "Export to Hugo MD Files" :exit t)
    ("h" hydra-ox-html/body "Export to HTML" :exit t)
    ("l" hydra-ox-latex/body "Export to LaTeX" :exit t)
    ("r" hydra-ox-reveal/body "Export to REVEAL" :exit t)
    ("t" hydra-ox-text/body "Export to Plain Text" :exit t)
    ("q" nil "quit"))

    (define-key org-mode-map (kbd "C-c C-,") 'hydra-ox/body)

  (provide 'hydra-ox)

  ;;; hydra-ox.el ends here

(use-package org-link-edit
  :after org
  :config
  (defun jk/unlinkify ()
  "Replace an org-link with the description, or if this is absent, the path."
  (interactive)
  (let ((eop (org-element-context)))
    (when (eq 'link (car eop))
      (message "%s" eop)
      (let* ((start (org-element-property :begin eop))
             (end (org-element-property :end eop))
             (contents-begin (org-element-property :contents-begin eop))
             (contents-end (org-element-property :contents-end eop))
             (path (org-element-property :path eop))
             (desc (and contents-begin
                        contents-end
                        (buffer-substring contents-begin contents-end))))
        (setf (buffer-substring start end)
              (concat (or desc path)
                      (make-string (org-element-property :post-blank eop) ?\s)))))))

 (define-key org-mode-map (kbd "C-c )")
      (defhydra hydra-org-link-edit (:color red)
        "Org Link Edit"
        ("f" org-link-edit-forward-slurp "forward slurp")
        ("d" org-link-edit-forward-barf "forward barf")
        ("e" org-link-edit-backward-slurp "backward slurp")
        ("r" org-link-edit-backward-barf "backward barf")
        ("x" jk/unlinkify "remove link" :color blue)
        ("q" nil "cancel" :color blue))))

;; (global-set-key (kbd "C-c W h") 'ora-org-to-html-to-clipboard)
        ;; (global-set-key (kbd "C-c W s") 'ora-org-export-to-clipboard-as-slack)

      ;; (defhydra hydra-org-clipboard (global-map "C-c W" :hint nil :columns 2 )

      ;; ;; "Export formatted text to the clipboard"
      ;; ;; "
      ;; ;; ^HTML^                   ^Text^
      ;; ;; _h__: to HTML clipboard  _m_: as markdown
      ;; ;; _H_: as HTML             _s_: as slack
      ;; ;; "
      ;; ;; ("h" ora-org-to-html-to-clipboard "to html clipboard" :column "html")

      ;; ;; ("m" (mwp-org-export-to-clipboard 'md  ) "as md" :column "text")
      ;; ;; ("s" (mwp-org-export-to-clipboard 'slack ) "as slack" :column "text" ))
      ;;   ("h" ora-org-to-html-to-clipboard)
      ;; ("H" (mwp-org-export-to-clipboard 'html ) )
      ;; ("m" (mwp-org-export-to-clipboard 'md  ) )
      ;; ("s" (mwp-org-export-to-clipboard 'slack ) ))


  (defhydra hydra-o-c (:color blue)
    "
Export Region or file to clipboard
==================================
To paste into a browser, libreoffice, etc, 
choose \"_h_\" to use the rich-text system clipboard.

Region is currently %s(if (use-region-p) \"ACTIVE.\" \"NOT ACTIVE!!!\").

"

    ("m" (mwp-org-export-to-clipboard 'md) "as gfm md" :column "text"  )
    ("s" (mwp-org-export-to-clipboard 'slack) "as slack" :column "text" )
    ("h" ora-org-to-html-to-clipboard "to html clipboard" :column "html")
    ("H" (mwp-org-export-to-clipboard 'html) "to text as html"   :column "html"))

  (global-set-key (kbd "<f6>") 'hydra-o-c/body)

  (global-set-key (kbd "C-c W") 'hydra-o-c/body)

(use-package pdf-tools
  :after hydra
  :config 
  (defhydra hydra-pdftools (:color blue :hint nil)
    "

         Move  History   Scale/Fit     Annotations  Search/Link    Do    PDF Tools 
            ^^_g_^^      _B_    ^^    _+_    ^ ^     [_al_] list    [_s_] search    [_u_] revert buffer
           ^^^^^^      ^^    _H_    ^   [_am_] markup  [_o_] outline   [_i_] info
           ^^_p_^^      ^ ^    ^    ^ ^     [_at_] text    [_F_] link      [_d_] dark mode
           ^^_G_^^
     --------------------------------------------------------------------------------
          "
    ;; ("\\" hydra-master/body "back")
    ("<ESC>" nil "quit")
    ("al" pdf-annot-list-annotations)
    ("ad" pdf-annot-delete)
    ("aa" pdf-annot-attachment-dired)
    ("am" pdf-annot-add-markup-annotation)
    ("at" pdf-annot-add-text-annotation)
    ("y"  pdf-view-kill-ring-save)
    ("+" pdf-view-enlarge :color red)
    ("-" pdf-view-shrink :color red)
    ("0" pdf-view-scale-reset)
    ("H" pdf-view-fit-height-to-window)
    ("W" pdf-view-fit-width-to-window)
    ("P" pdf-view-fit-page-to-window)
    ("n" pdf-view-next-page-command :color red)
    ("p" pdf-view-previous-page-command :color red)
    ("d" pdf-view-dark-minor-mode)
    ("b" pdf-view-set-slice-from-bounding-box)
    ("r" pdf-view-reset-slice)
    ("g" pdf-view-first-page)
    ("G" pdf-view-last-page)
    ("e" pdf-view-goto-page)
    ("o" pdf-outline)
    ("s" pdf-occur)
    ("i" pdf-misc-display-metadata)
    ("u" pdf-view-revert-buffer)
    ("F" pdf-links-action-perfom)
    ("f" pdf-links-isearch-link)
    ("B" pdf-history-backward :color red)
    ("N" pdf-history-forward :color red)
    ("l" image-forward-hscroll :color red)
    ("h" image-backward-hscroll :color red))
    :bind
    (:map pdf-view-mode-map 
("\\" . hydra-pdftools/body)))

(defhydra hydra-ww (:color blue :columns 3)
  "
Wildwater actions
================
"
  ("s" (find-file "~/Wildwater/ww1-syllabus.org") "Syllabus")
  ("g" (find-file "~/Wildwater/Grades/Comments.org") "Grades")
  ("n" (find-file "~/Wildwater/Slides-and-notes.org") "Notes"))


(defhydra hydra-dh (:color blue :columns 2)
  "
Digital History Grading actions
================
"
  ("f" (dh-find-files) "Open Files")
  ("v" (dh-view) "Browse files")
  ("i" (dh-prep) "Install (prep) repo")
  ("p" (dh-visit-pr) "Browse PR")
  ("s" (dh-status) "Open in Magit"))

(defhydra hydra-hh (:color blue :columns 3)
  "
Wildwater actions
================
"
  ("s" (find-file "~/Wildwater/ww1-syllabus.org") "Syllabus")
  ("g" (find-file "~/Wildwater/Grades/Comments.org") "Grades")
  ("n" (find-file "~/Wildwater/Slides-and-notes.org") "Notes"))

(defhydra hydra-modernity (:color blue :columns 3)
  "
Modernity actions
================
"
  ("s" (find-file "~/Wildwater/ww1-syllabus.org") "Syllabus")
  ("g" (find-file "~/Wildwater/Grades/Comments.org") "Grades")
  ("n" (find-file "~/Wildwater/Slides-and-notes.org") "Notes"))

(define-key org-mode-map (kbd "C-c D") 'hydra-dh/body)

(use-package projectile 
:after hydra
:config 
(projectile-global-mode +1)
(helm-projectile-on)
(setq projectile-indexing-method 'alien)
(projectile-register-project-type 'npm '("package.json")
                  :compile "npm install"
                  :test "npm test"
                  :run "npm start"
                  :test-suffix ".spec")
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(defhydra hydra-projectile (:color teal
			    :columns 4)
  "Projectile"
  ("f"   projectile-find-file                "Find File")
  ("r"   projectile-recentf                  "Recent Files")
  ("z"   projectile-cache-current-file       "Cache Current File")
  ("x"   projectile-remove-known-project     "Remove Known Project")
  
  ("d"   projectile-find-dir                 "Find Directory")
  ("b"   projectile-switch-to-buffer         "Switch to Buffer")
  ("c"   projectile-invalidate-cache         "Clear Cache")
  ("X"   projectile-cleanup-known-projects   "Cleanup Known Projects")
  
  ("o"   projectile-multi-occur              "Multi Occur")
  ("s"   projectile-switch-project           "Switch Project")
  ("k"   projectile-kill-buffers             "Kill Buffers")
  ("q"   nil "Cancel" :color blue))
)

(define-minor-mode mwp-bindings-mode
  "Some new bindings, at first justfor markdown mode."
  :lighter "mwp"
  :keymap(let ((map (make-sparse-keymap)))
            (define-key map (kbd "<M-right>") 'markdown-demote)
            (define-key map (kbd "<M-left>") 'markdown-promote)
            (define-key map (kbd "<M-up>") 'markdown-move-up)
            (define-key map (kbd "<M-down>") 'markdown-move-down)
            map) )

(add-hook 'markdown-mode 'mwp-bindings-mode)

(add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; (use-package emr
  ;; :ensure t
  ;; )
  (use-package emr
:ensure t
    :config
    (add-hook 'emacs-lisp-mode-hook 'emr-initialize)
    ;; (bind-key "R" #'emr-show-refactor-menu lisp-evaluation-map)
)

(defun narrow-or-widen-dwim (p)
    "If the buffer is narrowed, it widens. Otherwise, it narrows
      intelligently.  Intelligently means: region, org-src-block,
      org-subtree, or defun, whichever applies first.  Narrowing to
      org-src-block actually calls `org-edit-src-code'.

      With prefix P, don't widen, just narrow even if buffer is already
      narrowed."
    (interactive "P")
    (declare (interactive-only))
    (cond ((and (buffer-narrowed-p) (not p)) (widen))
          ((and (boundp 'org-src-mode) org-src-mode (not p))
           (org-edit-src-exit))
          ((region-active-p)
           (narrow-to-region (region-beginning) (region-end)))
          ((derived-mode-p 'org-mode)
           (cond ((ignore-errors (org-edit-src-code))
                  (delete-other-windows)
                  )
                 ((org-at-block-p)
                  (org-narrow-to-block))
                 (t (org-narrow-to-subtree))))
          ((derived-mode-p 'prog-mode) (narrow-to-defun))
          (t (error "Please select a region to narrow to"))))

;; this is a bit brilliant - -common error for me!        
  (eval-after-load 'org-src
    '(bind-key "C-x C-s" 'org-edit-src-exit org-src-mode-map))

  (use-package hideshow
    :hook ((prog-mode . hs-minor-mode)))

  (defun toggle-fold ()
    (interactive)
    (save-excursion
      (end-of-line)
      (hs-toggle-hiding)))
      (define-key emacs-lisp-mode-map (kbd "<C-tab>") 'toggle-fold )


  (defun read-write-toggle ()
    "Toggles read-only in any relevant mode: ag-mode, Dired, or
      just any file at all."
    (interactive)
    (if (equal major-mode 'ag-mode)
        ;; wgrep-ag can support ag-mode
        (wgrep-change-to-wgrep-mode)
      ;; dired-toggle-read-only has its own conditional:
      ;; if the mode is Dired, it will make the directory writable
      ;; if it is not, it will just toggle read only, as desired
      (dired-toggle-read-only)))

  (bind-keys :prefix-map toggle-map
             :prefix "C-x t"
             ("d" . toggle-debug-on-error)
             ("f" . toggle-fold)
             ("l" . linum-mode)
             ("n" . narrow-or-widen-dwim)
             ("o" . org-mode)
             ("r" . read-write-toggle)
             ("t" . text-mode)
                                          ;("w" . whitespace-mode)
             ("w" . toggle-windows-split)
             )

  ;; switchint to a hydra for clarity

  (global-set-key 
   (kbd "C-x t")
   (defhydra hydra-toggle (:color blue :columns 3)
     "
    toggle
    ------
    "
     ("d" toggle-debug-on-error "debug")
     ("f" toggle-fold "folding")
     ("l" linum-mode "line numbers")
     ("n" narrow-or-widen-dwim "narrowing")
     ("o" org-mode "org-mode (??)")
     ("r" read-write-toggle "read-write mode")
     ("t" text-mode "text mode (??)")
                                          ;("w" . whitespace-mode)
     ("w" toggle-windows-split "windows split")))

(use-package iedit
:bind (("C-;" . iedit-mode)))

(use-package iedit
  :ensure t
  :commands (iedit-mode)
  :bind* (("M-m *" . iedit-mode) ("C-;" . iedit-mode))
)

(use-package dired-ranger
  :ensure t
  :bind (:map dired-mode-map
              ("W" . dired-ranger-copy)
              ("X" . dired-ranger-move)
              ("Y" . dired-ranger-paste)))

;; (use-package dired-subtree
;;   :config
;;   (bind-keys :map dired-mode-map
;;              ("i" . dired-subtree-insert)
;;              (";" . dired-subtree-remove)))

;;narrow dired to match filter
(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))

;;narrow dired to match filter
(use-package dired-filter
  :ensure t
;; :bind (:map dired-mode-map
;;               ("/" . dired-narrow))
  )

(use-package emojify
  :config
  (add-hook 'after-init-hook #'global-emojify-mode)
  (add-hook 'markdown-mode-hook 'emojify-mode)
  (add-hook 'git-commit-mode-hook 'emojify-mode)
  )

;; (use-package company-emoji
;;   :ensure t
;;   :preface
;;   (defun mwp-dont-insert-unicode-emoji ()
;;     (make-local-variable 'company-emoji-insert-unicode)
;;     (setq company-emoji-insert-unicode nil))
;;   :after (emojify company)
;;   :hook
;;   (org-mode . mwp-dont-insert-unicode-emoji)
;;   (markdown-mode . mwp-dont-insert-unicode-emoji)
;;   (gfm-mode . mwp-dont-insert-unicode-emoji)
;;   (git-commit-mode . mwp-dont-insert-unicode-emoji)
;;   :config
;;   (add-to-list 'company-backends 'company-emoji))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package ace-window
  :bind* ("M-p" . ace-window)
;; :init (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
)

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config 
  ;; (setq dumb-jump-selector 'ivy) ;;
  (setq dumb-jump-selector 'helm)
  (setq dumb-jump-force-searcher 'ag)
  :ensure)

(use-package shell-pop
  :bind (("C-s-t" . shell-pop))
  :config
  (setq shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
  (setq shell-pop-term-shell "/bin/zsh")
  ;; need to do this manually or not picked up by `shell-pop'
  (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))

(use-package ghub
;; :load-path "~/src/ghub"
:ensure t
;; :pin manual
)

(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo" "~/.netrc"))

(with-eval-after-load 'package
        

        (unless t
          (dolist (magit-elpa-install-path (directory-files-recursively
                                          package-user-dir
                                          "\\`magit-[0-9.]+\\'"
                                          :include-directories))
            (setq load-path (delete magit-elpa-install-path load-path))
            ;; Also ensure that the associated path is removed from Info
            ;; search list.
            ))

        )

(use-package magithub
  :after magit
  :ensure t
  :config (magithub-feature-autoinject t))

(use-package magit
  ;;:load-path "/home/matt/src/magit/lisp"
  ;;:pin manual
  :commands magit-status
  :ensure t
  :bind
  ("C-x g" . magit-status)
  :config
  (setq
   magit-diff-use-overlays nil
   magit-repolist-columns
   '(("Name" 25 magit-repolist-column-ident nil)
     ("Version" 25 magit-repolist-column-version nil)
     ("L<U" 3 magit-repolist-column-unpulled-from-upstream
      ((:right-align t)))
     ("L>U" 3 magit-repolist-column-unpushed-to-upstream
      ((:right-align t)))
     ("D" 4 magit-repolist-column-dirty nil)
     ("Path" 99 magit-repolist-column-path nil))
   magit-repository-directories '(("~/src/" . 2))
   git-commit-major-mode 'markdown-mode)
  )


(use-package magit-gitflow
  :after magit
  :hook
  (magit-mode . turn-on-magit-gitflow))
;; (require 'magit-gitflow)
;; (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

(use-package forge
;; :load-path "~/src/magit-forge/lisp"
:after magit
;; :ensure t
;;:pin manual
)

;; (defun enab-theme (theme) 
;;  (if current-t43m3 (disable-theme current-t43m3))
;;  (setq current-t43m3 theme) 
;;  (load-theme theme t)) 

;; (defadvice load-theme (before theme-dont-propagate activate)
;;  (mapcar #'disable-theme custom-enabled-themes))

(defun set-org-hide ()
  (interactive)
  (face-spec-set 'org-hide `((((background light)) (:foreground ,(face-attribute 'default :background) ))
    (((background dark)) (:foreground  ,(face-attribute 'default :background)))))
  )

(add-hook 'focus-in-hook 'set-org-hide t)

;; I install mu4e from source/git; the arch package was difficult to
;; install, and now I find myself modifying the source code with some
;; frequency


;; In additoin to mu4e, I use org-mu4e and org-mime quite a bit, so
;; might as well load here.
(use-package mu4e
  :load-path "~/src/mu/mu4e"
  :functions mu
  :commands (mu4e mu)
  :init
  ;; set mu4e as the default mail agent
  ;; NOT setting this led to quite a number of small frustrations
  (setq mail-user-agent 'mu4e-user-agent)

  ;; identify the maildir where mail is stored
  (setq mu4e-maildir "/home/matt/UofTMail/")
  ;; postponed message is put in the following draft file
  (setq message-auto-save-directory "~/UofTMail/drafts")

  ;; more default directories.  
  (setq mu4e-sent-folder   "/Sent")
  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-trash-folder  "/Trash")
  (setq mu4e-refile-folder  "/Archives")
  ;; smtp mail setting; these are the same that `gnus' uses. I don't
  ;; realy need these anymore as I ave switched to nullmailer, but
  ;; useful to keep around in case my setup changes in future
  (setq
   smtpmail-default-smtp-server "smtp.utoronto.ca"
   smtpmail-smtp-server         "smtp.utoronto.ca"
   smtpmail-local-domain        "utoronto.ca")

  ;; nullmailer provides a /usr/bin/sendmail
  (setq message-send-mail-function 'message-send-mail-with-sendmail)
  (setq sendmail-program "/usr/bin/sendmail")

  ;; the maildirs you use frequently; access them with 'j' ('jump')
  (setq   mu4e-maildir-shortcuts
          '(("/inbox"       . ?i)
            ("/Archives"     . ?a)
            ("/Sent"        . ?s)))
  ;; use flyspell and abbrevs
  (add-hook 'mu4e-compose-mode-hook
            (lambda()
              (flyspell-mode 1)))

  ;; address options
  (setq mu4e-reply-to-address "matt.price@utoronto.ca"
        user-mail-address "matt.price@utoronto.ca"
        user-full-name  "Matt Price")
  (setq mu4e-compose-signature
        "")
  ;; from customize interface, moving here where they belong
  (setq mu4e-bookmarks
        '(("maildir:/inbox AND NOT (contact:notifications@github.com OR contact:noreply@github.com OR contact:builds@travis-ci.com OR contact:builds@travis-ci.org) AND NOT flag:trashed" "non-github msgs in Inbox" 105)
          ("maildir:/inbox AND (contact:notifications@github.com OR contact:noreply@github.com OR contact:builds@travis-ci.com OR contact:builds@travis-ci.org) AND NOT flag:trashed" "github msgs in Inbox" 103)
          ("maildir:/inbox AND (HIS395 OR NEW113 OR HIS455 OR RLG231 OR RLG239 OR \"hacking history\" OR \"digital history\") AND NOT flag:trashed" "Teaching msgs in inbox" 84)
          ("flag:unread AND maildir:/inbox AND NOT flag:trashed" "Unread in inbox" 117)
          ("maildir:/inbox AND date:today..now AND NOT flag:trashed" "Today's messages" 116)
          ("maildir:/inbox AND date:7d..now AND NOT flag:trashed" "Last 7 days" 119)
          ("mime:image/*" "Messages with images" 112)
          ("maildir:/inbox AND NOT flag:trashed" "the whole maildir, but not trash" 109))
        mu4e-headers-results-limit 700
        mu4e-update-interval 900
        mu4e-view-show-addresses t)

  (setq mu4e-user-mail-address-list '("matt.price@utoronto.ca" "moptop99@gmail.com"))
  :config
  (define-key mu4e-headers-mode-map (kbd "C-c c") 'org-mu4e-store-and-capture)
  (define-key mu4e-view-mode-map    (kbd "C-c c") 'org-mu4e-store-and-capture)
  (define-key mu4e-headers-mode-map "x" #'my-mu4e-mark-execute-all-no-confirm)  ;; turn off execution confirmation
  (define-key mu4e-view-mode-map "x" #'my-mu4e-mark-execute-all-no-confirm)  ;; turn off execution confirmation
  ;; (define-key mu4e-compose-mode-map (kbd "C-c o") 'mwp-add-mu-keys-to-org) ;; switch to org, also add a keybinding
  (define-key mu4e-compose-mode-map (kbd "C-c o") 'org-mu4e-compose-org-mode)  ;; activate org-mu4e-compose-org-mode

  ;; configure view actions
  (add-to-list 'mu4e-view-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t)
  (add-to-list 'mu4e-view-actions
               '("xwidget" . mu4e-action-view-with-xwidget) t)
  (add-to-list 'mu4e-marks
               '(tag
                 :char       "g"
                 :prompt     "gtag"
                 :ask-target (lambda () (read-string "What tag do you want to add?"))
                 :action      (lambda (docid msg target)
                                (mu4e-action-retag-message msg (concat "+" target)))))
  '(mu4e-bookmarks
    '(("maildir:/inbox AND NOT (contact:notifications@github.com OR contact:noreply@github.com OR contact:builds@travis-ci.com OR contact:builds@travis-ci.org) AND NOT flag:trashed" "non-github msgs in Inbox" 105)
      ("maildir:/inbox AND (contact:notifications@github.com OR
       contact:noreply@github.com OR contact:builds@travis-ci.com
       OR contact:builds@travis-ci.org) AND NOT
       flag:trashed" "github msgs in Inbox" 103)
      ("maildir:/inbox AND (HIS395 OR NEW113 OR HIS455 OR RLG231 OR RLG239 OR \"hacking history\" OR \"digital history\") AND NOT flag:trashed" "Teaching msgs in inbox" 84)
      ("flag:unread AND maildir:/inbox AND NOT flag:trashed" "Unread in inbox" 117)
      ("maildir:/inbox AND date:today..now AND NOT flag:trashed" "Today's messages" 116)
      ("maildir:/inbox AND date:7d..now AND NOT flag:trashed" "Last 7 days" 119)
      ("mime:image/*" "Messages with images" 112)
      ("maildir:/inbox AND NOT flag:trashed" "the whole maildir, but not trash" 109))) 
  '(mu4e-headers-results-limit 700)
  '(mu4e-update-interval 900)
  '(mu4e-view-show-addresses t)

  ;; (mu4e~headers-defun-mark-for tag)
  ( define-key mu4e-headers-mode-map (kbd "g") 'mu4e-headers-mark-for-tag)
  ;; this was a pain to set up but finally mu4e compose uses the lorg-mode abbrev table
  ;; whew!!!!
  (defun mwp-always-set-abbrev () 
    (interactive)
    (setq local-abbrev-table org-mode-abbrev-table))
  (add-hook 'mu4e-compose-mode-hook #'mwp-always-set-abbrev)
  )


(use-package org-mu4e
  :after (org mu4e))

(use-package mu4e-contrib
  :after (org mu4e)
  :config
  (setq mu4e-html2text-command 'mu4e-shr2text)
  (add-hook 'mu4e-view-mode-hook
            (lambda()
              ;; try to emulate some of the eww key-bindings
              (local-set-key (kbd "<tab>") 'shr-next-link)
              (local-set-key (kbd "<backtab>") 'shr-previous-link)))

  ;; the headers to show in the headers list -- a pair of a field
  ;; and its width, with `nil' meaning 'unlimited'
  ;; (better only use that for the last field.
  ;; These are the defaults:
  (setq mu4e-headers-fields
        '( (:human-date          .  25)    ;; alternatively, use :human-date
           (:flags         .   6)
           (:mailing-list         .   10)
           ;;(:attachments   .   6)
           (:from-or-to          .  22)
           (:subject       .  nil))) ;; alternatively, use :thread-subject

  ;; program to get mail; alternatives are 'fetchmail', 'getmail'
  ;; isync or your own shellscript. called when 'U' is pressed in
  ;; main view.

  ;; If you get your mail without an explicit command,
  ;; use "true" for the command (this is the default)
  (setq mu4e-get-mail-command "offlineimap")

  ;; smtp mail setting
  ;; I don't think this is being used by nullmailer at all, so probably irrelefant for me.
  ;; (setq

  ;;  ;; if you need offline mode, set these -- and create the queue dir
  ;;  ;; with 'mu mkdir', i.e.. mu mkdir /home/user/Maildir/queue
  ;;  smtpmail-queue-mail  nil
  ;;  smtpmail-queue-dir  "/home/matt/UofTMail/queue/cur")

  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t)


  ;; split horizontally, which is how I like it
  ;; actually, switch to vertical (which is bizarrely called horizontal)
  ;; can't seem to get it to switch, so we'll see how it goes.
  (setq ;; mu4e-split-view 'horizontal
   mu4e-headers-visible-lines 15
   mu4e-headers-visible-columns 80)

  ;; view images inline
  ;; enable inline images
  (setq mu4e-view-show-images t)
  ;; use imagemagick, if available
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))
  (message "initial setup of mu4e accomplished")
  )  

;; when you want to use some external command for text->html
;; conversion, e.g. the 'html2text' program
;; (setq mu4e-html2text-command "html2text")
;; (require 'mu4e-contrib)

(setq kzar/mu4e-activity-string "")
(add-to-list 'global-mode-string '((:eval kzar/mu4e-activity-string)) t)
(defun kzar/get-mu4e-incoming-count ()
  "Get the incoming message count."
  (let* ((query "flag:unread AND \(maildir:/INBOX or maildir:/INBOX.Eyeo\)")
         (command
          "echo -n $( mu find date:1w..now maildir:/INBOX flag:unread 2>/dev/null | wc -l )"

         ;; "GUILE_LOAD_PATH='/usr/local/share/guile/site/2.0' GUILE_AUTO_COMPILE=0 mu msgs-count --query='flag:unread AND maildir:/INBOX'"
          )


         )
    (string-trim (shell-command-to-string command))))
(defun kzar/format-mu4e-mode-string (count)
  (concat "[" (if (string= count "0") "" count)
          (if (get-buffer "*mu4e-headers*" )
              (concat 
               "|" 
               (with-current-buffer "*mu4e-headers*"
                 (number-to-string (count-lines (point-min) (point-max)))))
            "")

          "]"))
(defun kzar/update-mu4e-activity-string (&rest args)
  (interactive)
  (setq kzar/mu4e-activity-string
        (kzar/format-mu4e-mode-string (kzar/get-mu4e-incoming-count)))
  (force-mode-line-update))
(add-hook 'mu4e-main-mode-hook #'kzar/update-mu4e-activity-string)
(add-hook 'mu4e-view-mode-hook #'kzar/update-mu4e-activity-string)
(add-hook 'mu4e-index-updated-hook #'kzar/update-mu4e-activity-string)

;; extract attachments
;; consider doing some sorting, e.g.: http://www.djcbsoftware.nl/code/mu/mu4e/Attachments.html#Attachments
(setq mu4e-attachment-dir  "~/Downloads")
(setq mu4e-attachment-dir
      (lambda (fname mtype)
        (cond
         ;; jpgs go to ~/Pictures/FromEmails
         ((and fname (string-match "\\.jpg$" fname))  "~/Pictures/FromEmails")
         ;; ... other cases  ...
         (t "~/Downloads")))) ;; everything else

;; this is stolen from John but it didn't work for me until I
;; made those small changes to mu4e-compose.el
;; added a namespace prefix to avoid overlap.
(defun mwp-htmlize-and-send ()
  "When in an org-mu4e-compose-org-mode message, htmlize and send it."
  (interactive)
  (when (member 'org~mu4e-mime-switch-headers-or-body post-command-hook)
    (org-mime-htmlize nil)
    (org-mu4e-compose-org-mode)
    (mu4e-compose-mode)
    (message-send-and-exit)))


;; This overloads the amazing C-c C-c commands in org-mode with one more function
;; namely the htmlize-and-send, above.
(add-hook 'org-ctrl-c-ctrl-c-final-hook #'mwp-htmlize-and-send t)
(remove-hook 'org-ctrl-c-ctrl-c-hook 'mwp-htmlize-and-send t)


;; Originally, I set the `mu4e-compose-mode-hook' here, but
;; this new hook works much, much better for me.


;; lightly modifies org-mime-org-buffer-htmlize to go to the to header
;; change this to an advice on the original fn to avoid confusion!
;; may no longer be necessary
(advice-add 'org-mime-org-buffer-htmlize :after #'message-goto-go) 
;; (advice-remove 'org-mime-org-buffer-htmlize  'message-goto-go)

;; (defun org-mime-org-buffer-htmlize ()
;;   "Create an email buffer containing the current org-mode file
;;          exported to html and encoded in both html and in org formats as
;;          mime alternatives."
;;   (interactive)
;;   (org-mime-send-buffer 'html)
;;   (message-goto-to))

;; I probalby don't need this anymore since I've added the hook! doh!
;; (defun mu4e-compose-org-mail ()
;;   (interactive)
;;   (mu4e-compose-new)
;;   (org-mu4e-compose-org-mode))

;; maybe not a good idea to do this.  
;; (add-hook 'mu4e-compose-post-hook
;;           (defun do-compose-stuff ()
;;             "My settings for message composition."
;;             (org-mu4e-compose-org-mode)))

(defun my-mu4e-main-mode-config ()
  "For use in `mu4e-main-mode-hook'."
  (local-set-key (kbd "m") 'mu4e-main-toggle-mail-sending-mode) ; add a key
  (local-set-key (kbd "f") 'smtpmail-send-queued-mail) ; add a key
  ;;(local-set-key (kbd "C-c C-p") nil) ; example of remove a key
  ;; more here
  )

(defun my-mu4e-headers-mode-config ()
  "For use in 'mu4e-view-mode-hook'."
  ;; (local-set-key (kbd "a") 'mu4e-headers-mark-for-refile) ;; remap from "r"
  (local-set-key (kbd "f") 'mu4e-headers-mark-for-refile) ;; remap from "r"
  (local-set-key (kbd "r") 'mu4e-compose-reply) ;; add new keymapping, along with "R"
  (local-set-key (kbd "C-c C-v") 'mu4e-headers-action) ;; rebind from "a"
  )

(defun my-mu4e-view-mode-config ()
  "For use in 'mu4e-view-mode-hook'."
  ;;(local-set-key (kbd "a") 'mu4e-view-mark-for-refile) ;; remap from "r"
  (local-set-key (kbd "f") 'mu4e-view-mark-for-refile) ;; remap from "r"
  (local-set-key (kbd "r") 'mu4e-compose-reply) ;; add new keymapping, along with "R"
  (local-set-key (kbd "C-c C-v") 'mu4e-view-action) ;; rebind from a
  (visual-line-mode)
 )


;; function to add a local key to the org-mode map!
(defun mwp-add-mu-keys-to-org ()
  (interactive)
  (org-mode)
  (local-set-key (kbd "C-c o") 'mu4e-compose-mode))

;; add to hook
(add-hook 'mu4e-main-mode-hook 'my-mu4e-main-mode-config)
(add-hook 'mu4e-headers-mode-hook 'my-mu4e-headers-mode-config)
(add-hook 'mu4e-view-mode-hook 'my-mu4e-view-mode-config)



      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Interactive functions

(defun my-mu4e-mark-execute-all-no-confirm ()
  "Execute all marks without confirmation."
  (interactive)
  (mu4e-mark-execute-all 'no-confirm))

;; this seemed essential at first but now I'm not using the mstpmail queue
(defun mu4e-main-toggle-mail-sending-mode ()
  "Toggle sending mail mode, either queued or direct."
  (interactive)
  (unless (file-directory-p smtpmail-queue-dir)
    (mu4e-error "`smtpmail-queue-dir' does not exist"))
  (setq smtpmail-queue-mail (not smtpmail-queue-mail))
  (message
   (concat "Outgoing mail will now be "
           (if smtpmail-queue-mail "queued" "sent directly")))
  (mu4e~main-view))

(setq mwp/contact-blacklist-file "/home/matt/.mu/contact-blacklist")
(defun mwp/read-contact-blacklist ()
   "Return a list of blacklisted email addresses"
   (with-temp-buffer
     (insert-file-contents mwp/contact-blacklist-file)
     (split-string (buffer-string) "\n" t)))

 (defun mwp/make-contact-blacklist-regexp ()
   "Combine listed addresses into a regexp"
   (mapconcat 'identity (mwp/read-contact-blacklist) "\\|"))

 (setq mu4e-compose-complete-ignore-address-regexp (mwp/make-contact-blacklist-regexp))



(defun mu ()
  "open the mu-headers buffer if it exists, otherwise start mu4e"
  (interactive)
  (if (get-buffer "*mu4e-headers*")
      (switch-to-buffer "*mu4e-headers*")
    (mu4e)))

(add-hook 'mail-mode-hook #'orgalist-mode)
(add-hook 'message-mode-hook #'orgalist-mode)

(use-package helm-mu
:after (mu4e helm)
;; some recommended config vars
:config
(setq helm-mu-default-search-string "(maildir:/INBOX OR maildir:/Sent)")
(setq helm-mu-contacts-after "01-Jan-1995 00:00:00")
;; (setq helm-mu-contacts-personal t)
;; :bind
;; (:map mu 'mu4e-main-mode-map 
;; ("s" . 'helm-mu))
;; (:map mu 'mu4e-headers-mode-map 
;; ("s" . 'helm-mu))
;; (:map mu 'mu4e-view-mode-map 
;; ("s" . 'helm-mu))
)

(defvar yt-iframe-format
  ;; You may want to change your width and height.
  (concat "<iframe width=\"440\""
          " height=\"335\""
          " src=\"https://www.youtube.com/embed/%s\""
          " frameborder=\"0\""
          " allowfullscreen>%s</iframe>"))

(org-add-link-type
 "yt"
 (lambda (handle)
   (browse-url
    (concat "https://www.youtube.com/embed/"
            handle)))
 (lambda (path desc backend)
   (cl-case backend
     (html (format yt-iframe-format
                   path (or desc "")))
     (latex (format "\href{%s}{%s}"
                    path (or desc "video"))))))

(defun reference ()
    "open up the refernce doc!"
  (interactive)
  (find-file "~/GTD/Reference.org"))

(defun keep-it-safe ()
    "open up the password safe!"
  (interactive)
  (find-file "~/GTD/Keep-it-safe.org.gpg"))

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
 (load "/home/matt/.emacs.d/custom.el")

(setq shift-select-mode t)
(setq org-support-shift-select t)

(use-package poly-markdown
  :ensure t)

(yas-global-mode -1)

(defun has-space-at-boundary-p (string)
  "Check whether STRING has any whitespace on the boundary.
Return 'left, 'right, 'both or nil."
  (let ((result nil))
    (when (string-match-p "^[[:space:]]+" string)
      (setq result 'left))
    (when (string-match-p "[[:space:]]+$" string)
      (if (eq result 'left)
	  (setq result 'both)
	(setq result 'right)))
    result))

(defun is-there-space-around-point-p ()
  "Check whether there is whitespace around point.
Return 'left, 'right, 'both or nil."
  (let ((result nil))
    (when (< (save-excursion
               (skip-chars-backward "[:space:]"))
             0)
      (setq result 'left))
    (when (> (save-excursion
               (skip-chars-forward "[:space:]"))
             0)
      (if (eq result 'left)
	  (setq result 'both)
	(setq result 'right)))
    result))

(defun set-point-before-yanking (string)
  "Put point in the appropriate place before yanking STRING."
  (let ((space-in-yanked-string (has-space-at-boundary-p string))
	(space-at-point (is-there-space-around-point-p)))
    (cond ((and (eq space-in-yanked-string 'left)
		(eq space-at-point 'left))
	   (skip-chars-backward "[:space:]"))
	  ((and (eq space-in-yanked-string 'right)
		(eq space-at-point 'right))
	   (skip-chars-forward "[:space:]")))))

(defun set-point-before-yanking-if-in-text-mode (string)
  "Invoke `set-point-before-yanking' in text modes."
  (when (derived-mode-p 'text-mode)
    (set-point-before-yanking string)))

(advice-add
 'insert-for-yank
 :before
 #'set-point-before-yanking-if-in-text-mode)

(defun ap/cycle-spacing ()
  (interactive)
  (cycle-spacing -1))
(bind-key (kbd "<C-M-backspace>") 'ap/cycle-spacing)

;; check to see if the owner of the current desktop is still alive
(defun emacs-process-p (pid)
  "If pid is the process ID of an emacs process, return t, else nil.
Also returns nil if pid is nil."
  (when pid
    (let ((attributes (process-attributes pid)) (cmd))
      (dolist (attr attributes)
        (if (string= "comm" (car attr))
            (setq cmd (cdr attr))))
      (if (and cmd (or (string= "emacs" cmd) (string= "emacs.exe" cmd))) t))))

;; advise desktop: if the pid in lockfile is no longer alive, don't require confirmation to steal desktop file
(defadvice desktop-owner (after pry-from-cold-dead-hands activate)
  "Don't allow dead emacsen to own the desktop file."
  (when (not (emacs-process-p ad-return-value))
    (setq ad-return-value nil)))

;;; session management with desktop
(require 'desktop)
;; (setq desktop-dirname "/home/matt/.emacs.d/desktop-sessions/")
(desktop-save-mode 1)
(message "just before recover-session")
(setq auto-save-list-file-prefix "~/.emacs.d/auto-save-list/.saves-")

(defun recover-session ()
  "Recover auto save files from a previous Emacs session.
This command first displays a Dired buffer showing you the
previous sessions that you could recover from.
To choose one, move point to the proper line and then type C-c C-c.
Then you'll be asked about a number of files to recover."
  (interactive)
  (if (null auto-save-list-file-prefix)
      (error "You set `auto-save-list-file-prefix' to disable making session files"))
  (let ((dir (file-name-directory auto-save-list-file-prefix))
        (nd (file-name-nondirectory auto-save-list-file-prefix)))
    (unless (file-directory-p dir)
      (make-directory dir t))
    (unless (directory-files dir nil
                             (if (string= "" nd)
                                 directory-files-no-dot-files-regexp
                               (concat "\\`" (regexp-quote nd)))
			     t)
      (error "No previous sessions to recover")))
  (let ((ls-lisp-support-shell-wildcards t))
    (dired (file-name-directory  auto-save-list-file-prefix)
	   (concat dired-listing-switches " -t")))
  (use-local-map (nconc (make-sparse-keymap) (current-local-map)))
  (define-key (current-local-map) "\C-c\C-c" 'recover-session-finish)
  (save-excursion
    (goto-char (point-min))
    (or (looking-at " Move to the session you want to recover,")
	(let ((inhibit-read-only t))
	  ;; Each line starts with a space
	  ;; so that Font Lock mode won't highlight the first character.
	  (insert " To recover a session, move to it and type C-c C-c.\n"
		  (substitute-command-keys
		   " To delete a session file, type \
\\[dired-flag-file-deletion] on its line to flag
 the file for deletion, then \\[dired-do-flagged-delete] to \
delete flagged files.\n\n"))))))

(recover-session)
;;
