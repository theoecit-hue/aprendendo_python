#EXERCICIOS DO CURSO/ PRIMEIRO EXERCICIO: Crie um código onde é solicitado para 
#o usuário inserir dois valores: o ano atual, e o ano de nascimento. O sistema 
#deve calcular quantos anos ele tem de acordo com essas informações e exibir no console.

ano1 = int(input("DIGITE O ANO ATUAL: "))

ano2 = int(input("DIGITE O ANO QUE VOCÊ NASCEU: "))

resultado = (ano1 - ano2)

print(f"você tem {resultado} anos de idade")



# exercicios 2: fazer o usuario inserir dois valores e fazer o sistema apresentar a 
#soma subtração multiplicação e divisão deles 

numero1 = int(input("digite o primeiro valor: "))
numero2 = int(input("digite o segundo valor: "))

resultado1 = (numero1 + numero2)
resultado2 = (numero1 - numero2)
resultado3 = (numero1 * numero2)
resultado4 = (numero1 / numero2)

print(f"O resultado da adição é :{resultado1} ")
print(f"O resultado da subtração é :{resultado2} ")
print(f"O resultado multiplicação é :{resultado3} ")
print(f"O resultado divisão é :{resultado4} ")

#TERCEIRO E ULTIMO EXERCICIO :\
# O usuario deve digitar 3 notas escolares e o sistema deve apresentar sua media

nota1 = float(input("digite a primeira nota"))
nota2 = float(input("digite a segunda nota"))
nota3 = float(input("digite a terceira nota"))

media = (nota1 + nota2 + nota3 ) / 3
print(f"Sua media é: {media}")