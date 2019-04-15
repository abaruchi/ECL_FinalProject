IMPORT $;
IMPORT CPAGTO.Data_Consolidation as dc;
ReplaceDateFormat(STRING val) := REGEXREPLACE('(\\d{1,2})/(\\d{1,2})/(\\d{4})', val, '$3$2$1');

DataIndx := dc.IDX_DATA_TRANS;

EXPORT getByDates (STRING D_INICIAL, STRING D_FINAL) := FUNCTION

    DataInicial := IF(
        D_INICIAL <> '',
        (UNSIGNED) ReplaceDateFormat(D_INICIAL),
        0
    );
    
    DataFinal := IF(
        D_FINAL <> '',
        (UNSIGNED) ReplaceDateFormat(D_FINAL),
        0
    );

    FindPeriod := MAP (
        DataInicial = 0 AND DataFinal = 0
        => DataIndx,
        DataInicial <> 0 AND DataFinal = 0
        => DataIndx(DATA_TRANSACAO >= DataInicial),
        DataInicial = 0 AND DataFinal <> 0
        => DataIndx(DATA_TRANSACAO <= DataFinal),
        DataInicial <> 0 AND DataFinal <> 0
        => DataIndx(DATA_TRANSACAO >= DataInicial AND DATA_TRANSACAO <= DataFinal)
    );
    RETURN FindPeriod;
END;