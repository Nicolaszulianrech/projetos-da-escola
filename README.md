__Assume-se para este tutorial que o usuário saiba programar em DELPHI e saiba jogar o jogo da velha__

Jogo da velha em DELPHI
========

```
* Main.c: Interface "gráfica" (BASH) do simulador
* Cache.h: Biblioteca de funções do simulador
* Cache.c: Funções matemáticas que implementam o simulador
```

Compilando o código fonte do simulador
-----------
```
gcc Cache.c Cache.h Main.c -o cache
```

Executando o simulador
-----------
```
./cache
```
Novas funcionalidades (Futuro):
-----------

- Computador se tornar mais inteligente
- Corrigir o BUG da diagonal secundária
