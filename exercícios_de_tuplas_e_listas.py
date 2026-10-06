#Exercicios de tuplas e listas:
#🧪 Exercício 1 – Acesso por índice
#Crie uma lista com 3 animais e mostre o primeiro e o último elemento.

lista = ['cachorro', 'gato', 'papagaio']
print(lista[0])
print(lista[2])

# A lista começa e fecha com colchetes e cada iten deve abrir e fechar com aspas unicas.

#🧪 Exercício 2 – Manipulando uma lista
#Dada a lista abaixo:

#livros = ["Python", "Java", "C++"]
#Realize as seguintes ações:

#Adicione o livro "JavaScript"

#Remova o livro "Java"

#Troque "Python" por "Go"

#Mostre o tamanho da lista

# livros = ["Python", "java", "C++"]
# livros.insert(3, 'javascript')
# livros.remove('java')
# livros[0] = ('go')
# print (livros)

#Exercício 3: 
#🧪 Exercício 3 – Trabalhando com contagem e localização
##Dada a lista abaixo:

#nomes = [ "Ana", "Bruno", "Carla", "Daniel", "Eduarda", "Fernando", "Giovana", "Hugo", "Isabela", "João", "Carla", "Lucas", "Mariana", "Nuno", "Olivia", "João", "Pedro", "Carla", "Rafael", "Ana" ]

#Mostre:

#Quantas vezes o nome Carla aparece

#Qual o índice da primeira vez que ele aparece

nomes = [ "Ana", "Bruno", "Carla", "Daniel", "Eduarda", "Fernando", "Giovana", "Hugo", "Isabela", "João", "Carla", "Lucas", "Mariana", "Nuno", "Olivia", "João", "Pedro", "Carla", "Rafael", "Ana" ]

contagem = nomes.count('Carla')
index = nomes.index('Carla')

print(f"o nome Carla apareceu {contagem} vezes, e a primeira vez foi no index {index}")

