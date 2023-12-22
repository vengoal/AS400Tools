/*********************************************************************/
/* ALL SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY WARRANTY OF ANY      */
/* NATURE WHATSOEVER. THE PROVIDER OF THIS SOFTWARE HEREBY DISCLAIMS */
/* ALL WARRANTIES, REPRESENTATIONS, AND CONDITIONS, STATUATORY OR    */
/* OTHERWISE, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO       */
/* WARRANTY OF TITLE AND THE IMPLIED WARRANTY OF MERCHANTABILITY AND */
/* FITNESS FOR A PARTICULAR PURPOSE. THE PROVIDER SHALL NOT BE       */
/* LIABLE FOR ANY DAMAGES ARISING FROM OR AS A RESULT OF YOUR USE OF */
/* THIS SOFTWARE. USE IT AS YOUR OWN RISK.                           */
/*********************************************************************/
             PGM        PARM(&JRN &RCVRNG &FILE &CVTOUTF &OPT &JRNFILE)
             DCL        VAR(&JRN)        TYPE(*CHAR) LEN(20)
             DCL        VAR(&RCVRNG)     TYPE(*CHAR) LEN(42)
             DCL        VAR(&FILE)       TYPE(*CHAR) LEN(32)
             DCL        VAR(&CVTOUTF)    TYPE(*CHAR) LEN(20)
             DCL        VAR(&OPT)        TYPE(*CHAR) LEN(8)
             DCL        VAR(&JRNFILE)    TYPE(*CHAR) LEN(20)
/*-------------------------------------------------------------------*/
             DCL        VAR(&JRNN)       TYPE(*CHAR) LEN(10)
             DCL        VAR(&JRNL)       TYPE(*CHAR) LEN(10)
             DCL        VAR(&RCVRNGSN)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&RCVRNGSL)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&RCVRNGEN)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&RCVRNGEL)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&FILEN)      TYPE(*CHAR) LEN(10)
             DCL        VAR(&FILEL)      TYPE(*CHAR) LEN(10)
             DCL        VAR(&MBR)        TYPE(*CHAR) LEN(10)
             DCL        VAR(&CVTOUTFN)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&CVTOUTFL)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&JRNFILEN)   TYPE(*CHAR) LEN(10)
             DCL        VAR(&JRNFILEL)   TYPE(*CHAR) LEN(10)
/*-------------------------------------------------------------------*/
             DCL        VAR(&CMD)        TYPE(*CHAR) LEN(2000)
/*-------------------------------------------------------------------*/
             DCL        VAR(&ERRMSGID)   TYPE(*CHAR) LEN(7)
             DCL        VAR(&ERRQUIT)    TYPE(*LGL)
             DCL        VAR(&ERRKEY)     TYPE(*CHAR) LEN(4)
             DCL        VAR(&ERRCODE)    TYPE(*CHAR) LEN(16) +
                          VALUE(X'0000000000000010')
             MONMSG     MSGID(CPF0000)   EXEC(GOTO CMDLBL(ERROR))
/*-------------------------------------------------------------------*/
             CHGVAR     VAR(&JRNN      ) VALUE(%SST(&JRN       1 10))
             CHGVAR     VAR(&JRNL      ) VALUE(%SST(&JRN      11 10))
             CHGVAR     VAR(&RCVRNGSN)   VALUE(%SST(&RCVRNG    3 10))
             CHGVAR     VAR(&RCVRNGSL)   VALUE(%SST(&RCVRNG   13 10))
             CHGVAR     VAR(&RCVRNGEN)   VALUE(%SST(&RCVRNG   23 10))
             CHGVAR     VAR(&RCVRNGEL)   VALUE(%SST(&RCVRNG   33 10))
             CHGVAR     VAR(&FILEN)      VALUE(%SST(&FILE      3 10))
             CHGVAR     VAR(&FILEL)      VALUE(%SST(&FILE     13 10))
             CHGVAR     VAR(&MBR)        VALUE(%SST(&FILE     23 10))
             CHGVAR     VAR(&CVTOUTFN)   VALUE(%SST(&CVTOUTF   1 10))
             CHGVAR     VAR(&CVTOUTFL)   VALUE(%SST(&CVTOUTF  11 10))
             CHGVAR     VAR(&JRNFILEN)   VALUE(%SST(&JRNFILE   1 10))
             CHGVAR     VAR(&JRNFILEL)   VALUE(%SST(&JRNFILE  11 10))
