IMPORT $;
IMPORT CPAGTO.Data_Consolidation as ds;

// Responde a questao 5.10
outLayout := RECORD
    ds.dsCPAGTO.CPF_PORTADOR;
    ds.dsCPAGTO.NOME_PORTADOR;
    total := SUM(GROUP,ds.dsCPAGTO.VALOR_TRANSACAO);
    cnt := COUNT(GROUP);
END;

Tbl := TABLE(ds.dsCPAGTO, outLayout, CPF_PORTADOR);
OUTPUT(CHOOSEN(SORT(Tbl,-total)(cpf_portador <> ''), 10));