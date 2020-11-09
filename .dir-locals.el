;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((org-mode . ((eval . (progn
                        (require 'org-id)
                        (require 'ox-hugo)
                        (require 'citeproc-org)
                        (with-eval-after-load 'citeproc-org
                          (citeproc-org-setup)
                          (setq citeproc-org-org-bib-header "** References\n")

                          (defun tq/min-headline-level ()
                            (--> (org-element-parse-buffer)
                                 (org-element-map it 'headline (apply-partially #'org-element-property :level))
                                 (or it '(0))
                                 (-min it)))

                          (defun tq/citeproc-org-render-references-advice (orig args)
                            (let* ((minlevel (tq/min-headline-level))
                                   (totallevel (max 1 minlevel))
                                   (citeproc-org-org-bib-header
                                    (concat (make-string totallevel ?*)
                                            (string-trim-left citeproc-org-org-bib-header "\\**"))))
                              (apply orig args)))

                          (advice-add 'cite-proc-org-render-references :around
                                      #'tq/citeproc-org-render-references-advice))))
              (org-ref-default-bibliography . ("build/references.bib"))
              (eval . (add-to-list 'org-hugo-external-file-extensions-allowed-for-copying "asc")))))
