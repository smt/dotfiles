(defvar smt-pre-extensions
  '(
    ;; pre extension smts go here
    )
  "List of all extensions to load before the packages.")

(defvar smt-post-extensions
  '(
    ;; post extension smts go here
    )
  "List of all extensions to load after the packages.")

;; For each extension, define a function smt/init-<extension-smt>
;;
;; (defun smt/init-my-extension ()
;;   "Initialize my extension"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
