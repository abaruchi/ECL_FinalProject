IMPORT $;

// List of files to process
File_2018_11 := '~online::ab::cpagto::201811_cpgfcomprascentralizadas';
File_2018_12 := '~online::ab::cpagto::201812_cpgfcomprascentralizadas';
 
EXPORT File_ComprasCentralizadas := MODULE

    EXPORT Layout_ComprasCentralizadas := RECORD
        UNSIGNED CODIGO_ORGAO_SUPERIOR;
        STRING NOME_ORGAO_SUPERIOR;
        UNSIGNED CODIGO_ORGAO;
        STRING NOME_ORGAO;
        UNSIGNED CODIGO_UNID_GESTORA;
        STRING NOME_UNIDADE_GESTORA;
        UNSIGNED ANO_EXTRATO;
        UNSIGNED MES_EXTRATO;
        STRING TIPO_AQUISICAO;
        STRING18 CNPJ_CPF_FAVORECIDO;
        STRING NOME_FAVORECIDO;
        STRING TRANSACAO;
        STRING10 DATA_TRANSACAO;
        STRING VALOR_TRANSACAO;
    END;

    ds1 := DATASET(File_2018_11, Layout_ComprasCentralizadas, CSV);
    ds2 := DATASET(File_2018_12, Layout_ComprasCentralizadas, CSV);

    EXPORT dsComprasCentralizadas := MERGE(ds1, ds2, SORTED(CNPJ_CPF_FAVORECIDO));

END;
