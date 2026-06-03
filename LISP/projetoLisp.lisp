(defun anexar (lista elemento)
  (cond ((null lista) (cons elemento nil))
        (t (cons (car lista) (anexar (cdr lista) elemento)))))

(defun remover-elem (lista elemento)
  (cond ((null lista) nil)
        ((equal (car lista) elemento) (cdr lista))
        (t (cons (car lista) (remover-elem (cdr lista) elemento)))))

(defun montar (nome telefones resto)
  (cond ((null telefones) resto)
        (t (cons (cons nome telefones) resto))))

(defun incluir-aux (agenda nome telefone)
  (cond ((null agenda)
         (cons (cons nome (cons telefone nil)) nil))
        ((eq (car (car agenda)) nome)
         (cons (cons nome (anexar (cdr (car agenda)) telefone))
               (cdr agenda)))
        (t (cons (car agenda) (incluir-aux (cdr agenda) nome telefone)))))

(defun incluir (agenda novo)
  (incluir-aux agenda (car novo) (car (cdr novo))))

(defun excluir-aux (agenda nome telefone)
  (cond ((null agenda) nil)
        ((eq (car (car agenda)) nome)
         (montar nome
                 (remover-elem (cdr (car agenda)) telefone)
                 (cdr agenda)))
        (t (cons (car agenda) (excluir-aux (cdr agenda) nome telefone)))))

(defun excluir (agenda par)
  (excluir-aux agenda (car par) (car (cdr par))))

(defun Telefones (agenda nome)
  (cond ((null agenda) 'INEXISTENTE)
        ((eq (car (car agenda)) nome) (cdr (car agenda)))
        (t (Telefones (cdr agenda) nome))))