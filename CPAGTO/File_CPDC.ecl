IMPORT $;

// List of files to process
File_2018_10 := 'online::ab::cpagto::201810_cpdc';
File_2018_11 := 'online::ab::cpagto::201811_cpdc';

EXPORT File_CPDC := MODULE

    EXPORT Layout_CPDC := RECORD
        UNSIGNED CODIGO_ORGAO_SUPERIOR;
        STRING NOME_ORGAO_SUPERIOR;
        UNSIGNED CODIGO_ORGAO;
        STRING NOME_ORGAO;
        UNSIGNED CODIGO_UNID_GESTORA;
        STRING NOME_UNIDADE_GESTORA;
        UNSIGNED ANO_EXTRATO;
        UNSIGNED MES_EXTRATO;
        STRING14 CPF_PORTADOR;
        STRING NOME_PORTADOR;
        STRING18 CNPJ_CPF_FAVORECIDO;
        STRING NOME_FAVORECIDO;
        STRING EXECUTOR_DESPESA;
        UNSIGNED NUM_CONVENIO; 
        UNSIGNED COD_CONVENENTE;
        STRING NOME_CONVENENTE;
        STRING3 REPASSE;
        STRING TRANSACAO;
        STRING10 DATA_TRANSACAO;
        STRING VALOR_TRANSACAO;
    END;

    ds1 := DATASET(File_2018_10, Layout_CPDC, CSV);
    ds2 := DATASET(File_2018_11, Layout_CPDC, CSV);

    EXPORT dsCPDC := MERGE(ds1, ds2, SORTED(CPF_PORTADOR,CNPJ_CPF_FAVORECIDO));
END;
