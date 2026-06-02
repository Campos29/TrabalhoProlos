# Como testar o `projetoLisp.lisp` com SBCL no PowerShell

Guia passo a passo para rodar e testar as funções `incluir` e `excluir` da agenda
usando o **SBCL (Steel Bank Common Lisp)** no **PowerShell** (Windows).

---

## 1. Verificar se o SBCL está instalado

No PowerShell, rode:

```powershell
sbcl --version
```

- Se aparecer algo como `SBCL 2.x.x`, está tudo certo.
- Se der erro de "comando não reconhecido", o SBCL não está no `PATH`. Nesse caso,
  use o caminho completo do executável, por exemplo:

```powershell
& "C:\Program Files\Steel Bank Common Lisp\sbcl.exe" --version
```

> Dica: nos exemplos abaixo, sempre que aparecer `sbcl`, você pode trocar por
> `& "C:\Program Files\Steel Bank Common Lisp\sbcl.exe"` caso o atalho não funcione.

---

## 2. Ir até a pasta do projeto

```powershell
cd "C:\Users\gabmc\OneDrive\Documentos\git-repos\TrabalhoProlos\LISP"
```

Confira que o arquivo está lá:

```powershell
ls projetoLisp.lisp
```

---

## 3. Forma A — Testar no modo interativo (REPL)

Essa é a forma mais parecida com o exemplo do documento.

### 3.1. Abrir o SBCL

```powershell
sbcl
```

Você verá o prompt do Lisp (`*`).

### 3.2. Carregar o seu código

```lisp
(load "projetoLisp.lisp")
```

### 3.3. Digitar os comandos de teste, um a um

> Comece com `defparameter` (em vez de `setq AGENDA nil`) para evitar o aviso
> *"undefined variable: AGENDA"*. Os `setq` seguintes funcionam sem avisos.

```lisp
(defparameter AGENDA nil)
(setq AGENDA (incluir AGENDA '(Bel 32338778)))
(setq AGENDA (incluir AGENDA '(Rose 32666556)))
(setq AGENDA (incluir AGENDA '(Rose 991919191)))
(setq AGENDA (incluir AGENDA '(Beto 32529119)))
AGENDA
```

Saída esperada:

```lisp
((BEL 32338778) (ROSE 32666556 991919191) (BETO 32529119))
```

Agora testando a exclusão:

```lisp
(setq AGENDA (excluir AGENDA '(Rose 991919191)))
AGENDA
```

Saída esperada (Rose perde um telefone):

```lisp
((BEL 32338778) (ROSE 32666556) (BETO 32529119))
```

```lisp
(setq AGENDA (excluir AGENDA '(Rose 91919191)))   ; telefone inexistente
AGENDA
```

Saída esperada (nada muda):

```lisp
((BEL 32338778) (ROSE 32666556) (BETO 32529119))
```

```lisp
(setq AGENDA (excluir AGENDA '(Rose 32666556)))   ; era o ultimo telefone
AGENDA
```

Saída esperada (Rose é removida por completo):

```lisp
((BEL 32338778) (BETO 32529119))
```

### 3.4. Sair do SBCL

```lisp
(quit)
```

---

## 4. Forma B — Rodar um script de teste automático

Se preferir rodar tudo de uma vez (sem digitar comando por comando):

### 4.1. Criar um arquivo de teste

Crie um arquivo chamado `teste.lisp` na mesma pasta, com este conteúdo:

```lisp
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
```

> Usar `defvar AGENDA nil` em vez de `setq AGENDA nil` evita os avisos
> (*warnings*) de "undefined variable" do SBCL.

### 4.2. Executar o script

```powershell
sbcl --script teste.lisp
```

Saída esperada:

```
Apos inclusoes: ((BEL 32338778) (ROSE 32666556 991919191) (BETO 32529119))
Apos excluir Rose 991919191: ((BEL 32338778) (ROSE 32666556) (BETO 32529119))
Apos excluir telefone inexistente: ((BEL 32338778) (ROSE 32666556) (BETO 32529119))
Apos excluir ultimo telefone da Rose: ((BEL 32338778) (BETO 32529119))
```

---

## 5. Observações

- **Maiúsculas:** o Common Lisp converte os símbolos para maiúsculas
  automaticamente, por isso `Bel` aparece como `BEL` na saída. Isso é normal.
- **Warnings de `undefined variable: AGENDA`:** aparecem quando você usa `setq` em
  uma variável que nunca foi declarada (tanto no REPL quanto no `--script`). São
  apenas avisos, **não são erros** — o resultado sai correto mesmo assim. Para
  evitá-los, declare a variável antes: use `(defparameter AGENDA nil)` no REPL
  (Forma A) ou `(defvar AGENDA nil)` no script (Forma B).
- **Funções implementadas:** apenas `incluir` (função 1) e `excluir` (função 2). A
  busca de telefones (função 3) não faz parte deste arquivo.
