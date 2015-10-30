;; config.el

;; follow symlinks without asking
(setq vc-follow-symlinks t)

;; line numbers when i'm coding pls
(dolist (mode '(c
                clojure
                css
                dockerfile
                emacs-lisp
                go
                haml
                html
                jade
                jekyll-html
                js2
                json
                jsx
                lisp
                php
                python
                sass
                scss
                stylus
                web
                yaml))
  (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
            'linum-mode))

;; flycheckin'
;(dolist (mode '(c
;                clojure
;                css
;                emacs-lisp
;                go
;                js2
;                json
;                jsx
;                lisp
;                php
;                python
;                sass
;                scss
;                stylus
;                web
;                yaml))
;  (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
;            'flycheck-mode))


;;;; ledger

(setq ledger-post-account-alignment-column 2)
(setq ledger-post-amount-alignment-column 62)


;;;; IRC

(setq rcirc-server-alist
      '(("irc.freenode.net"
         :nick "smtudor"
         :user-name "smtudor"
         :full-name "Stephen Tudor"
         :channels (
                    "#angularjs"
                    "#boardgames"
                    "#clojurescript"
                    "#duckduckgo"
                    "#emacs"
                    "#org-mode"
                    "#meteor"
                    "#neovim"
                    "#Node.js"
                    "#reactjs"
                    ))))
;; (setq rcirc-authinfo
;;       '(("freenode" nickserv "smtudor" "s3cr3t")))

(defvar rcirc-authinfo-file-name
  "~/.rcirc-authinfo"
  "File containing rcirc authentication passwords.
The file consists of a single list, with each element itself a
list with a SERVER-REGEXP string, a NICK-REGEXP string, a METHOD
and the remaining method specific ARGUMENTS.  The valid METHOD
symbols are `nickserv', `chanserv' and `bitlbee'.

The required ARGUMENTS for each METHOD symbol are:
`nickserv': PASSWORD
`chanserv': CHANNEL PASSWORD
`bitlbee': PASSWORD

Example:
((\"freenode\" \"bob\" nickserv \"p455w0rd\")
(\"freenode\" \"bob\" chanserv \"#bobland\" \"passwd99\")
(\"bitlbee\" \"robert\" bitlbee \"sekrit\"))")

(defvar rcirc-auto-authenticate-flag (file-readable-p rcirc-authinfo-file-name)
  "*Non-nil means automatically send authentication string to server.
See also `rcirc-auth'")


;;;; Org

(setq org-agenda-files '("~/Documents/org"))
(setq org-agenda-start-on-weekday 0)
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")
(setq org-catch-invisible-edits t)
(setq org-directory "~/Documents/org")
(setq org-default-notes-file "~/Documents/org/inbox.org")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)
   (js . t)
   (emacs-lisp . t)))

