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
(package-initialize)

(defvar required-packages
  '(org ox-hugo citeproc-org magit dash)
  "The required packages.")

(defun install-required-packages (&optional refresh)
  "Install the required packages. If REFRESH is non-nil, refresh package list."
  (when refresh
    (package-refresh-contents))
  (dolist (p required-packages)
    (package-install p t))
  (org-version nil t t))

;; Install the packages, refresh contents to make sure getting latest versions
(install-required-packages t)

;; Enable local variables with no checks
;; This allows automatic setting of .dir-locals.el variables in batch mode
(setq enable-local-variables :all)

;; Disable backupfiles
(setq make-backup-files nil)

(provide 'export-init)
;;; export-init.el ends here
