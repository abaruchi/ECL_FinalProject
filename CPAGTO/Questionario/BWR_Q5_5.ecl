IMPORT $;
IMPORT CPAGTO.Data_Consolidation as ds;

// Responde a questao 5.11
outLayout := RECORD
    ds.dsCPAGTO.TRANSACAO;
    total := SUM(GROUP,ds.dsCPAGTO.VALOR_TRANSACAO);
    cnt := COUNT(GROUP);
END;

Tbl := TABLE(ds.dsCPAGTO, outLayout, TRANSACAO);
OUTPUT(SORT(Tbl,-total));