/*  CL Date Math demo.         Scott Klement, April 29, 2004  +
                                                              +
    To compile this, type:                                    +
       CRTBNDCL PGM(DATEDEMO) SRCFILE(xxx/xxx) DFTACTGRP(*NO) */
PGM

    DCL VAR(&LILIAN) TYPE(*CHAR) LEN(4)
    DCL VAR(&JUNK1)  TYPE(*CHAR) LEN(8)
    DCL VAR(&JUNK2)  TYPE(*CHAR) LEN(23)
    DCL VAR(&NICE)   TYPE(*CHAR) LEN(10)
    DCL VAR(&WEEKS)  TYPE(*DEC)  LEN(10 0)
    DCL VAR(&TEMP)   TYPE(*DEC)  LEN(10 0)
    DCL VAR(&DOW)    TYPE(*DEC)  LEN(1 0)
    DCL VAR(&FROM)   TYPE(*CHAR) LEN(4)
    DCL VAR(&TO)     TYPE(*CHAR) LEN(4)
    DCL VAR(&FROMDT) TYPE(*CHAR) LEN(10)
    DCL VAR(&TODT)   TYPE(*CHAR) LEN(10)
    DCL VAR(&DAYS)   TYPE(*DEC)  LEN(5 0)
    DCL VAR(&DateCvt) TYPE(*CHAR) LEN(10)
    DCL VAR(&QDATETIME  ) TYPE(*CHAR) LEN(20)
    DCL VAR(&CHARDY) TYPE(*CHAR) LEN(5)
    DCL VAR(&BDATE)  TYPE(*CHAR) LEN(31)
    DCL VAR(&ToVar)  TYPE(*CHAR) LEN(10)


    RTVSYSVAL  SYSVAL(QDATETIME) RTNVAR(&QDATETIME)
    CHGVAR     %SST( &DateCvt 1 2 )  %SST( &QDATETIME 5 2 )
    CHGVAR     %SST( &DateCvt 3 2 )  %SST( &QDATETIME 7 2 )
    CHGVAR     %SST( &DateCvt 5 2 )  %SST( &QDATETIME 3 2 )
    CVTDATE    DATE(&DATECVT) TOVAR(&TOVAR) FROMFMT(*MDY) +
                          TOFMT(*DMY)
    SNDUSRMSG MSG('The date' *BCAT &DateCvt *BCAT 'converted is' +
               *BCAT &Tovar) MSGTYPE(*INFO)

    CVTDATE    DATE(&DATECVT) TOVAR(&TOVAR) FROMFMT(*MDY) +
                          TOFMT(*JUL)
    SNDUSRMSG MSG('The date' *BCAT &DateCvt *BCAT 'converted is' +
               *BCAT &Tovar) MSGTYPE(*INFO)
    CVTDATE    DATE(&DATECVT) TOVAR(&TOVAR) FROMFMT(*MDY) +
                          TOFMT(*LONGJUL)
    SNDUSRMSG MSG('The date' *BCAT &DateCvt *BCAT 'converted is' +
               *BCAT &Tovar) MSGTYPE(*INFO)
    CHGVAR     &DATECVT      '11259999'
    CVTDATE    DATE(&DATECVT) TOVAR(&TOVAR) FROMFMT(*MDYY) +
                          TOFMT(*DMYY)
    SNDUSRMSG MSG('The date' *BCAT &DateCvt *BCAT 'converted is' +
               *BCAT &Tovar) MSGTYPE(*INFO)

    CHGVAR     &DATECVT      '9991125'
    CVTDATE    DATE(&DATECVT) TOVAR(&TOVAR) FROMFMT(*CYMD) +
                          TOFMT(*YYMD)
    SNDUSRMSG MSG('The date' *BCAT &DateCvt *BCAT 'converted is' +
               *BCAT &Tovar) MSGTYPE(*INFO)

    CHGVAR     &DATECVT      '27991125'
    CVTDATE    DATE(&DATECVT) TOVAR(&TOVAR) FROMFMT(*YYMD) +
                          TOFMT(*CYMD)
    SNDUSRMSG MSG('The date' *BCAT &DateCvt *BCAT 'converted is' +
               *BCAT &Tovar) MSGTYPE(*INFO)

ENDPGM
