;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; FIXME: some packages (like org-ref) are using directives without bangs!, this could be a source of things not working
;;  TODO: research this
; LocalWords:  rfc


;; ######################################################################
;; ########################### GLOBAL CONFIG ############################
;; ######################################################################
;;
(setq display-line-numbers-type t)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")


;; ######################################################################
;; ############################ DOOM CONFIG #############################
;; ######################################################################
;;
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
 (setq doom-font (font-spec :family "monospace" :size 15 :weight 'semi-light)
       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;;
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;;
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; ######################################################################
;; ######################### PERSONAL FUNCTIONS #########################
;; ######################################################################
;;
;; # RFC: used for links -- e.g. rfc:4749
(defun my/open-rfc-link (path)
  "Open IETF docs given only a number > 0."
  (browse-url (format "https://tools.ietf.org/html/rfc%s" path))
)

(defun my/open-coinmarketcap-link (path)
  "Open CMC token page."
  (browse-url (format "https://coinmarketcap.com/currencies/%s" path))
)

(defun my/open-reddit-link (path)
  "Open Reddit page."
  (browse-url (format "https://libredd.it/%s" path))
)

(defun my/open-caniuse-link (path)
  "Open Can I Use reference."
  (browse-url (format "https://caniuse.com/?search=%s" path))
)

(defun my/open-mdncss-link (path)
  "Open an MDN CSS reference page."
  (browse-url (format "https://developer.mozilla.org/en-US/docs/Web/CSS/%s" path))
)

(defun my/open-hn-link (path)
  "Open an MDN CSS reference page."
  (browse-url (format "https://news.ycombinator.com/item?id=%s" path))
  )

; THIS is what the template will look like to use +org-project-subdir
;(setq org-roam-capture-templates
;        '(("d" "default" plain
;           #'org-roam-capture--get-point
;          "%?"
;           :file-name "%(+org-notes-subdir)/%<%Y%m%d%H%M%S>-${slug}"
;           :head "#+TITLE: ${title}\n#+TIME-STAMP: <>\n\n"
;           :unnarrowed t)))

(defun +org-project-subdir ()
  "Select a project subdirectory."
  (interactive)
  (let ((dirs (cons "."
                    (seq-map  ; apply a function to each list item, return a single result
                     (lambda (p) ; the function
                       (string-remove-prefix org-roam-directory p))  ; remove ~/org from roam dir
                     (+file-subdirs (format "%s/project" org-roam-directory) nil t)))))
    (completing-read "Project: " dirs nil nil)))

(defun +file-subdirs (directory &optional filep rec)
  "Return subdirs or files of DIRECTORY according to FILEP.

If REC is non-nil then do recursive search."
  (let ((res  ; res is a list of files in a directory
         (seq-remove
          (lambda (file)
            (or (string-match "\\`\\."
                              (file-name-nondirectory file))
                (string-match "\\`#.*#\\'"
                              (file-name-nondirectory file))
                (string-match "~\\'"
                              (file-name-nondirectory file))
                ; check if 'file' is a directory => boolean
                (if filep
                    (file-directory-p file)             ; does it
                  (not (file-directory-p file)))))      ; does it
          ; get a list of names in a directory
          (directory-files directory t))))
    (if rec
        (+seq-flatten ; flattent a list of lists -- to a single list
         (seq-map (lambda (p) (cons p (+file-subdirs p)))  ; apply a function to each (flattened) list item, get result
                  res))
      res)))

