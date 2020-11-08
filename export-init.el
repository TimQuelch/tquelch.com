;;; export-init  --- Set up environment for exporting
;;; Commentary:
;;
;; Sets up package repos and installs those which are required for export. Actual configuration of
;; export is done in .dir-locals
;;
;;; Code:

;; Set up package repos
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(defvar required-packages
  '(org ox-hugo)
  "The required packages.")

(defun install-required-packages (&optional refresh)
  "Install the required packages. If REFRESH is non-nil, refresh package list."
  (when refresh
    (package-refresh-contents))
  (dolist (p required-packages)
    (package-install p t)))

;; Install the packages, if any aren't found, refresh the package list and try again
(condition-case nil
    (install-required-packages)
  (error (install-required-packages t)))

(require 'org)
(require 'ox-hugo)

;; Enable local variables with no checks
;; This allows automatic setting of .dir-locals.el variables in batch mode
(setq enable-local-variables :all)

(provide 'export-init)
;;; export-init.el ends here