(add-hook 'org-clock-out-hook 'smt/remove-empty-drawer-on-clock-out 'append)

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets '((nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 9)))

; Use full outline paths for refile targets
(setq org-refile-use-outline-path t)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes 'confirm)

; Keep agenda generation fast by defaulting span to 1 day
;; (setq org-agenda-span 'day)

; Prevent org-mode from trying to show incorrect data
(setq org-stuck-projects (quote ("" nil nil "")))

;; (setq org-agenda-exporter-settings
;;       '((ps-number-of-columns 2)
;;         (ps-landscape-mode t)
;;         (ps-top-margin 18)
;;         (ps-right-margin 18)
;;         (ps-bottom-margin 18)
;;         (ps-left-margin 18)
;;         (org-agenda-add-entry-text-maxlines 0)))

(setq org-agenda-custom-commands
      '(("d" "Daily Action List"
         ((agenda ""
          ((org-agenda-ndays 1)
           (org-agenda-sorting-strategy
             '((agenda time-up priority-down tag-up)))
           (org-deadline-warning-days 0)))))
        ("E" "Errand List"
         ((tags-todo "@errand")))
        ("h" "Home List"
         ((tags-todo "@home")))
        ("o" "Office List"
         ((tags-todo "@office")))
        ("n" "Next and Waiting Lists"
         ((todo "NEXT")
          (todo "WAITING")))
        (" " "Agenda"
         ((agenda ""
                  ((org-agenda-ndays 1)))
          (tags "REFILE"
                ((org-agenda-overriding-header "Tasks to Refile")
                 (org-tags-match-list-sublevels nil)))
          (tags-todo "-CANCELLED/!"
                     ((org-agenda-overriding-header "Stuck Projects")
                      (org-agenda-skip-function 'smt/skip-non-stuck-projects)
                      (org-agenda-sorting-strategy '(category-keep))))
          (tags-todo "-HOLD-CANCELLED/!"
                     ((org-agenda-overriding-header "Projects")
                      (org-agenda-skip-function 'smt/skip-non-projects)
                      (org-tags-match-list-sublevels 'indented)
                      (org-agenda-sorting-strategy '(category-keep))))
          (tags-todo "-CANCELLED/!NEXT"
                     ((org-agenda-overriding-header (concat "Project Next Tasks"
                                                            (if smt/hide-scheduled-and-waiting-next-tasks
                                                                ""
                                                              " (including WAITING and SCHEDULED tasks)")))
                      (org-agenda-skip-function 'smt/skip-projects-and-habits-and-single-tasks)
                      (org-tags-match-list-sublevels t)
                      (org-agenda-todo-ignore-scheduled smt/hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-todo-ignore-deadlines smt/hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-todo-ignore-with-date smt/hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-sorting-strategy '(todo-state-down effort-up category-keep))))
          (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                     ((org-agenda-overriding-header (concat "Project Subtasks"
                                                            (if smt/hide-scheduled-and-waiting-next-tasks
                                                                ""
                                                              " (including WAITING and SCHEDULED tasks)")))
                      (org-agenda-skip-function 'smt/skip-non-project-tasks)
                      (org-agenda-todo-ignore-scheduled smt/hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-todo-ignore-deadlines smt/hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-todo-ignore-with-date smt/hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-sorting-strategy '(category-keep))))
          (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                     ((org-agenda-overriding-header (concat "Standalone Tasks"
                                                            (if smt/hide-scheduled-and-waiting-next-tasks
                                                                ""
                                                              " (including WAITING and SCHEDULED tasks)")))
                      (org-agenda-skip-function 'smt/skip-project-tasks)
                      (org-agenda-todo-ignore-scheduled smt/hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-todo-ignore-deadlines smt/hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-todo-ignore-with-date smt/hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-sorting-strategy '(category-keep))))
          (tags-todo "-CANCELLED+WAITING|HOLD/!"
                     ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
                                                            (if smt/hide-scheduled-and-waiting-next-tasks
                                                                ""
                                                              " (including WAITING and SCHEDULED tasks)")))
                      (org-agenda-skip-function 'smt/skip-non-tasks)
                      (org-tags-match-list-sublevels nil)
                      (org-agenda-todo-ignore-scheduled smt/hide-scheduled-and-waiting-next-tasks)
                      (org-agenda-todo-ignore-deadlines smt/hide-scheduled-and-waiting-next-tasks)))
          (tags "-REFILE"
                ((org-agenda-overriding-header "Tasks to Archive")
                 (org-agenda-skip-function 'smt/skip-non-archivable-tasks)))
          ))
       ))

;; Add some flavorful holidays to the calendar
(setq holiday-other-holidays
      '((holiday-fixed 3 14 "Pi Day")
        (holiday-fixed 4 15 "Tax Day")
        (holiday-fixed 5 5 "Cinqo de Mayo")
        (holiday-fixed 9 11 "Patriot Day")
        (holiday-sexp '(calendar-gregorian-from-absolute
                       (1+ (calendar-dayname-on-or-before
                             1 (+ 6 (calendar-absolute-from-gregorian
                                     (list 11 1 year))))))
                      "Election Day")
       ))

;; (add-hook 'remember-mode-hook 'org-remember-apply-template)
;; (define-key global-map "\C-cr" 'org-remember)
(setq org-capture-templates
  '(("i" "Inbox"      entry (file "~/Documents/org/inbox.org")
       "* TODO %^{Headline}%?\n%U\n%a\n")
    ("r" "Respond"    entry (file "~/Documents/org/inbox.org")
       "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :immediate-finish t)
    ("n" "Note"       entry (file "~/Documents/org/inbox.org")
       "* %^{Headline}%? :NOTE:\n%U\n%a\n")
    ("j" "Journal"    entry (file+datetree "~/Documents/org/journal.org")
       "* %^{Headline}%?\n%U\n")
    ("m" "Meeting"    entry (file "~/Documents/org/inbox.org")
       "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
    ("p" "Phone call" entry (file "~/Documents/org/inbox.org")
       "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
    ;; ("h" "Habit"      entry (file "~/Documents/org/inbox.org")
    ;;    "* NEXT %^{Headline}%?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
    ("t" "Todo"       entry (file+headline "~/Documents/org/gtd.org" "TASKS")
       "* TODO %^{BriefDesc} %^g\n%?\nAdded: %T")
    ("k" "Killring"   entry (file "~/Documents/org/inbox.org")
       "* Clipboard %U :CLIP:\n%c\n%a\n" :immediate-finish t)
    ;; ("r" "Receipt"  entry (file+headline "~/Documents/org/journal.org" "FINANCES")
    ;;    "* %^{BriefDesc} %U :RECEIPT: \n%?")
    ;; ("n" "Note"     entry (file+datetree "~/Documents/org/privnotes.org")
    ;;    "\n* %^{Headline} %T\n%i%?\n")
    ;; ("n" "Contact"  entry (file+headline "~/Documents/org/privnotes.org" "CONTACTS")
    ;;    "\n* %^{Name} :CONTACT:\n%[~/Documents/org/capture/contact.txt]\n")
    ("b" "Book"     entry (file+headline "~/Documents/org/journal.org" "BOOKS")
       "* %^{Book Title} %t :BOOK: \n%[~/Documents/org/capture/book.txt]\n")
    ("c" "Coffee"   entry (file+headline "~/Documents/org/journal.org" "COFFEE")
       "* %^{Coffee Name} %t\n%[~/Documents/org/capture/coffee.txt] \n")
    ("a" "Daily Review" entry (file+headline "~/Documents/org/journal.org" "REVIEW")
       "* %t :COACH: \n%[~/Documents/org/capture/daily_review.txt]\n")
    ("s" "Someday"      entry (file "~/Documents/org/someday.org")
       "* %^{Someday Heading} %U\n%?\n")
    ("w" "Wishlist"     checkitem (file "~/Documents/org/wishlist.org")
       "[ ] %^{Item} %?")
  ))

; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?h)
                            (:endgroup)
                            ("DAILY" . ?d)
                            ("PROJECT" . ?p)
                            ("WAITING" . ?w)
                            ("HOLD" . ?H)
                            ("PERSONAL" . ?P)
                            ("WORK" . ?W)
                            ("crypt" . ?E)
                            ("NOTE" . ?n)
                            ("CANCELLED" . ?c)
                            ("FLAGGED" . ??))))

; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

(setq org-todo-state-tags-triggers
    '(("CANCELLED" ("CANCELLED" . t))
      ("WAITING" ("WAITING" . t))
      ("HOLD" ("WAITING") ("HOLD" . t))
      (done ("WAITING") ("HOLD"))
      ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
      ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
      ("DONE" ("WAITING") ("CANCELLED") ("HOLD"))))

