# Manipulção de strings: 

# fruta = "Melancia"   #dentro do colchetes ele começa a contar apartir do 0, ou seja [0: 3] = Mel (ele subtrai 1 sozinho)
# print(fruta[2:])

frase = "eu amo python!"

# frase_tamanho = len(frase)      # o "len" descreve em caracteres o tamanho da (str) contida na variavel.
# print(f"A frase {frase} tem {frase_tamanho} caracteres!")

# contagem = frase.count('o')     # o (.count) conta a quantidade de letras que tem no srt conforme a letra preenchida entre parenteses ()
# print(contagem)


# print(frase.find('m'))  # o (.find) conta a posição do index da letra que esta entre os parenteses

# if 'python' in frase:
#     print("Python está na frase!")
# else:
#     print("Python não está na frase!")

# print(frase.lower()) # tranforma toda frase em minusculo

# # print(frase.upper()) transforma tudo em maiusculo

frase = frase.upper() # deixa a str da variavel em maisculo para sempre ( isso serve aoo contrario tambem )
print(frase)

# print(frase.capitalize()) # transforma a primeira letra em maiusculo

# print(frase.strip()) # romove os espaços das laterais 

# print(frase.replace('o', 'x')) # substitui caracteres, no caso do exemplo a letra "o" foi substituida por "x"

# print(frase.title()) # poem a primeira letra de cada palavra em maiusculo 