/*-------------------------------------------------------------------*/
             CHGVAR     VAR(&CMD) VALUE('DSPJRN JRN(' *CAT &JRNL +
                          *TCAT '/' *CAT &JRNN *TCAT ') FILE((' +
                          *CAT &FILEL *TCAT '/' *CAT &FILEN *BCAT +
                          &MBR *TCAT '))')
             IF         COND(%SST(&RCVRNGSN 1 1) *EQ '*') +
                          THEN(CHGVAR VAR(&CMD) VALUE(&CMD *BCAT +
                          'RCVRNG(' *CAT &RCVRNGSN *TCAT ')'))
             ELSE       CMD(DO)
                CHGVAR  VAR(&CMD) VALUE(&CMD *BCAT 'RCVRNG(' *CAT +
                          &RCVRNGSL *TCAT '/' *CAT &RCVRNGSN)
                IF      COND(%SST(&RCVRNGEN 1 1) *EQ '*') +
                          THEN(CHGVAR VAR(&CMD) VALUE(&CMD *BCAT +
                          &RCVRNGEN *TCAT ')'))
                ELSE    CMD(CHGVAR VAR(&CMD) VALUE(&CMD *BCAT +
                          &RCVRNGEL *TCAT '/' *CAT &RCVRNGEN *TCAT +
                          ')'))
                ENDDO
             CHGVAR     VAR(&CMD) VALUE(&CMD *BCAT 'OUTPUT(*OUTFILE) +
                          OUTFILE(QTEMP/DMPJRN) ENTDTALEN(*CALC)')
/*-------------------------------------------------------------------*/
             DLTF       FILE(QTEMP/DMPJRN)
             MONMSG     MSGID(CPF2105)
             RMVMSG     CLEAR(*ALL)
/*-------------------------------------------------------------------*/
             CALL       PGM(QCMDEXC) PARM(&CMD 2000)
/*-------------------------------------------------------------------*/
             IF         COND(&JRNFILEN *EQ '*AUTO     ') +
                          THEN(CVTJRNDTA DSPJRNOUTF(QTEMP/DMPJRN) +
                          CVTOUTF(&CVTOUTFL/&CVTOUTFN) OUTOPT(&OPT))
             ELSE       CMD(CVTJRNDTA DSPJRNOUTF(QTEMP/DMPJRN) +
                          CVTOUTF(&CVTOUTFL/&CVTOUTFN) OUTOPT(&OPT) +
                          JRNFILE(&JRNFILEL/&JRNFILEN))
             CALL       PGM(QMHMOVPM) PARM('    ' '*COMP     ' +
                          X'00000001' '*         ' X'00000001' +
                          &ERRCODE)
             RETURN
/*********************************************************************/
 ERROR:      IF         COND(&ERRQUIT) THEN(SNDPGMMSG MSGID(CPF9999) +
                          MSGF(QCPFMSG) MSGTYPE(*ESCAPE)) /* Func chk*/
             CHGVAR     VAR(&ERRQUIT) VALUE('1')
             CALL       PGM(QMHMOVPM) PARM('    ' '*DIAG     ' +
                          X'00000001' '*         ' X'00000001' +
                          &ERRCODE)
             MONMSG     MSGID(CPF24A3) EXEC(RCVMSG MSGTYPE(*LAST))
             RCVMSG     MSGTYPE(*EXCP) RMV(*NO) KEYVAR(&ERRKEY) +
                          MSGID(&ERRMSGID)
             IF         COND(&ERRMSGID *NE 'CPF0001') THEN(CALL +
                          PGM(QMHRSNEM) PARM(&ERRKEY &ERRCODE))
             RMVMSG     MSGKEY(&ERRKEY)
             SNDPGMMSG  MSGID(CPF0001) MSGF(QSYS/QCPFMSG) +
                          MSGDTA(DMPJRN) MSGTYPE(*ESCAPE)
             ENDPGM
