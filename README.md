# Exercício Final de ECL

## Descrição

1. Acesse "http://www.portaltransparencia.gov.br/download-de-dados" e abra a aba de arquivos referentes ao tipo "Cartão de Pagamento".

O site dispõe de 3 tipos desse arquivo: CPGF, Compras centralizadas e CPDC.
Cada tipo recebe um arquivo novo todo mês.
O formato dos arquivos é csv, com a primeira linha de header.

2. Faça o download dos três tipos de arquivo, referentes a dois meses para cada tipo (ou seja, faça o download de dois arquivos de cada tipo).

3. Faça o upload dos arquivos no HPCC, seguido pelo spray deles no cluster.

4. Escreta em ECL um módulo com a definição de layout e dataset dos arquivos.

Nota: eles tem o mesmo layout, porém o arquivo de Cartão de Pagamentos da Defesa Civil possui alguns campos a mais. Utilize a função IFBLOCK da estrutura RECORD para definir campos a mais dada a condição do arquivo possuir estes campos.

5. Responda as seguintes perguntas:
    5.1 Qual a quantidade de pagamentos nos registros analizados?

    5.2 Qual o valor total gasto reportado?
    
    5.3 Qual a média de valor gasto por pagamento?
    
    5.4 Quais os pagamentos com maiores valores?
    
    5.5 Quais os tipos de transação registrados?
    
    5.6 Existe algum registro com campos mal preenchidos?
    
    5.7 Qual o orgao que mais gasta?
    
    5.8 Qual o orgao superior que mais gasta?
    
    5.9 Qual a unidade gestora que mais gasta?
    
    5.10 Qual a pessoa portadora do cartão que mais gasta?
    
    5.11 Qual a pessoa mais favorecida em termos de valor total?
    
    5.12 Quais dias do mês mais gastou-se?
                
Nota: visualize os resultados através da ferramenta de visualização de outputs do ECL  Watch.

6. Desenvolva uma query que realize buscas na base de dados:

    6.1 A busca deve conter os seguintes parâmetros de entrada:

    6.1.1 Data Inicial

    6.1.2 Data Final

    6.1.3 Codigo do Órgão Superior
    
    6.1.4 Código do Órgão
    
    6.1.5 Cpf Portador
    
    6.1.6 Cpf Favorecido
    
    6.1.6 Valor Mínimo
    
    6.1.7 Valor Máximo
    
    6.1.8 Página

    6.2 Os parâmetros de busca devem ter um formato de fácil leitura para pessoas. Exemplo: Datas devem ter o formato '20/01/2019'.
    
    6.3 Cada parâmetro de entrada deve filtrar os dados caso não venha com valor vazio para strings e zero para números. Caso o valor venha vazio, o filtro não deve ser aplicado.
    
    6.4 O serviço deve filtrar a base de dados e enviar como resposta os registros encontrados.
    
    6.5 A busca deve ser feita em um arquivo indexado.

    6.5.1 O tipo das chaves do índice devem ser otimizadas para a buscas rápidas (UNSIGNED de preferência à STRING).

    6.6 O serviço deve ser paginado.

    6.6.1 O número máximo de registros de pagamentos em cada resposta do serviço é 100.

    6.6.2 A resposta deve indicar o número total de páginas para as condições de filtragem (Número de registros encontrado dividido pelo número de registros máximo por chamada).
    
    6.6.3 A resposta também deve indicar qual a paginação usava para a chamada.
