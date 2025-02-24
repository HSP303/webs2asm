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

global socket_deu_ruim
socket_deu_ruim:
	db `Deu uim pra abrir o socket. Malz ae:(`, 0

global socket_deu_bom
socket_deu_bom:
	db `Ae meu chapa, deu bom com o socket. Tae: %d\n`, 0

global sockopt_deu_bom
sockopt_deu_bom:
	db `Ae, server sockou bem.\n`, 0

global sockopt_deu_ruim
sockopt_deu_ruim:
	db `Ae meu chapa, server sockou errado.\n`, 0

global teste
teste:
	db `Porta invertida: %p\n`, 0

global bindar_deu_bom
bindar_deu_bom:
	db `BINDEI\n`, 0	

global bindar_deu_ruim
bindar_deu_ruim:
	db `Num deu pra binda nao :(\n`, 0

global escutar_deu_bom
escutar_deu_bom:
	db `Ae, to te ouvindo.\n`, 0

global escutar_deu_ruim
escutar_deu_ruim:
	db `Ow, fala direito, não estou te ouvindo.\n`, 0

global conexao_deu_bom
conexao_deu_bom:
	db `AE, ALGUEM TA AQUI.\n`, 0

global conexao_deu_ruim
conexao_deu_ruim:
	db `VISH\n`, 0
