#Match_case: Match (trabalha em cima da variavel) / case ( caso, trabalha com opções)

opcao = int(input("escolha um numero de 1 a 3: "))
match opcao:
    case 1:
        print("você escolheu o numero 1")
    case 2:
            print("você escolheu o numero 2")
    case 3:
            print("você escolheu o numero 3") 
    case _:
            print ("Opção invalida")                   