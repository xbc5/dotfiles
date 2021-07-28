;;; org-roam.el -*- lexical-binding: t; -*-

(map! :leader
      :prefix "n"
      :desc "org-roam-node-find" "f" #'org-roam-node-find
      :desc "org-roam-buffer-toggle" "l" #'org-roam-buffer-toggle
      :desc "org-roam-graph" "g" #'org-roam-graph
      :desc "org-roam-node-insert" "i" #'org-roam-node-insert
      :desc "org-roam-capture" "c" #'org-roam-capture
)


(setq org-roam-directory "~/org"
      org-roam-tag-sources '(prop all-directories)
      org-roam-file-completion-tag-position 'append ;; 'prepend | 'append | 'omit
      +org-roam-open-buffer-on-find-file nil)  ;; disable auto-loading of backlinks


(setq org-roam-capture-templates '(("i" "idea" plain #'org-roam-capture--get-point
                                    "\n\n* Ideas\n* Thoughts\n* Questions"
                                    :file-name "${slug}-%<%Y%m%d%H%M%S>"
                                    :head "#+TITLE: ${title}\n#+ROAM_TAGS: TODO %?"
                                    :unnarrowed t)
                                   ("t" "index" plain #'org-roam-capture--get-point
                                    "\n\n* Index\n* Thoughts\n* Questions"
                                    :file-name "${slug}-%<%Y%m%d%H%M%S>"
                                    :head "#+TITLE: ${title}\n#+ROAM_ALIAS: ${title}\n#+ROAM_TAGS: index %?"
                                    :unnarrowed t)
                                   ("p" "project idea" plain #'org-roam-capture--get-point
                                    "\n\n* Summary\n* Ideas\n* Thoughts\n* Questions"
                                    :file-name "project/%(+org-project-subdir)/${slug}-%<%Y%m%d%H%M%S>"
                                    :head "#+TITLE: ${title}\n#+ROAM_TAGS: %?"
                                    :unnarrowed t)
                                   ("b" "bib notes" plain #'org-roam-capture--get-point
                                    "\n\n* Notes\n* Thoughts\n* Questions"
                                    :file-name "bib/notes/${slug}"
                                    :head "#+TITLE: %?\n#+ROAM_KEY: cite:${slug}\n#+ROAM_TAGS: ${slug} bib"
                                    :unnarrowed t)))
