#Crie um menu com 3 opções:

#1. Pizza

#2. Sushi

#3. Salada

#O usuário digita um número. O programa mostra o prato escolhido. 
#Se digitar qualquer outro número, exiba: "Opção inválida."
#Peça para o usuário digitar um meio de transporte. Mostre uma mensagem conforme a entrada:

escolha = int(input("Cardapio, escolha um prato: 1: Pizza, 2: sushi ou 3: salada: "))

match escolha:
    case 1:
        print("Escolheu pizza")
    case 2:
        print("Escolheu sushi")
    case 3:
        print("Escolheu salada")
    case _:
        print("Prato invalido")
        

    