(defun +seq-flatten (list-of-lists)
  "Flatten LIST-OF-LISTS."
  (apply #'append list-of-lists))

;; ######################################################################
;; ########################### SPELL CHECKING ###########################
;; ######################################################################
;;- see: https://www.emacswiki.org/emacs/InteractiveSpell
;; - frontends
;;   - flyspell: handles /highlighting/
;;     - uses hunspell|aspell|ispell backend
;;   - ispell: handles /interactive/ spell-checking
;;     - uses hunspell|aspell|ispell backend
;;   - spell-fu: does highlighting, and correct on selection
;;     - BUG: disabled, because words are neve un-highlighted
;; - backends
;;   - aspell: slow, but focuses on quality of suggestions
;; ----
;;
;; # FlySpell
;; - see: https://www.emacswiki.org/emacs/FlySpell
;; - ispell-program-name: set the ispell backend, which flyspell also uses
;; -----
;;
;; config
(after! flyspell
  (setq flyspell-issue-message-flag nil) ;; emits a message for each word, causes huge slowdown
)
;;
;; enable major-modes
(add-hook 'text-mode-hook 'flyspell-mode)       ;; for text files
(add-hook 'prog-mode-hook 'flyspell-prog-mode)  ;; for source code comments
;;
;; DEPRECATED: works find without
;; unmark words that are added to the personal dictionary
;;(defun flyspell-buffer-after-pdict-save (&rest _)
;;  (flyspell-buffer))
;;(advice-add 'ispell-pdict-save :after #'flyspell-buffer-after-pdict-save)
;;
;; # ISpell
;; - ispell-extra-args; to pass aspell params
;; - ispell-pogram-name: you may need to set this to aspell
;; -----
;;
;; ispell is built-in, 'after! ispell' appears to not work
(setq ispell-dictionary "british")
;; FIXME: use nil, but ispell for some reason falls back to ~/.emacs.d/.local/...
(setq ispell-personal-dictionary "~/.aspell.en.pws")  ;; nil means use the backend checker's default
(setq ispell-program-name "aspell")    ;; it is the backend of ispell

;; helm-dash
(setq helm-dash-browser-func 'eww)

;; dash-docs
(setq dash-docs-docsets-path "~/doc/docsets"
      dash-docs-browser-func 'eww)


;; ######################################################################
;; ############################### ORG ##################################
;; ######################################################################
;;
(make-directory "~/org" t)  ;; t to ignore 'exists' error
;;
;; # Config
(after! org
  (add-to-list 'org-modules 'ol-info) ;; for 'info:' links
  (org-add-link-type "rfc" 'my/open-rfc-link)
  (org-add-link-type "cmc" 'my/open-coinmarketcap-link)
  (org-add-link-type "caniuse" 'my/open-caniuse-link)
  (org-add-link-type "mdn-css" 'my/open-mdncss-link)
  (org-add-link-type "reddit" 'my/open-reddit-link)
  (org-add-link-type "hn" 'my/open-hn-link)
  (setq org-startup-folded t
        org-cycle-max-level 2
        org-directory "~/org"
        org-refile-targets '((nil :maxlevel . 3)
                             (("*.org") :maxlevel . 3))   ;; refile to other files
        org-outline-path-complete-in-steps nil                                       ;; refile in a single go
        org-refile-use-outline-path t                                                ;; show file path for refiling
        org-todo-keywords '((sequence "TODO(t)" "STRT(i)" "WAIT(w)" "|" "DONE(d)" "DROP(c)"))
        org-todo-keyword-faces
        '(("TODO" :foreground "#16cafa")
          ("STRT" :foreground "magenta")
          ("WAIT" :foreground "brown")
          ("DONE" :foreground "#666666")
          ("DROP" :foreground "#666666"))
        org-capture-templates '(("f" "Fleeting notes" entry (file+olp+datetree "fleeting.org") "* %?")
                                ("t" "TODO")
                                ;; TODO: use a variable of some kind
                                ("tb" "Biz" entry (file+headline "todo.org" "Biz") "* TODO [#D] %?")
                                ("td" "Dev" entry (file+headline "todo.org" "Dev") "* TODO [#D] %?")
                                ("tg" "General" entry (file+headline "todo.org" "General") "* TODO [#D] %?"))
        org-highest-priority 65
        org-lowest-priority 69
        org-default-priority 68
        org-priority-faces '((65 :foreground "red" :weight bold)
                             (66 :foreground "orange" :weight bold)
                             (67 :foreground "yellow" :weight bold)
                             (68 :foreground "green" :weight bold)
                             (69 :foreground "#2a7286" :weight bold))
  )
)
;;
;; # todo Priotities
;; use symbols instead of '[#A]' etc.
(use-package! org-fancy-priorities
  :hook (org-mode . org-fancy-priorities-mode)
  :config (setq org-fancy-priorities-list '((65 . "1")
                                            (66 . "2")
                                            (67 . "3")
                                            (68 . "4")
                                            (69 . "9")))
)


;; ######################################################################
;; ############################ ORG-ROAM ################################
;; ######################################################################
;;
;; TODO: disable backlink mode, it's only useful /sometimes/
;;


(after! org-roam-bibtex
  (setq orb-templates
        '(("b" "bib" plain (function org-roam-capture--get-point)
           "\n\n* Context\n* Notes\n* Thoughts\n* Questions"
           :file-name "bib/notes/${citekey}"
           :head "#+TITLE: ${citekey}: ${title}\n#+ROAM_KEY: ${ref}\n#+ROAM_TAGS: \"bib notes\" unfinished TODO %?"
           :unnarrowed t)
        )
  )
)

;; ######################################################################
;; ########################## ORG-ROAM-SERVER ###########################
;; ######################################################################
;;
;;

;; ######################################################################
;; ############################# ORG-REF ################################
;; ######################################################################
;;
(defun dnd-unescape-uri () nil)
;; config options -- set these, these are used for all org-ref configuration.
(setq my/bib-file "~/org/bib/refs.bib"
      my/bib-pdfs "~/org/bib/pdfs"
      my/bib-notes-dir "~/org/bib/notes"
      my/bib-notes-file "~/org/bib/notes.org" ; FIXME: I am not entirely sure what this does
)
;;
;; built-in packages
(setq reftex-default-bibliography my/bib-file
      bibtex-completion-bibliography my/bib-file
      bibtex-completion-library-path my/bib-pdfs
      bibtex-completion-notes-path my/bib-notes-dir
      bibtex-completion-pdf-open-function (lambda (fpath)
                                            (start-process "open" "*open*" "open" fpath))
)
;;
;; configure org-ref
(use-package! org-ref
              :config
              (setq org-ref-notes-directory my/bib-notes-dir
                    org-ref-bibliography-notes my/bib-notes-file
                    org-ref-default-bibliography (list my/bib-file)
                    org-ref-pdf-directory my/bib-pdfs
                    ;;org-ref-completion-library 'org-ref-ivy-cite ;; BUG this breaks links, use helm instead
              )
)

;;
;; ivy-bibtex
;;   - ivy-bibtex requires ivy's `ivy--regex-ignore-order` regex builder, which
;;     ignores the order of regexp tokens when searching for matching candidates.
(after! ivy-bibtex
  (setq ivy-re-builders-alist
        '((ivy-bibtex . ivy--regex-ignore-order)
          (t . ivy--regex-plus)))
)


;; ######################################################################
;; ########################### BEACON-MODE ##############################
;; ######################################################################
;;
(after! beacon
  (beacon-mode 1) ;; FIXME: doesn't work, why?
)

;; ######################################################################
;; ############################ PROJECTILE ##############################
;; ######################################################################
(use-package! projectile
              :config
              (setq projectile-project-search-path '("~/org" "~/projects"))
)

;; ######################################################################
;; ############################# PLANTUML ###############################
;; ######################################################################
;;
;; - executable mode runs for both *.org and *.plantuml files
;;   - although, *.plantuml still attempt to run jar files
;; - this config uses a local install of plantuml, you must install it locally
;; - there are plantuml, and org-plantuml configurations
;; FIXME: this is causing an error message when doom reloads
(use-package! plantuml-mode
              :after (org)
              :config
              (setq plantuml-default-exec-mode 'executable                              ;; jar|executable
                    plantuml-jar-path "/usr/share/java/plantuml.jar"                    ;; used directly by *.plantuml files
                    org-plantuml-jar-path "/usr/share/java/plantuml.jar"                ;; this..
                    org-plantuml-executable-path "/usr/bin/plantuml")                   ;;   or this is redundant. who cares?
              (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))                ;; specify plantuml language for org mode
              (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))        ;; enable mode automatically for *.plantuml files
              (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t))) ;; load plantuml language for babel source blocks
              (add-to-list 'org-structure-template-alist '("p" . "src plantuml :file img/default.png\n@startuml\n\n@enduml"))
)

;; FIXME: I'm unable to get it working for org-mode
(use-package! hl-todo
              :config
              (add-to-list 'hl-todo-keyword-faces '("WARN" error bold))
              (add-to-list 'hl-todo-keyword-faces '("WARNING" error bold))
              (add-to-list 'hl-todo-include-modes 'org-mode)
              (setq hl-todo-exclude-modes nil           ;; by default orgmode is excluded
                    global-hl-todo-mode t               ;; enable it globally
              )
)

;; ######################################################################
;; ############################ RUST-MODE ###############################
;; ######################################################################
(use-package! rust-mode
              :hook (rust-mode-hook . (setq indent-tabs-mode nil))
              :config
              (setq rust-format-on-save t)
)


(load! "org-roam-server.el")
(load! "org-roam.el")
(load! "org-roam-bibtex.el")
(load! "emacs.el")
