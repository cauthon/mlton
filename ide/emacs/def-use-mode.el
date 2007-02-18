;; Copyright (C) 2007 Vesa Karvonen
;;
;; MLton is released under a BSD-style license.
;; See the file MLton-LICENSE for details.

;; This is a minor mode to support precisely identified definitions and
;; uses.  See http://mlton.org/EmacsDefUseMode for further information.

;; XXX def-use-apropos
;; XXX mode specific on-off switching
;; XXX rename-variable

(require 'def-use-data)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Prelude

(defvar def-use-load-time t)

(defun def-use-set-custom-and-update (sym val)
  (custom-set-default sym val)
  (unless def-use-load-time
    (def-use-update)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customization

(defgroup def-use nil
  "Minor mode to support precisely identified definitions and uses."
  :group 'matching)

(defface def-use-def-face
  '((((class color)) (:background "paleturquoise3"))
    (t (:background "gray")))
  "Face for highlighting definitions."
  :group 'faces
  :group 'def-use)

(defface def-use-use-face
  '((((class color)) (:background "darkseagreen3"))
    (t (:background "gray")))
  "Face for highlighting uses."
  :group 'faces
  :group 'def-use)

(defface def-use-mark-face
  '((((class color)) (:background "orchid1"))
    (t (:background "gray")))
  "Face for marking definitions and uses."
  :group 'faces
  :group 'def-use)

(defface def-use-view-face
  '((((class color)) (:background "chocolate1"))
    (t (:background "gray")))
  "Face for marking the definition or use currently being viewed."
  :group 'faces
  :group 'def-use)

(defcustom def-use-delay 0.125
  "Idle time in seconds to delay before updating highlighting."
  :type '(number :tag "seconds")
  :group 'def-use)

(defcustom def-use-priority 1000
  "Priority of highlighting overlays."
  :type 'integer
  :group 'def-use)

(defcustom def-use-key-bindings
  '(("[(control c) (control d)]" . def-use-jump-to-def)
    ("[(control c) (control n)]" . def-use-jump-to-next)
    ("[(control c) (control p)]" . def-use-jump-to-prev)
    ("[(control c) (control s)]" . def-use-show-dus)
    ("[(control c) (control l)]" . def-use-list-all-refs)
    ("[(control c) (control v)]" . def-use-show-info))
  "Key bindings for the def-use mode.  The key specifications must be
in a format accepted by the function `define-key'.  Hint: You might
want to type `M-x describe-function def-use <TAB>' to see the
available commands."
  :type '(repeat (cons :tag "Key Binding"
                       (string :tag "Key")
                       (function :tag "Command")))
  :set (function def-use-set-custom-and-update)
  :group 'def-use)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Points and Positions

(defun def-use-pos-to-point (pos)
  "Returns the value of point in the current buffer at the position."
  (save-excursion
    (goto-line (def-use-pos-line pos))
    (+ (point) (def-use-pos-col pos))))

(defun def-use-point-to-pos (point)
  "Returns the position corresponding to the specified point in the
current buffer."
  (save-excursion
    (goto-char point)
    (def-use-pos
      (+ (count-lines 1 (point))
         (if (= (current-column) 0) 1 0))
      (current-column))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; High-level symbol lookup

(defvar def-use-mode-to-move-to-symbol-start-alist nil
  "Association list mapping modes to functions that move the point
backwards to the start of the symbol at the point.")

(defvar def-use-mode-to-move-to-symbol-end-alist nil
  "Association list mapping modes to functions that move the point to the
end of the symbol at the point.")

(defun def-use-move-to-symbol-start ()
  (let ((mode-move
         (assoc major-mode def-use-mode-to-move-to-symbol-start-alist)))
    (if mode-move
        (funcall (cdr mode-move))
      (skip-syntax-backward "w_" (def-use-point-at-current-line)))))

(defun def-use-move-to-symbol-end ()
  (let ((mode-move
         (assoc major-mode def-use-mode-to-move-to-symbol-end-alist)))
    (if mode-move
        (funcall (cdr mode-move))
      (skip-syntax-forward "w_" (def-use-point-at-next-line)))))

(defun def-use-ref-at-point (point)
  "Returns a reference for the symbol at the specified point in the
current buffer."
  (let ((src (def-use-buffer-file-truename)))
    (when src
      (def-use-ref src
        (def-use-point-to-pos
          (save-excursion
            (goto-char point)
            (def-use-move-to-symbol-start)
            (point)))))))

(defun def-use-extract-sym-name-at-point (point)
  "Extracts what looks like the name of the symbol at point.  This doesn't
really understand the syntax of the language, so the result is only valid
when there really is a symbol at the point."
  (save-excursion
    (goto-char point)
    (let* ((start (progn (def-use-move-to-symbol-start) (point)))
           (end (progn (def-use-move-to-symbol-end) (point))))
      (buffer-substring start end))))

(defun def-use-sym-at-point (point)
  "Returns symbol information for the symbol at the specified point."
  (let ((ref (def-use-ref-at-point point)))
    (when ref
      (let ((sym (def-use-sym-at-ref ref)))
        (when (and sym
                   (string= (def-use-sym-name sym)
                            (def-use-extract-sym-name-at-point point)))
          sym)))))

(defun def-use-current-sym ()
  "Returns symbol information for the symbol at the current point."
  (def-use-sym-at-point (point)))

(defun def-use-current-ref ()
  "Returns a reference to the symbol at the current point."
  (def-use-ref-at-point (point)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Navigation

(defconst def-use-apology "Sorry, no information on the symbol at point.")

(defun def-use-jump-to-def (&optional other-window)
  "Jumps to the definition of the symbol under the cursor."
  (interactive "P")
  (let ((sym (def-use-current-sym)))
    (if (not sym)
        (message "%s" def-use-apology)
      (def-use-goto-ref (def-use-sym-ref sym) other-window))))

(defun def-use-jump-to-next (&optional other-window reverse)
  "Jumps to the next use (or def) of the symbol under the cursor."
  (interactive "P")
  (let* ((ref (def-use-current-ref))
         (sym (def-use-sym-at-ref ref)))
    (if (not sym)
        (message "%s" def-use-apology)
      (let* ((refs (def-use-all-refs-sorted sym))
             (refs (if reverse (reverse refs) refs))
             (refs (append refs refs)))
        (while (not (equal (pop refs) ref)))
        (def-use-goto-ref (car refs) other-window)))))

(defun def-use-jump-to-prev (&optional other-window)
  "Jumps to the prev use (or def) of the symbol under the cursor."
  (interactive "P")
  (def-use-jump-to-next other-window t))

(defun def-use-goto-ref (ref &optional other-window)
  "Finds the referenced source and moves point to the referenced
position."
  (cond
   ((not (file-readable-p (def-use-ref-src ref)))
    (compat-error "Referenced file %s can not be read" (def-use-ref-src ref)))
   (other-window
    (def-use-find-file (def-use-ref-src ref) t))
   ((not (equal (def-use-buffer-file-truename) (def-use-ref-src ref)))
    (def-use-find-file (def-use-ref-src ref))))
  (def-use-goto-pos (def-use-ref-pos ref)))

(defun def-use-goto-pos (pos)
  "Moves point to the specified position."
  (goto-char (def-use-pos-to-point pos)))

(defun def-use-all-refs-sorted (sym)
  "Returns a sorted list of all references (including definition) to
the symbol."
  (sort (cons (def-use-sym-ref sym)
              (copy-list (def-use-sym-to-uses sym)))
        (function def-use-ref<)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; List mode

(defconst def-use-ref-regexp "\\([^ ]+\\):\\([0-9]+\\)\\.\\([0-9]+\\)")

(defconst def-use-list-mode-map
  (let ((result (make-sparse-keymap)))
    (mapc (function
           (lambda (key-command)
             (define-key result
               (read (car key-command))
               (cdr key-command))))
          `(("[(b)]"      . ,(function bury-buffer))
            ("[(m)]"      . ,(function def-use-list-view-mark-all))
            ("[(u)]"      . ,(function def-use-list-view-unmark-all))
            ("[(q)]"      . ,(function def-use-kill-current-buffer))
            ("[(return)]" . ,(function def-use-list-view-ref))))
    result))

(define-derived-mode def-use-list-mode fundamental-mode "Def-Use-List"
  "Major mode for browsing def-use lists."
  :group 'def-use-list)

(defvar def-use-list-ref-to-overlay-alist nil)
(defvar def-use-list-sym nil)

(defun def-use-list-all-refs (&optional reverse)
  "Lists all references to the symbol under the cursor."
  (interactive "P")
  (let* ((ref (def-use-current-ref))
         (sym (def-use-sym-at-ref ref)))
    (if (not sym)
        (message "%s" def-use-apology)
      (let* ((name (concat "<:" (def-use-format-sym sym) ":>"))
             (buffer (get-buffer name)))
        (if buffer
            (switch-to-buffer-other-window buffer)
          (setq buffer (get-buffer-create name))
          (switch-to-buffer-other-window buffer)
          (buffer-disable-undo)
          (def-use-list-mode)
          (compat-add-local-hook
            'kill-buffer-hook (function def-use-list-view-unmark-all))
          (set (make-local-variable 'def-use-list-sym)
               sym)
          (insert (def-use-format-sym sym) "\n"
                  "\n")
          (let* ((refs (def-use-all-refs-sorted sym))
                 (refs (if reverse (reverse refs) refs)))
            (set (make-local-variable 'def-use-list-ref-to-overlay-alist)
                 (mapcar (function list) refs))
            (mapc (function
                   (lambda (ref)
                     (insert (def-use-format-ref ref) "\n")))
                  refs))
          (goto-line 3)
          (setq buffer-read-only t))))))

(defun def-use-list-view-ref ()
  "Finds references on the current line and shows in another window."
  (interactive)
  (beginning-of-line)
  (let ((b (current-buffer))
        (idx (- (def-use-current-line) 3)))
    (when (and (<= 0 idx)
               (< idx (length def-use-list-ref-to-overlay-alist)))
      (forward-line)
      (def-use-goto-ref (car (nth idx def-use-list-ref-to-overlay-alist)) t)
      (switch-to-buffer-other-window b))))

(defun def-use-list-view-mark-all ()
  "Visits all the references and marks them."
  (interactive)
  (when (and def-use-list-ref-to-overlay-alist
             def-use-list-sym)
    (save-window-excursion
      (let ((length (length (def-use-sym-name def-use-list-sym))))
        (mapc (function
               (lambda (ref-overlay)
                 (unless (cdr ref-overlay)
                   (def-use-goto-ref (car ref-overlay) t)
                   (setcdr ref-overlay
                           (def-use-create-overlay
                             length
                             (def-use-ref-pos (car ref-overlay))
                             (- def-use-priority 1)
                             'def-use-mark-face)))))
              def-use-list-ref-to-overlay-alist)))))

(defun def-use-list-view-unmark-all ()
  "Kills all the marks associated with the list view."
  (interactive)
  (when def-use-list-ref-to-overlay-alist
    (mapc (function
           (lambda (ref-overlay)
             (when (cdr ref-overlay)
               (delete-overlay (cdr ref-overlay))
               (setcdr ref-overlay nil))))
          def-use-list-ref-to-overlay-alist)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Info

(defun def-use-show-info ()
  "Shows info on the symbol under the cursor."
  (interactive)
  (let ((sym (def-use-current-sym)))
    (if (not sym)
        (message "%s" def-use-apology)
      (message "%s" (def-use-format-sym sym)))))

(defun def-use-format-sym (sym)
  "Formats a string with some basic info on the symbol."
  (concat (def-use-format-sym-title sym)
          ", "
          (number-to-string (length (def-use-sym-to-uses sym)))
          " uses, defined at: "
          (def-use-format-ref (def-use-sym-ref sym))))

(defun def-use-format-sym-title (sym)
  "Formats a title for the symbol"
  (concat (def-use-add-face 'font-lock-keyword-face
            (copy-sequence (def-use-sym-class sym)))
          " "
          (def-use-add-face (def-use-sym-face sym)
            (copy-sequence (def-use-sym-name sym)))))

(defun def-use-format-ref (ref)
  "Formats a references."
  (let ((pos (def-use-ref-pos ref)))
    (concat (def-use-ref-src ref)
            ":"
            (def-use-add-face 'font-lock-constant-face
              (number-to-string (def-use-pos-line pos)))
            "."
            (def-use-add-face 'font-lock-constant-face
              (number-to-string (def-use-pos-col pos))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Highlighting

(defvar def-use-highlighted-sym nil)
(defvar def-use-highlighted-buffer-file-truename nil)
(defvar def-use-highlighted-overlays nil)

(defun def-use-delete-highlighting ()
  (mapc (function delete-overlay) def-use-highlighted-overlays)
  (setq def-use-highlighted-overlays nil
        def-use-highlighted-sym nil
        def-use-highlighted-buffer-file-truename nil))

(defun def-use-highlight-ref (sym ref face-attr)
  (push (def-use-create-overlay sym ref def-use-priority face-attr)
        def-use-highlighted-overlays))

(defun def-use-create-overlay (length pos priority face-attr)
  (let* ((begin (def-use-pos-to-point pos))
         (beyond (+ begin length))
         (overlay (make-overlay begin beyond)))
    (overlay-put overlay 'priority priority)
    (overlay-put overlay 'face face-attr)
    overlay))

(defun def-use-highlight-sym (sym)
  "Highlights the specified symbol."
  (let ((buffer-file-truename (def-use-buffer-file-truename)))
    (unless (and (equal def-use-highlighted-sym sym)
                 (equal def-use-highlighted-buffer-file-truename
                        buffer-file-truename))
      (def-use-delete-highlighting)
      (when sym
        (setq def-use-highlighted-sym sym
              def-use-highlighted-buffer-file-truename buffer-file-truename)
        (let ((length (length (def-use-sym-name sym)))
              (file-to-poss (def-use-make-hash-table)))
          (mapc (function
                 (lambda (ref)
                   (puthash (def-use-ref-src ref)
                            (cons (def-use-ref-pos ref)
                                  (gethash (def-use-ref-src ref) file-to-poss))
                            file-to-poss)))
                (def-use-sym-to-uses sym))
          (mapc (function
                 (lambda (buffer)
                   (set-buffer buffer)
                   (mapc (function
                          (lambda (pos)
                            (def-use-highlight-ref length pos 'def-use-use-face)))
                         (gethash (def-use-buffer-file-truename) file-to-poss))))
                (buffer-list))
          (let* ((ref (def-use-sym-ref sym))
                 (buffer
                  (def-use-find-buffer-visiting-file (def-use-ref-src ref))))
            (when buffer
              (set-buffer buffer)
              (def-use-highlight-ref
                length (def-use-ref-pos ref) 'def-use-def-face))))))))

(defun def-use-highlight-current ()
  "Highlights the symbol at the point."
  (def-use-highlight-sym (def-use-current-sym)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Highlighting timer

(defvar def-use-highlight-timer nil)

(defun def-use-delete-highlight-timer ()
  (when def-use-highlight-timer
    (compat-delete-timer def-use-highlight-timer)
    (setq def-use-highlight-timer nil)))

(defun def-use-create-highlight-timer ()
  (unless def-use-highlight-timer
    (setq def-use-highlight-timer
          (run-with-idle-timer
           def-use-delay t (function def-use-highlight-current)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode

(defun def-use-mode-enabled-in-some-buffer ()
  (loop for buffer in (buffer-list) do
    (if (with-current-buffer buffer
          def-use-mode)
        (return t))))

(defvar def-use-mode-map (make-sparse-keymap)
  "Keymap for Def-Use mode.  This variable is updated by
`def-use-build-mode-map'.")

(defun def-use-build-mode-map ()
  (let ((result (make-sparse-keymap)))
    (mapc (function
           (lambda (key-command)
             (define-key result (read (car key-command)) (cdr key-command))))
          def-use-key-bindings)
    (setq def-use-mode-map result))
  (let ((cons (assoc 'def-use-mode minor-mode-map-alist)))
    (when cons
      (setcdr cons def-use-mode-map))))

(define-minor-mode def-use-mode
  "Minor mode for highlighting and navigating definitions and uses.

\\{def-use-mode-map}
"
  :lighter " DU"
  :group 'def-use
  :global t
  (def-use-delete-highlight-timer)
  (def-use-delete-highlighting)
  (when (def-use-mode-enabled-in-some-buffer)
    (def-use-create-highlight-timer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Finalization

(setq def-use-load-time nil)

(defun def-use-update ()
  "Update data based on customization variables."
  (def-use-build-mode-map))

(def-use-update)

(provide 'def-use-mode)
