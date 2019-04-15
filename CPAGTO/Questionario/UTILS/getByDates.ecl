IMPORT $;
IMPORT CPAGTO.Data_Consolidation as dc;
ReplaceDateFormat(STRING val) := REGEXREPLACE('(\\d{1,2})/(\\d{1,2})/(\\d{4})', val, '$3$2$1');

DataIndx := dc.IDX_DATA_TRANS;

EXPORT getByDates (STRING D_INICIAL, STRING D_FINAL) := FUNCTION

    DataInicial := (UNSIGNED) ReplaceDateFormat(D_INICIAL);
    DataFinal := IF(
        D_FINAL <> '',
        (UNSIGNED) ReplaceDateFormat(D_FINAL),
        0
    );

    FindPeriod := IF (
        D_FINAL = '',
        DataIndx(DATA_TRANSACAO >=DataInicial),
        DataIndx(DATA_TRANSACAO >=DataInicial AND DATA_TRANSACAO < DataFinal)
    );

    RETURN FindPeriod;
END;