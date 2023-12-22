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
             PGM        PARM(&DSPJRN20 &OUTF20 &OPT &JRNF20)
             DCL        VAR(&DSPJRN20)   TYPE(*CHAR) LEN(20)
             DCL        VAR(&OUTF20)     TYPE(*CHAR) LEN(20)
             DCL        VAR(&OPT)        TYPE(*CHAR) LEN(8)
             DCL        VAR(&JRNF20)     TYPE(*CHAR) LEN(20)
             DCL        VAR(&DSPJRNFIL)  TYPE(*CHAR) LEN(10)
             DCL        VAR(&DSPJRNLIB)  TYPE(*CHAR) LEN(10)
             DCL        VAR(&OUTFIL)     TYPE(*CHAR) LEN(10)
             DCL        VAR(&OUTLIB)     TYPE(*CHAR) LEN(10)
             DCL        VAR(&JRNFIL)     TYPE(*CHAR) LEN(10)
             DCL        VAR(&JRNLIB)     TYPE(*CHAR) LEN(10)
             DCL        VAR(&SQL)        TYPE(*CHAR) LEN(1000)
             DCL        VAR(&SQLCODE)    TYPE(*CHAR) LEN(4)
             DCL        VAR(&ERRMSGID)   TYPE(*CHAR) LEN(7)
             DCL        VAR(&ERRQUIT)    TYPE(*LGL)
             DCL        VAR(&ERRKEY)     TYPE(*CHAR) LEN(4)
             DCL        VAR(&ERRCODE)    TYPE(*CHAR) LEN(16) +
                          VALUE(X'0000000000000010')
             MONMSG     MSGID(CPF0000)   EXEC(GOTO CMDLBL(ERROR))
/*-------------------------------------------------------------------*/
             CHGVAR     VAR(&DSPJRNFIL) VALUE(%SST(&DSPJRN20  1 10))
             CHGVAR     VAR(&DSPJRNLIB) VALUE(%SST(&DSPJRN20 11 10))
             CHGVAR     VAR(&OUTFIL)    VALUE(%SST(&OUTF20    1 10))
             CHGVAR     VAR(&OUTLIB)    VALUE(%SST(&OUTF20   11 10))
             CHGVAR     VAR(&JRNFIL)    VALUE(%SST(&JRNF20    1 10))
             CHGVAR     VAR(&JRNLIB)    VALUE(%SST(&JRNF20   11 10))
/*-------------------------------------------------------------------*/
/*-----           Make sure DSPJRN Output file exists           -----*/
/*-------------------------------------------------------------------*/
             CHKOBJ     OBJ(&DSPJRNLIB/&DSPJRNFIL) OBJTYPE(*FILE)
/*-------------------------------------------------------------------*/
/*-----     Make sure Converted Output file does not exist.     -----*/
/*-----     If *LIBL or *CURLIB was specified for the           -----*/
/*-----     library, retrieve the actual library name.          -----*/
/*-------------------------------------------------------------------*/
             IF         COND(&OPT *EQ '*NONE   ') THEN(DO)
                CHKOBJ     OBJ(&OUTLIB/&OUTFIL) OBJTYPE(*FILE)
                MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(CONTINUE))
                IF         COND(%SST(&OUTLIB 1 1) *EQ '*') THEN(RTVOBJD +
                             OBJ(&OUTLIB/&OUTFIL) OBJTYPE(*FILE) +
                             RTNLIB(&OUTLIB))
                SNDPGMMSG  MSGID(CPF9898) MSGF(QSYS/QCPFMSG) +
                             MSGDTA('Converted Output File ' *CAT +
                             &OUTLIB *TCAT '/' *CAT &OUTFIL *BCAT +
                             'already exists')
                GOTO       CMDLBL(ESCAPE)
                ENDDO
             IF         COND(&OPT *EQ '*REPLACE') THEN(DO)
                CHKOBJ     OBJ(&OUTLIB/&OUTFIL) OBJTYPE(*FILE)
                MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(CONTINUE))
                DLTF       FILE(&OUTLIB/&OUTFIL)
                GOTO       CMDLBL(CONTINUE)
                ENDDO
             IF         COND(&OPT *EQ '*ADD    ') THEN(DO)
                CHKOBJ     OBJ(&OUTLIB/&OUTFIL) OBJTYPE(*FILE)
                MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(CONTINUE))
                RCVMSG     MSGTYPE(*EXCP)
                GOTO       CMDLBL(MAP)
                ENDDO
/*-------------------------------------------------------------------*/
 CONTINUE:   RCVMSG     MSGTYPE(*EXCP)
/*-------------------------------------------------------------------*/
/*-----     If JRNFILE(*AUTO) was not specified, and *LIBL or   -----*/
/*-----     *CURLIB was specified for the library, check that   -----*/
/*-----     the file exists and retrieve the library name.      -----*/
/*-------------------------------------------------------------------*/
             IF         COND(&JRNFIL *NE '*AUTO     ' *AND +
                          %SST(&JRNLIB 1 1) *EQ '*') THEN(RTVOBJD +
                          OBJ(&JRNLIB/&JRNFIL) OBJTYPE(*FILE) +
                          RTNLIB(&JRNLIB))
/*-------------------------------------------------------------------*/
/*-----  Create the output file using an SQL join between the   -----*/
/*-----  DSPJRN output file, which contains the audit data,     -----*/
/*-----  and the original journaled file, which contains        -----*/
/*-----  the user data.                                         -----*/
/*-------------------------------------------------------------------*/
             CALL       PGM(CVTJRD) PARM(&DSPJRNFIL &DSPJRNLIB +
                          &OUTFIL &OUTLIB &JRNFIL &JRNLIB &SQLCODE +
                          &SQL)
             IF         COND(&SQLCODE *NE '    ') THEN(DO)
                SNDPGMMSG MSGID(CPF9898) MSGF(QSYS/QCPFMSG) +
                            MSGDTA('SQL error ' *CAT &SQLCODE *BCAT +
                            'occurred. See previous low level +
                            messages. Last SQL statement..')
                SNDPGMMSG MSG(&SQL)
                GOTO      CMDLBL(ESCAPE)
                ENDDO
/*-------------------------------------------------------------------*/
/*-----     Map the data to the newly created file.             -----*/
/*-----     FMTOPT(*NOCHK) allows JOESD to be mapped to the     -----*/
/*-----     original database fields.                           -----*/
/*-------------------------------------------------------------------*/
 MAP:        CPYF       FROMFILE(&DSPJRNLIB/&DSPJRNFIL) +
                          TOFILE(&OUTLIB/&OUTFIL) FROMMBR(*FIRST) +
                          TOMBR(*FIRST) MBROPT(*ADD) INCREL((*IF +
                          JOCODE *EQ 'R')) FMTOPT(*NOCHK)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QSYS/QCPFMSG) +
                          MSGDTA('Journal data prepared for use in +
                          ' *CAT &OUTLIB *TCAT '/' *CAT &OUTFIL) +
                          MSGTYPE(*COMP)
/*-------------------------------------------------------------------*/
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
 ESCAPE:     SNDPGMMSG  MSGID(CPF0001) MSGF(QSYS/QCPFMSG) +
                          MSGDTA(CVTJRNDTA) MSGTYPE(*ESCAPE)
             ENDPGM
