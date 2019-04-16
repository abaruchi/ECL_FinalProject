IMPORT $;
IMPORT CPAGTO.Data_Consolidation as ds;
IMPORT CPAGTO.Questionario.UTILS as util;

EXPORT Q6 () := FUNCTION

    Parms := STORED(ds.iCPagtoSearch);
    dsPeriodLimited := util.getByDates(Parms.DATA_INICIAL, Parms.DATA_FINAL);

    dsValuesLimited := MAP(
        Parms.VALOR_MIN = 0 AND Parms.VALOR_MAX = 0
        => dsPeriodLimited,
        Parms.VALOR_MIN <> 0 AND Parms.VALOR_MAX = 0
        => dsPeriodLimited(VALOR_TRANSACAO >= Parms.VALOR_MIN),
        Parms.VALOR_MIN = 0 AND Parms.VALOR_MAX <> 0
        => dsPeriodLimited(VALOR_TRANSACAO < Parms.VALOR_MAX),
        Parms.VALOR_MIN <> 0 AND Parms.VALOR_MAX <> 0
        => dsPeriodLimited(VALOR_TRANSACAO >= Parms.VALOR_MIN AND 
                       VALOR_TRANSACAO < Parms.VALOR_MAX)
    );

    dsOrgSupFiltered := IF(Parms.CODIGO_ORG_SUPERIOR = 0,
                dsValuesLimited,
                dsValuesLimited(CODIGO_ORGAO_SUPERIOR = Parms.CODIGO_ORG_SUPERIOR));
    
    dsOrgFiltered := IF(Parms.CODIGO_ORG = 0,
                dsOrgSupFiltered,
                dsOrgSupFiltered(CODIGO_ORGAO = Parms.CODIGO_ORG));

    dsCPF_PortFiltered := IF(Parms.CPF_PORTADOR = '',
                dsOrgFiltered,
                dsOrgFiltered(CPF_PORTADOR = Parms.CPF_PORTADOR));
    
    dsCPF_FavFiltered := IF(Parms.CPF_FAVORECIDO = '',
                dsCPF_PortFiltered,
                dsCPF_PortFiltered(CNPJ_CPF_FAVORECIDO = Parms.CPF_FAVORECIDO));

    RETURN CHOOSEN(dsCPF_FavFiltered, IF(Parms.MAX_REGISTER_COUNT <> 0, Parms.MAX_REGISTER_COUNT, 100));

END;
