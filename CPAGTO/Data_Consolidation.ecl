IMPORT $;

dsCCentralizadas := $.File_ComprasCentralizadas.dsComprasCentralizadas;
dsCPDC := $.File_CPDC.dsCPDC;
dsCPFG := $.File_CPGF.dsCPGF;

StripIt(STRING val) := REGEXREPLACE(',', val, '.');
ReplaceDateFormat(STRING val) := REGEXREPLACE('(\\d{1,2})/(\\d{1,2})/(\\d{4})', val, '$3$2$1');

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
        UNSIGNED DATA_TRANSACAO;
        DECIMAL15_2 VALOR_TRANSACAO;

        STRING TIPO_AQUISICAO := '';

        STRING14 CPF_PORTADOR := '';
        STRING NOME_PORTADOR := '';

        UNSIGNED NUM_CONVENIO := 0; 
        UNSIGNED COD_CONVENENTE := 0;
        STRING NOME_CONVENENTE := '';
        STRING EXECUTOR_DESPESA := '';
    END; 

    // Cria Interface com os parametros de Busca
    EXPORT iCPagtoSearch := INTERFACE
        EXPORT STRING DATA_INICIAL := '';
        EXPORT STRING DATA_FINAL := '';
        EXPORT UNSIGNED CODIGO_ORG_SUPERIOR := 0;
        EXPORT UNSIGNED CODIGO_ORG := 0;
        EXPORT STRING CPF_PORTADOR := '';
        EXPORT STRING CPF_FAVORECIDO := '';
        EXPORT DECIMAL15_2 VALOR_MIN := 0;
        EXPORT DECIMAL15_2 VALOR_MAX := 0;
        EXPORT UNSIGNED MAX_REGISTER_COUNT := 0;
    END;   

    Pro01 := PROJECT(dsCCentralizadas, TRANSFORM(RecOutLayout, 
                                        SELF.VALOR_TRANSACAO := (DECIMAL15_2) StripIt(LEFT.VALOR_TRANSACAO),
                                        SELF.DATA_TRANSACAO := (UNSIGNED) ReplaceDateFormat(LEFT.DATA_TRANSACAO),
                                        SELF:=LEFT));
    Pro02 := PROJECT(dsCPDC, TRANSFORM(RecOutLayout, 
                                        SELF.VALOR_TRANSACAO := (DECIMAL15_2) StripIt(LEFT.VALOR_TRANSACAO),
                                        SELF.DATA_TRANSACAO := (UNSIGNED) ReplaceDateFormat(LEFT.DATA_TRANSACAO),
                                        SELF:=LEFT));
    Pro03 := PROJECT(dsCPFG, TRANSFORM(RecOutLayout,
                                        SELF.VALOR_TRANSACAO := (DECIMAL15_2) StripIt(LEFT.VALOR_TRANSACAO),
                                        SELF.DATA_TRANSACAO := (UNSIGNED) ReplaceDateFormat(LEFT.DATA_TRANSACAO), 
                                        SELF:=LEFT));

    EXPORT dsCPAGTO := Pro01 + Pro02 + Pro03;

    // Criacao do Indice
    EXPORT IDX_DATA_TRANS := INDEX(dsCPAGTO, {DATA_TRANSACAO}, {dsCPAGTO}, '~ONLINE::AB::KEY::DATA_TRANS');
    EXPORT BUILD_DATA_TRANS := BUILD(IDX_DATA_TRANS, OVERWRITE);
END;
