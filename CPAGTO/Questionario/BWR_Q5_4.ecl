IMPORT $;
IMPORT CPAGTO.Data_Consolidation as ds;

// Responde a questao 5.4
OUTPUT(MAX(ds.dsCPAGTO,VALOR_TRANSACAO));

// Apresenta Top 10
OUTPUT(CHOOSEN(SORT(ds.dsCPAGTO,-VALOR_TRANSACAO),10));
