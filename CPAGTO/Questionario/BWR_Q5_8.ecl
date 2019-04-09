IMPORT $;
IMPORT CPAGTO.Data_Consolidation as ds;

// Responde a questao 5.8
outLayout := RECORD
    ds.dsCPAGTO.CODIGO_ORGAO_SUPERIOR;
    ds.dsCPAGTO.NOME_ORGAO_SUPERIOR;
    total := SUM(GROUP,ds.dsCPAGTO.VALOR_TRANSACAO);
    cnt := COUNT(GROUP);
END;

Tbl := TABLE(ds.dsCPAGTO, outLayout, CODIGO_ORGAO_SUPERIOR);
OUTPUT(CHOOSEN(SORT(Tbl,-total), 10));
