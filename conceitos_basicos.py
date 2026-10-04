print("hello world")
#stirng (str: dado de texto)
print(type("hello world"))
# type: (mostra o tipo do codigo)

#TIPOS DE DADOS :

#str : string = textos
#tudo que estiver entre aspas é tipo str = tipo textual
print("hello world")

#int : inteiro = numeros
#( sem casa decimal)
print(20+20+20+7)

#float: numero com casa decimal 
#( ex: 16.5)
print(25.5+25.5)

#CONCEITOS DE MATEMATICA

#ordem           operador

# 1               **

# 2               +X, -X

# 3               *,/.//.%

# 4               +, -

# POREM: tudo que estiver entre parenteses () ele vai priorizar

#exemmplo :

print(5+2*7/2)
# aqui daria 12, pois ele prioriza a ordem operacional

print((5+2)*7/2)
# já aqui deu 24.5 pois  ele priorizou o que estava dentro do parenteses

# Variaveis :
# espaços  temporarios de armazenamento usados durante a execução de um programa.
# elas guardao valores enquanto o codigo está rodando. ( a menos que sejam salvas
# em algum lugar).

nome = "theo"
# a variavel " nome " está guardando ou recebendo "=" o valor = "theo"
print (nome)
# quando eu quiser rodar meu nome posso simplesmente usar a variavel "nome" 
# em vez de escrever "theo".  Ela basicamente armazena valores 

# A variavel nunca pode comecar com numeros, no maximo anderlaine (_) ou letras.
# O python é sensivel a maiusculas e minusculas ou "case sensitive".
#EXEMPLO

# Nome2 = "Daniel"
# print(nome)

#se eu executar assim vai dar erro, pois na variavel eu iniciei com maiusculo
# e na hora de puxar o codigo eu iniciei com minusculo. O python nao vai
# reconhecer por conta do case sensitive.
# AGORA DO JEITO CORRETO :

Nome2 = "Daniel"
print(Nome2)
# puxei a variavel como ela está escrita.

# CURIOSIDADE : da pra realizar operacoes usando variaveis.
# EXEMPLO:

numero1 = 40
numero2 = 27

print (numero1 + numero2)

# OU :

numero1 = 40
numero2 = 27
resultado = numero1 + numero2

print (resultado)