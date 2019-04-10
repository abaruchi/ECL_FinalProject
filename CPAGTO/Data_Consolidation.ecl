IMPORT $;

dsCCentralizadas := $.File_ComprasCentralizadas.dsComprasCentralizadas;
dsCPDC := $.File_CPDC.dsCPDC;
dsCPFG := $.File_CPGF.dsCPGF;

StripIt(STRING val) := REGEXREPLACE(',', val, '.');

EXPORT Data_Consolidation := MODULE
    EXPORT RecOutLayout := RECORD
        UNSIGNED CODIGO_ORGAO_SUPERIOR;
        STRING NOME_ORGAO_SUPERIOR;
        UNSIGNED CODIGO_ORGAO;
        STRING NOME_ORGAO;
        UNSIGNED CODIGO_UNID_GESTORA;
        STRING NOME_UNIDADE_GESTORA;
        UNSIGNED ANO_EXTRATO;
        UNSIGNED MES_EXTRATO;
        STRING18 CNPJ_CPF_FAVORECIDO;
        STRING NOME_FAVORECIDO;
        STRING TRANSACAO;
        STRING10 DATA_TRANSACAO;
        DECIMAL15_2 VALOR_TRANSACAO;

        STRING TIPO_AQUISICAO := '';

        STRING14 CPF_PORTADOR := '';
        STRING NOME_PORTADOR := '';

        UNSIGNED NUM_CONVENIO := 0; 
        UNSIGNED COD_CONVENENTE := 0;
        STRING NOME_CONVENENTE := '';
        STRING EXECUTOR_DESPESA := '';
    END; 

    Pro01 := PROJECT(dsCCentralizadas, TRANSFORM(RecOutLayout, 
                                        SELF.VALOR_TRANSACAO := (DECIMAL15_2) StripIt(LEFT.VALOR_TRANSACAO), 
                                        SELF:=LEFT));
    Pro02 := PROJECT(dsCPDC, TRANSFORM(RecOutLayout, 
                                        SELF.VALOR_TRANSACAO := (DECIMAL15_2) StripIt(LEFT.VALOR_TRANSACAO),
                                        SELF:=LEFT));
    Pro03 := PROJECT(dsCPFG, TRANSFORM(RecOutLayout,
                                        SELF.VALOR_TRANSACAO := (DECIMAL15_2) StripIt(LEFT.VALOR_TRANSACAO), 
                                        SELF:=LEFT));

    EXPORT dsCPAGTO := Pro01 + Pro02 + Pro03;

END;