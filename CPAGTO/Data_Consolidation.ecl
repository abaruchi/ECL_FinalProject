IMPORT $;

dsCCentralizadas := $.File_ComprasCentralizadas.dsComprasCentralizadas;
dsCPDC := $.File_CPDC.dsCPDC;
dsCPFG := $.File_CPGF.dsCPGF;

StripIt(STRING val) := REGEXREPLACE(',', val, '.');
ReplaceSlash(STRING val) := REGEXREPLACE('/', val, '');

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
    END;   

    Pro01 := PROJECT(dsCCentralizadas, TRANSFORM(RecOutLayout, 
                                        SELF.VALOR_TRANSACAO := (DECIMAL15_2) StripIt(LEFT.VALOR_TRANSACAO),
                                        SELF.DATA_TRANSACAO := (UNSIGNED) ReplaceSlash(LEFT.DATA_TRANSACAO),
                                        SELF:=LEFT));
    Pro02 := PROJECT(dsCPDC, TRANSFORM(RecOutLayout, 
                                        SELF.VALOR_TRANSACAO := (DECIMAL15_2) StripIt(LEFT.VALOR_TRANSACAO),
                                        SELF.DATA_TRANSACAO := (UNSIGNED) ReplaceSlash(LEFT.DATA_TRANSACAO),
                                        SELF:=LEFT));
    Pro03 := PROJECT(dsCPFG, TRANSFORM(RecOutLayout,
                                        SELF.VALOR_TRANSACAO := (DECIMAL15_2) StripIt(LEFT.VALOR_TRANSACAO),
                                        SELF.DATA_TRANSACAO := (UNSIGNED) ReplaceSlash(LEFT.DATA_TRANSACAO), 
                                        SELF:=LEFT));

    EXPORT dsCPAGTO := Pro01 + Pro02 + Pro03;

    // Criacao dos Indices
    EXPORT IDX_COD_ORGS := INDEX(dsCPAGTO, {CODIGO_ORGAO_SUPERIOR, CODIGO_ORGAO},{dsCPAGTO}, '~ONLINE::AB::KEY::COD_ORGS');
    EXPORT IDX_CPF_POR := INDEX(dsCPAGTO, {CPF_PORTADOR},{dsCPAGTO}, '~ONLINE::AB::KEY::CPF_POR');
    EXPORT IDX_CPF_FAV := INDEX(dsCPAGTO, {CNPJ_CPF_FAVORECIDO},{dsCPAGTO}, '~ONLINE::AB::KEY::CPF_FAV');
    EXPORT IDX_DATA_TRANS := INDEX(dsCPAGTO, {DATA_TRANSACAO}, {dsCPAGTO}, '~ONLINE::AB::KEY::DATA_TRANS');

    EXPORT BUILD_COD_ORGS := BUILD(IDX_COD_ORGS, OVERWRITE);
    EXPORT BUILD_CPF_POR := BUILD(IDX_CPF_POR, OVERWRITE);
    EXPORT BUILD_CPF_FAV := BUILD(IDX_CPF_FAV, OVERWRITE);
    EXPORT BUILD_DATA_TRANS := BUILD(IDX_DATA_TRANS, OVERWRITE);

    EXPORT BUILD_ALL := PARALLEL(BUILD_COD_ORGS,BUILD_CPF_POR,BUILD_CPF_FAV,BUILD_DATA_TRANS);
END;
