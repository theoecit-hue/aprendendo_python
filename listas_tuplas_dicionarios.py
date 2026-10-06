# listas, tuplas e dicionarios:

frutas = ['maçã', 'banana', 'laranja', 'maçã']
# frutas.append('melancia') # .append serve para adicionar itens a lista
# frutas.remove('banana')  # .remove serve para revomer itens

# frutas[2] = 'uva'
# frutas.insert(1, 'uva') # .insert usado para iserir itens a lista
# fruta_removida = frutas.pop() # .pop remove os itens com base no index 
# print(f"A fruta {fruta_removida} foi removida") 
# frutas.sort() # .sort ordena a lista em ordem alfabetica
# frutas.clear() .clear limpa a lista, fica vazia
# print(frutas.index('banana')) .index dentro do print serve para localizar o iten da lista, informando seu index
# print(frutas.count('maçã')) .count apresenta quantas vezes um valor aparece na lista

# frutas2 = frutas.copy() # está ligado à criação de uma nova instância de um objeto, sem apenas apontar para o mesmo espaço de memória.

# frutas2.append("Melancia")
# frutas2.append("Uva")

# print(frutas2)
# print(frutas)

cores = ('vermelho', 'verde', 'azul')
cores[1] = 'amarelo'  #deu erro o codigo pois a tupla é imutavel ou seja, não dá pra alterar o que estiver em tupla.