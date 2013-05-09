;;; rebar-mode.el --- Run eunit right from emacs using rebar.

;; TODO
;;  *
;;

;; (require 'erlang-mode)

(define-prefix-command 'rebar-mode-keymap)
(define-key rebar-mode-keymap (kbd "v") 'rebar-verify)
(define-key rebar-mode-keymap (kbd "a") 'rebar-verify-all)
(define-key rebar-mode-keymap (kbd "t") 'rebar-toggle-spec-and-target)

(defgroup rebar-mode nil "Eunit minor mode.")

(defcustom rebar-command "rebar eunit"
  "The command for eunit"
  :type 'string
  :group 'rebar-mode)

(defcustom rebar-compilation-buffer-name "*compilation*"
  "The compilation buffer name for eunit"
  :type 'string
  :group 'rebar-mode)

(defcustom rebar-key-command-prefix (kbd "C-c ,")
  "The prefix for all eunit related key commands")

(define-minor-mode rebar-mode
  "Minor mode for eunit files"
  :lighter " Eunit":keymap `((,rebar-key-command-prefix . rebar-mode-keymap)))

(defun rebar-verify ()
  "Runs the specified eunit, or the eunit file for the current buffer."
  (interactive)
  (rebar-run-single-file (buffer-file-name)))

(defun rebar-verify-all ()
  "Runs the 'eunit' rebar task for the project of the current file."
  (interactive)
  (rebar-run ()))

(defun rebar-toggle-test-and-target ()
  "Switches to the eunit for the current buffer if it is a
  non-eunit file, or switch to the target of the current buffer
  if the current is an eunit"
  (interactive)
  (file-file
   (if (rebar-buffer-is-spec-p)
       (rebar-target-file-for (buffer-file-name))
     (rebar-file_for (buffer-file-name)))))

(defun rebar-buffer-is-spec-p ()
  "Returns true if the current buffer is an eunit"
  (and (buffer-file-name)
       (rebar-file-p (buffer-file-name))))

(defun rebar-file-p (a-file-name)
  "Return true if the specified file is an eunit"
  (numberp (string-match "\\(_\\|-\\)test\\_test.erl$" a-file-name)))

(defun rebar-run-single-file (rebar-file)
  "Runs rebar on the specified file"
  (compile (concat rebar-project-root " rebar eunit")))


(defun rebar-project-root (&optional directory)
  "Finds the root directory of the project by walking the directory tree until it finds a rebar.config file."
  (let ((directory (file-name-as-directory (or directory default-directory))))
    (cond ((rebar-root-directory-p directory)
           (error "Could not determine the project root."))
          ((file-exists-p (expand-file-name "rebar-config" directory)) directory)
          (t (rebar-project-root (file-name-directory (directory-file-name directory)))))))

(defun rebar-root-directory-p (a-directory)
  "Returns t if a-directory is the root"
  (equal a-directory (rebar-parent-directory a-directory)))
