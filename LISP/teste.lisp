(load "projetoLisp.lisp")

(defvar AGENDA nil)
(setq AGENDA (incluir AGENDA '(Bel 32338778)))
(setq AGENDA (incluir AGENDA '(Rose 32666556)))
(setq AGENDA (incluir AGENDA '(Rose 991919191)))
(setq AGENDA (incluir AGENDA '(Beto 32529119)))
(format t "Apos inclusoes: ~a~%" AGENDA)

(setq AGENDA (excluir AGENDA '(Rose 991919191)))
(format t "Apos excluir Rose 991919191: ~a~%" AGENDA)

(setq AGENDA (excluir AGENDA '(Rose 91919191)))
(format t "Apos excluir telefone inexistente: ~a~%" AGENDA)

(setq AGENDA (excluir AGENDA '(Rose 32666556)))
(format t "Apos excluir ultimo telefone da Rose: ~a~%" AGENDA)