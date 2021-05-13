# Implementação em Python do programa weasel de Richard Dawkin
# Ilustra o poder da seleção cumulativa em comparação com a pesquisa inteiramente aleatória

# Inicializando
import random
target = list("METHINKS IT IS LIKE A WEASEL")   # Sequência alvo
alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "        # Alfabeto de símbolos possíveis (letras maiúsculas + espaço em branco)
n_offspring = 50                                # Número de descendentes por geração
mut_rate = 0.09                                 # Taxa de mutação: probabilidade de que qualquer letra mude
best_offspring = []                             # Variável contendo a melhor prole após cada geração


# Gerando a string inicial
parent = []
for i in range(len(target)):
    parent.append(random.choice(alphabet))

# Main loop: construir descendentes mutantes, selecionar o melhor para a próxima geração, parar quando o alvo for atingido
gen = 0
while best_offspring != target:
    gen = gen + 1

    # Gerar n_offspring proles que podem conter mutacoes
    kid_list = []
    for i in range(n_offspring):

        # Copiar conteúdo de pai para filho
        kid = parent[:]

        # Repita as posições na prole, pois cada posição permite a possibilidade de mutação
        kid_changed = False
        for pos in range(len(kid)):

            # Deixe o resíduo sofrer mutação com probabilidade mut_rate
            if random.random() < mut_rate:
                kid_changed = True

                # Selecione aleatoriamente um novo símbolo (que é diferente do que já está presente)
                old_symbol = parent[pos]
                possible_new_symbols = set(alphabet) - set(old_symbol)
                new_symbol = random.choice(list(possible_new_symbols))

                # Mutacao prole
                kid[pos] = new_symbol

                
        # Adicionar (possivelmente) prole com mutação à lista de proles atuais
        kid_list.append(kid)


    # Encontre a prole mais adequada (= string mais semelhante ao alvo)
    smallest_dif = len(target) + 1
    for kid in kid_list:

        # Encontre o número de posições que diferem entre a prole e o alvo

        dif = 0.0
        for pos in range(len(target)):
            if kid[pos] != target[pos]:
                dif = dif + 1

        # Mantenha a melhor prole encontrada até agora
        if dif < smallest_dif:
            smallest_dif = dif
            best_offspring = kid

    # considere a melhor prole como ponto de partida para a próxima rodada de mutação

    parent = best_offspring

    # Impressão do progresso
    fitness = (len(target)-smallest_dif)/len(target)            # Aptidão do indivíduo mais parecido com o alvo
    result_string = ""
    for pos in range(len(target)):
        if best_offspring[pos] == target[pos]:
            result_string += best_offspring[pos]
        else:
            result_string += best_offspring[pos].lower()
    print ("%s     ** Gen: %4d   Diferentes: %3d   Aptidao: %.4f  " % (result_string,gen, smallest_dif, fitness))

