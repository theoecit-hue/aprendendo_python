# Exercícios de manipulação de string

#Exercício 1 – Primeira e Última Letra
#Peça ao usuário para digitar uma palavra. Mostre:

#A primeira letra

#A última letra

#Exercício 2 – Detectando palavras proibidas
#Peça ao usuário para escrever uma mensagem. Verifique se ela contém a palavra "bomba", e imprima um alerta se sim.

#Exercício 3 – Arrumando o texto
#Dada uma variável frase = "    @prendendo @ progr@m@r   "  com espaços nas pontas e letras bagunçadas, o programa deve:

#Remover espaços do início/fim

#Trocar todas as letras "@" por "a"

#Colocar a primeira letra de cada palavra em maiúsculo

# EXERCICIO1:

# frase = input("digite uma frase: ")
# print(frase[0])
# print(frase[-1])

# EXERCICIO 2: 
  
# frase = input("digite uma frase que não tenha a palavra bomba ")

# if 'bomba' in frase:
#      print("EU DISSE QUE NÃO PODIA BOMBA !")
# else:
#       print("acesso liberado!")


#EXERCICIO 3

# frase = "    @prendendo @ progr@m@r   "

# frase = frase.replace('@', 'a')
# frase = frase.strip()
# frase = frase.title()
# print(frase)