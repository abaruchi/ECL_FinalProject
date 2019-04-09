IMPORT $;
IMPORT CPAGTO.Data_Consolidation as ds;

// Responde a questao 5.11
outLayout := RECORD
    ds.dsCPAGTO.DATA_TRANSACAO;
    // ds.dsCPAGTO.NOME_FAVORECIDO;
    total := SUM(GROUP,ds.dsCPAGTO.VALOR_TRANSACAO);
    cnt := COUNT(GROUP);
END;

Tbl := TABLE(ds.dsCPAGTO, outLayout, DATA_TRANSACAO);
OUTPUT(CHOOSEN(SORT(Tbl,-total), 10)(DATA_TRANSACAO <> ''));