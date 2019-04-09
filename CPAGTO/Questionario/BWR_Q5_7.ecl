IMPORT $;
IMPORT CPAGTO.Data_Consolidation as ds;

// Responde a questao 5.7
outLayout := RECORD
    ds.dsCPAGTO.CODIGO_ORGAO;
    ds.dsCPAGTO.NOME_ORGAO;
    total := SUM(GROUP,ds.dsCPAGTO.VALOR_TRANSACAO);
    cnt := COUNT(GROUP);
END;

Tbl := TABLE(ds.dsCPAGTO, outLayout, CODIGO_ORGAO);
OUTPUT(CHOOSEN(SORT(Tbl,-total), 10));
