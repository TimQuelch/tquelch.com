(require 'org)
(require 'org-id)
(require 'ox-hugo)
(require 'citeproc-org)
(require 'magit)
(require 'dash)

(defun tqdev/min-headline-level ()
  (--> (org-element-parse-buffer)
       (org-element-map it 'headline (apply-partially #'org-element-property :level))
       (or it '(0))
       (-min it)))

(defun tqdev/citeproc-org-render-references-advice (orig args)
  (let* ((minlevel (tqdev/min-headline-level))
         (totallevel (max 1 minlevel))
         (citeproc-org-org-bib-header
          (concat (make-string totallevel ?*)
                  (string-trim-left citeproc-org-org-bib-header "\\**"))))
    (apply orig args)))

(defun tqdev/remove-published ()
  (when (equal org-state "PUBLISHED")
              (org-todo "")
              (org-add-planning-info 'closed (org-current-effective-time))))

(define-minor-mode tquelch-dev-mode
  "Minor mode for developing my website"
  :lighter " tqdev"
  (cond
   (tquelch-dev-mode
    (citeproc-org-setup)
    (setq-local citeproc-org-org-bib-header "* References\n")
    (advice-add 'cite-proc-org-render-references :around
                #'tqdev/citeproc-org-render-references-advice)
    (setq-local org-ref-default-bibliography '("build/references.bib"))
    (add-to-list 'org-hugo-external-file-extensions-allowed-for-copying "asc")
    (setq-local org-latex-prefer-user-labels t)
    (setq-local org-hugo-date-format "%Y-%m-%d")
    (add-hook 'org-after-todo-state-change-hook #'tqdev/remove-published)
    (setq-local org-footnote-section nil))
   (t
    (advice-remove 'cite-proc-org-render-references
                   #'tqdev/citeproc-org-render-references-advice)
    (remove-hook 'org-after-todo-state-change-hook #'tqdev/remove-published))))
