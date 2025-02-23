section .rodata

global indexhtml
indexhtml:
	db `index.html`, 0

global lendoarquivo
lendoarquivo:
	db `Lendo arquivo %s\n`, 0

global helloworld
helloworld:
        db  `HELLO WORLD`, 0

global linux
linux:
	db `LINUX É O MELHOR SO DE TODOS`, 0

global linebreak
linebreak:
        db `\n`, 0

global formathell
formathell:
	db `This is a number %d. This is a string %s\n`, 0

global minhas_frases
minhas_frases:
	dq helloworld
	dq linux

global modo_leitura
modo_leitura:
	db `r`, 0
