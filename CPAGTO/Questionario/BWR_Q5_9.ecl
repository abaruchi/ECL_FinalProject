IMPORT $;
IMPORT CPAGTO.Data_Consolidation as ds;

// Responde a questao 5.9
outLayout := RECORD
    ds.dsCPAGTO.CODIGO_UNID_GESTORA;
    ds.dsCPAGTO.NOME_UNIDADE_GESTORA;
    total := SUM(GROUP,ds.dsCPAGTO.VALOR_TRANSACAO);
    cnt := COUNT(GROUP);
END;

Tbl := TABLE(ds.dsCPAGTO, outLayout, CODIGO_UNID_GESTORA);
OUTPUT(CHOOSEN(SORT(Tbl,-total), 10));