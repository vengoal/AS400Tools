RTVEXITKEY:  PGM        PARM(&F3 &F12)

             DCL        VAR(&JOB) TYPE(*CHAR) LEN(26) VALUE('*')
             DCL        VAR(&INTJOBID) TYPE(*CHAR) LEN(16) VALUE(' ')
             DCL        VAR(&JOBINFO) TYPE(*CHAR) LEN(350)
             DCL        VAR(&F3LOC) TYPE(*DEC) LEN(5 0) VALUE(103)
             DCL        VAR(&F12LOC) TYPE(*DEC) LEN(5 0) VALUE(104)
             DCL        VAR(&F12) TYPE(*CHAR) LEN(1)
             DCL        VAR(&F3) TYPE(*CHAR) LEN(1)
             DCL        VAR(&RTNLEN) TYPE(*CHAR) LEN(4) +
                          VALUE(X'00000000')

             CHGVAR     VAR(%BIN(&RTNLEN)) VALUE(350)

             CALL       PGM(QUSRJOBI) PARM(&JOBINFO &RTNLEN +
                             'JOBI0600' &JOB &INTJOBID)

             CHGVAR     VAR(&F3) VALUE(%SST(&JOBINFO &F3LOC 1))
             CHGVAR     VAR(&F12) VALUE(%SST(&JOBINFO &F12LOC 1))

 ENDPGM:     ENDPGM
