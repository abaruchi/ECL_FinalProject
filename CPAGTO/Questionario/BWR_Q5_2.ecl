IMPORT $;
IMPORT CPAGTO.Data_Consolidation as ds;

// Responde a questao 5.2
OUTPUT(SUM(ds.dsCPAGTO,VALOR_TRANSACAO));