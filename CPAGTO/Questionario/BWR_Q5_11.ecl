IMPORT $;
IMPORT CPAGTO.Data_Consolidation as ds;

// Responde a questao 5.11
outLayout := RECORD
    ds.dsCPAGTO.CNPJ_CPF_FAVORECIDO;
    ds.dsCPAGTO.NOME_FAVORECIDO;
    total := SUM(GROUP,ds.dsCPAGTO.VALOR_TRANSACAO);
    cnt := COUNT(GROUP);
END;

Tbl := TABLE(ds.dsCPAGTO, outLayout, CNPJ_CPF_FAVORECIDO);
OUTPUT(CHOOSEN(SORT(Tbl,-total)(CNPJ_CPF_FAVORECIDO <> '-1' ), 10));