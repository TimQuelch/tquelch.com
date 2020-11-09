;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((org-mode . ((eval . (progn
                        (require 'org-id)
                        (require 'ox-hugo)
                        (require 'citeproc-org)
                        (with-eval-after-load 'citeproc-org
                          (citeproc-org-setup))))
              (org-ref-default-bibliography . ("static/references.bib"))
              (eval . (add-to-list 'org-hugo-external-file-extensions-allowed-for-copying "asc")))))