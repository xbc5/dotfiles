; TODO: bind helm-bibtef
(after! org-roam-bibtex
  (after! org-roam
    ;(add-hook 'org-roam-mode 'org-roam-bibtex-mode)
    (require 'org-ref)
    (org-roam-bibtex-mode)))
