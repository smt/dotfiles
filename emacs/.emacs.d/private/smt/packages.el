(defvar smt-packages
  '(
    ;; package smts go here
    ;; cljsbuild-mode
    ;; editorconfig
    ;; geben
    ;; haml-mode
    jade-mode
    jekyll-modes
    js-doc
    js2-mode
    jsx-mode
    ;; karma
    ;; moz
    ;; nodejs-repl
    ;; om-mode
    ;; pandoc-mode
    react-snippets
    sass-mode
    skewer-mode
    smartparens
    stylus-mode
    web-mode
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar smt-excluded-packages '()
  "List of packages to exclude.")

;; For each package, define a function smt/init-<package-smt>
;;
;; (defun smt/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

(defun smt/init-cljsbuild-mode ()
  (use-package cljsbuild-mode
    :defer t))

(defun smt/init-editorconfig ()
  (use-package editorconfig
    :defer t))

(defun smt/init-geben-mode ()
  (use-package geben-mode
    :defer t))

(defun smt/init-haml-mode ()
  (use-package haml-mode
    :defer t))

(defun smt/init-jade-mode ()
  (use-package jade-mode
    :defer t))

(defun smt/init-jekyll-modes ()
  (use-package jekyll-modes
    :defer t))

(defun smt/init-js-doc ()
  (use-package js-doc
    :defer t))

(defun smt/init-js2-mode ()
  (use-package js2-mode
    :defer t
    :init
    (progn
      ;; (setq js2-basic-offset 2
      ;;       js2-bounce-indent-p t)
      (add-hook 'js2-mode-hook (lambda ()
                                 (electric-indent-mode -1))))
    ))

(defun smt/init-jsx-mode ()
  (use-package jsx-mode
    :defer t))
    ;:init
    ;(progn
      ;(add-to-list 'auto-mode-alist '("\\jsx$" . jsx-mode)))))

(defun smt/init-karma ()
  (use-package karma
    :defer t))

(defun smt/init-moz ()
  (use-package moz
    :defer t))

(defun smt/init-nodejs-repl ()
  (use-package nodejs-repl
    :defer t))

;; (defun smt/init-om-mode ()
;;   (use-package om-mode
;;     :defer t))

(defun smt/init-pandoc-mode ()
  (use-package pandoc-mode
    :defer t))

(defun smt/init-react-snippets ()
  (use-package react-snippets
    :defer t))

(defun smt/init-sass-mode ()
  (use-package sass-mode
    :defer t))

(defun smt/init-skewer-mode ()
  (use-package skewer-mode
    :defer t
    :init
    (add-hook 'js2-mode-hook 'skewer-mode)
    (add-hook 'css-mode-hook 'skewer-css-mode)
    (add-hook 'html-mode-hook 'skewer-html-mode)
    (evil-leader/set-key "msb" 'skewer-load-buffer)
    (evil-leader/set-key "msB" (lambda ()
                                 (skewer-load-buffer)
                                 (skewer-repl))
    (evil-leader/set-key "msf" 'skewer-eval-defun)
    (evil-leader/set-key "msF" (lambda ()
                                 (skewer-eval-defun)
                                 (skewer-repl))
    ))))

(defun smt/init-smartparens ()
  (use-package smartparens
    :defer t
    :init
    (progn
      (eval-after-load "yasnippet"
        '(progn
           (defadvice yas-expand (before advice-for-yas-expand activate)
             (turn-off-smartparens-mode))
           (defadvice yas-expand (after advice-for-yas-expand activate)
             (turn-on-smartparens-mode)))
             ;; (sp-remove-active-pair-overlay)))
           ))
      ))

(defun smt/init-stylus-mode ()
  (use-package stylus-mode
    :defer t))

(defun smt/init-web-mode ()
  (use-package web-mode
    :defer t
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\\jsx$" . web-mode)))))
