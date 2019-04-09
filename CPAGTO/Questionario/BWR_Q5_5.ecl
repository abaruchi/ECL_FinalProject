IMPORT $;
IMPORT CPAGTO.Data_Consolidation as ds;

// Responde a questao 5.5
dsSorted := SORT(ds.dsCPAGTO, TRANSACAO);

outR := DEDUP(dsSorted, LEFT.TRANSACAO = RIGHT.TRANSACAO);
OUTPUT(COUNT(outR));
