;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((org-mode . ((eval . (progn
                        (load-file (expand-file-name
                                    "build/tquelch-dev.el"
                                    (file-name-directory (buffer-file-name))))
                        (tquelch-dev-mode))))))
