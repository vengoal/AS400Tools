 RTNDTAQD:   PGM        PARM(&PQDTAQ &PMAXLEN &PFORCE &PSEQ &PKEYLEN +
                          &PSENDERID &PTEXT &PNBRMSG &PMAXMSG)

             DCL        VAR(&PQDTAQ) TYPE(*CHAR) LEN(20)
             DCL        VAR(&PMAXLEN) TYPE(*DEC) LEN(5)
             DCL        VAR(&PFORCE) TYPE(*CHAR) LEN(4)
             DCL        VAR(&PSEQ) TYPE(*CHAR) LEN(6)
             DCL        VAR(&PKEYLEN) TYPE(*DEC) LEN(3)
             DCL        VAR(&PSENDERID) TYPE(*CHAR) LEN(4)
             DCL        VAR(&PTEXT) TYPE(*CHAR) LEN(50)
             DCL        VAR(&PNBRMSG) TYPE(*DEC) LEN(9)
             DCL        VAR(&PMAXMSG) TYPE(*DEC) LEN(9)


             DCL        VAR(&DTAQ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&DTAQLIB) TYPE(*CHAR) LEN(10)

             DCL        VAR(&FORCE) TYPE(*CHAR) LEN(1)
             DCL        VAR(&SEQ) TYPE(*CHAR) LEN(1)
             DCL        VAR(&SENDERID) TYPE(*CHAR) LEN(1)

             DCL        VAR(&DTAQD) TYPE(*CHAR) LEN(80) /* Max len +
                          returned s/b 69... */


             MONMSG     MSGID(MCH3601) /* Ignore unpassed +
                          parameters... */

             MONMSG     MSGID(CPF0000 MCH0000) EXEC(GOTO +
                          CMDLBL(STDERR))


             CHGVAR     VAR(&DTAQ) VALUE(%SST(&PQDTAQ 1 10))
             CHGVAR     VAR(&DTAQLIB) VALUE(%SST(&PQDTAQ 11 10))

             RTVDTAQD   DTAQ(&DTAQLIB/&DTAQ) DTAQD(&DTAQD)

             CHGVAR     VAR(&PMAXLEN) VALUE(%BIN(&DTAQD 9 4))
             CHGVAR     VAR(&PKEYLEN) VALUE(%BIN(&DTAQD 13 4))

             CHGVAR     VAR(&SEQ) VALUE(%SST(&DTAQD 17 1))
             IF         COND(&SEQ *EQ 'F') THEN(CHGVAR VAR(&PSEQ) +
                          VALUE('*FIFO'))
             ELSE       CMD(IF COND(&SEQ *EQ 'K') THEN(CHGVAR +
                          VAR(&PSEQ) VALUE('*KEYED')))
             ELSE       CMD(IF COND(&SEQ *EQ 'L') THEN(CHGVAR +
                          VAR(&PSEQ) VALUE('*LIFO')))
             ELSE       CMD(CHGVAR VAR(&PSEQ) VALUE('*N'))

             CHGVAR     VAR(&SENDERID) VALUE(%SST(&DTAQD 18 1))
             IF         COND(&SENDERID *EQ 'Y') THEN(CHGVAR +
                          VAR(&PSENDERID) VALUE('*YES'))
             ELSE       CMD(IF COND(&SENDERID *EQ 'N') THEN(CHGVAR +
                          VAR(&PSENDERID) VALUE('*NO')))
             ELSE       CMD(CHGVAR VAR(&PSENDERID) VALUE('*N'))

             CHGVAR     VAR(&FORCE) VALUE(%SST(&DTAQD 19 1))
             IF         COND(&FORCE *EQ 'Y') THEN(CHGVAR +
                          VAR(&PFORCE) VALUE('*YES'))
             ELSE       CMD(IF COND(&FORCE *EQ 'N') THEN(CHGVAR +
                          VAR(&PFORCE) VALUE('*NO')))
             ELSE       CMD(CHGVAR VAR(&PFORCE) VALUE('*N'))

             CHGVAR     VAR(&PTEXT) VALUE(%SST(&DTAQD 20 50))
             CHGVAR     VAR(&PNBRMSG) VALUE(%BIN(&DTAQD 73 4))
             CHGVAR     VAR(&PMAXMSG) VALUE(%BIN(&DTAQD 77 4))

             RMVMSG     CLEAR(*ALL)

             RETURN

 STDERR:     MOVDIAGMSG
             RSNESCMSG

             RETURN


             ENDPGM

