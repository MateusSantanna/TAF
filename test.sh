#!/bin/bash

# Output Colors
RED="\033[31m"     # Define a cor vermelha para o output
GREEN="\033[32m"   # Define a cor verde para o output
YELLOW="\033[33m"  # Define a cor amarela para o output
BROWN="\033[33m"   # Define a cor marrom para o output
ENDCOLOR="\033[0m" # Define o fim da cor para o output


test_cases=$(cat test_cases.txt) # Lê o conteúdo do arquivo test_cases.txt e armazena na variável test_cases

passed_tests=() # Cria um array vazio para armazenar os testes que passaram
failed_tests=() # Cria um array vazio para armazenar os testes que falharam

x=1
while read -r test_case; do # Loop que percorre cada caso de teste do arquivo test_cases.txt
  gender=$(echo $test_case | awk '{print $1}')            # Extrai o valor do gênero do caso de teste
  height=$(echo $test_case | awk '{print $2}')            # Extrai o valor da altura do caso de teste
  barReps=$(echo $test_case | awk '{print $3}')           # Extrai o valor de repetições de barra do caso de teste
  barSeconds=$(echo $test_case | awk '{print $4}')        # Extrai o valor de tempo de barra do caso de teste
  abs=$(echo $test_case | awk '{print $5}')               # Extrai o valor de abdominais do caso de teste
  runDistance=$(echo $test_case | awk '{print $6}')       # Extrai o valor de distância de corrida do caso de teste
  runTime=$(echo $test_case | awk '{print $7}')           # Extrai o valor de tempo de corrida do caso de teste
  swimDistance=$(echo $test_case | awk '{print $8}')      # Extrai o valor de distância de natação do caso de teste
  swimTime=$(echo $test_case | awk '{print $9}')          # Extrai o valor de tempo de natação do caso de teste
  diveTime=$(echo $test_case | awk '{print $10}')         # Extrai o valor de tempo de mergulho do caso de teste
  expected_output=$(echo $test_case | awk '{print $11}')  # Extrai o valor do resultado esperado do caso de teste

  # Executa o código JavaScript (script.js) com os valores do caso de teste como argumentos e armazena o resultado na variável output
  output=$(node script.js $gender $height $barReps $barSeconds $abs $runDistance $runTime $swimDistance $swimTime $diveTime)


  # Cria uma variável chamada zp_index que recebe o número do teste x com zero a esquerda para formatar o output
  printf -v zp_index "%02d" $x

  # Separador visual de testes
  for i in {1..30}; do echo -n =; done

  echo -e "\n"
  # Compara o resultado obtido com o resultado experado
  if [ "$output" = "$expected_output" ]; then
    # Output verde caso o teste passe
    output_header="CORRETO"
    output_color="${GREEN}"
    # Armazena a numeração dos testes que passaram no array
    passed_tests+=($zp_index)
  else
    # Output red caso o teste falhe
    output_header="ERRADO"
    output_color="${RED}"
    # Armazena a numeração dos testes que falharam no array
    failed_tests+=($zp_index)
  fi

  # Escreve o cabeçalho com as informações do teste
  echo -e "Teste $zp_index - [${output_color} ${output_header} ${ENDCOLOR}]:

${YELLOW}Valores Testados:${ENDCOLOR}
gender: $gender
height: $height
barReps: $barReps
barSeconds: $barSeconds
abs: $abs
runDistance: $runDistance
runTime: $runTime
swimDistance: $swimDistance
swimTime: $swimTime
diveTime: $diveTime

${BROWN}Resultado Esperado: $expected_output ${ENDCOLOR}
${output_color}Resultado Obtido: $output ${ENDCOLOR}
"
  x=$(( $x + 1 ))
done <<< "$test_cases"

# Separador visual de testes
for i in {1..30}; do echo -n =; done


# Contagem de testes que passaram e que não passaram
echo -e "
${BROWN}Testes Finalizados${ENDCOLOR}
${GREEN}Testes Passados: ${#passed_tests[@]}${ENDCOLOR}
${RED}Testes Falhados: ${#failed_tests[@]}${ENDCOLOR}
"

# Verificação para saber se o array está vazio ou não
if ! [ ${#passed_tests[@]} -eq 0 ]; then
    echo -n -e "${BROWN}Testes que passaram:${ENDCOLOR} "
    echo -e -n "${GREEN}"
    echo -n "(${passed_tests[*]})"
    echo -e "${ENDCOLOR}"
fi

if ! [ ${#failed_tests[@]} -eq 0 ]; then
    echo -n -e "${BROWN}Testes que falharam:${ENDCOLOR} "
    echo -e -n "${RED}"
    echo "(${failed_tests[*]})"
    echo -e -n "${ENDCOLOR}"
else
    echo -e "${GREEN}Todos os testes passaram!!!!${ENDCOLOR}"
fi


