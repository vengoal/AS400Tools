/* ***************************************************************** */
/* MODULE       RtvSrcL                                              */
/* ~~~~~~                                                            */
/* FUNCTION     Retrieve ILE Source Code control.                    */
/* ~~~~~~~~                                                          */
/* APPLICATION  Retrieve ILE Source Code.                            */
/* ~~~~~~~~~~~                                                       */
/* SPECIAL ATTR *None                                                */
/* ~~~~~~~~~~~~                                                      */
/* AUTHOR       Chris Stead                        DATE : 31/1/97    */
/* ~~~~~~                                          ~~~~              */
/* COPYRIGHT (c) 1997 Chris Stead, All rights reserved.              */
/* ***************************************************************** */
             PGM        PARM(&OBJ__LIB &TYPE &MODULE &FILE__LIB +
                          &MEMBER)

             DCL        VAR(&OBJ__LIB) TYPE(*CHAR) LEN(20)
             DCL        VAR(&OBJECT) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OBJ_LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&TYPE) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MODULE) TYPE(*CHAR) LEN(10)
             DCL        VAR(&FILE__LIB) TYPE(*CHAR) LEN(20)
             DCL        VAR(&FILE) TYPE(*CHAR) LEN(10)
             DCL        VAR(&FILE_LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MEMBER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&DESCRIPT) TYPE(*CHAR) LEN(50)
             DCL        VAR(&TIMESTAMP) TYPE(*CHAR) LEN(13)
             DCL        VAR(&VIEW_NUMB) TYPE(*CHAR) LEN(4)
             DCL        VAR(&SRCTYPE) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SQL) TYPE(*CHAR) LEN(1)

             DCL        VAR(&PGM) TYPE(*CHAR) LEN(10) +
                          VALUE('RtvSrc')
             DCL        VAR(&MESSAGE) TYPE(*CHAR) LEN(100)
             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7)
             DCL        VAR(&MSG) TYPE(*CHAR) LEN(256)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(256)
             DCL        VAR(&MSGF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGFLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGKEY) TYPE(*CHAR) LEN(4)
             DCL        VAR(&SEV) TYPE(*DEC) LEN(2 0)
             DCL        VAR(&ERRORFLAG) TYPE(*LGL) LEN(1)
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* Global message monitor                                            */
             MONMSG     MSGID(CPF9999 CPF0000 MCH0000) EXEC(GOTO +
                          CMDLBL(ERROR))

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
             CHGVAR     VAR(&FILE) VALUE(%SST(&FILE__LIB 1 10))
             CHGVAR     VAR(&FILE_LIB) VALUE(%SST(&FILE__LIB 11 10))
             CHGVAR     VAR(&OBJECT) VALUE(%SST(&OBJ__LIB 1 10))
             CHGVAR     VAR(&OBJ_LIB) VALUE(%SST(&OBJ__LIB 11 10))
             CHGVAR     VAR(%BIN(&VIEW_NUMB)) VALUE(0)

/* Check the object exists. */
             IF         COND(&TYPE = '*ANY') THEN(DO)
             CHGVAR     VAR(&TYPE) VALUE('*PGM')
             CHKOBJ     OBJ(&OBJ_LIB/&OBJECT) OBJTYPE(&TYPE)
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CHGVAR     VAR(&TYPE) VALUE('*SRVPGM')
             CHKOBJ     OBJ(&OBJ_LIB/&OBJECT) OBJTYPE(&TYPE)
             ENDDO
             ENDDO

             ELSE       CMD(CHKOBJ OBJ(&OBJ_LIB/&OBJECT) +
                          OBJTYPE(&TYPE))

/* Retrieve the object library name. */
             RTVOBJD    OBJ(&OBJ_LIB/&OBJECT) OBJTYPE(&TYPE) +
                          RTNLIB(&OBJ_LIB)

/* Start debugging. */
             IF         COND(&TYPE *EQ '*PGM') THEN(DO)
             STRDBG     PGM(&OBJ_LIB/&OBJECT) UPDPROD(*YES) +
                          DSPMODSRC(*NO)
             MONMSG     MSGID(CPF0001)
             ENDDO

             ELSE       CMD(DO)
             STRDBG     PGM(RTVSRC) UPDPROD(*YES) DSPMODSRC(*NO)
             MONMSG     MSGID(CPF0001)
             ENDDO

/* Display a list of modules from which source can be retrieved.     */
             IF         COND(&MODULE *EQ '*SELECT') THEN(DO)
             CALLPRC    PRC(RTVSRC3) PARM(&OBJECT &OBJ_LIB &TYPE +
                          &MSGID &MSGDTA)
             MONMSG     MSGID(CPF0000 RNX0000) EXEC(GOTO CMDLBL(ERROR))
             IF         COND(&MSGID *NE ' ') THEN(SNDPGMMSG +
                          MSGID(&MSGID) MSGF(QCPFMSG) +
                          MSGDTA(&MSGDTA) MSGTYPE(*DIAG))
             GOTO       CMDLBL(ENDPGM)
             ENDDO

             IF         COND(&MODULE *EQ '*OBJECT') THEN(CHGVAR +
                          VAR(&MODULE) VALUE(&OBJECT))
             IF         COND(&MEMBER *EQ '*MODULE') THEN(CHGVAR +
                          VAR(&MEMBER) VALUE(&MODULE))

/* Check that the named library, source file and member exists.      */
/* If the member does not exist then create it. If the file or       */
/* library do not exist then return an error message.                */
             CHKOBJ     OBJ(&FILE_LIB/&FILE) OBJTYPE(*FILE) +
                          MBR(&MEMBER)
             MONMSG     MSGID(CPF9810 CPF9801) EXEC(GOTO CMDLBL(ERROR))
             MONMSG     MSGID(CPF9815) EXEC(ADDPFM +
                          FILE(&FILE_LIB/&FILE) MBR(&MEMBER))

             CALLPRC    PRC(RTVSRC1) PARM(&OBJECT &OBJ_LIB &MODULE +
                          &TYPE &SQL &DESCRIPT &TIMESTAMP +
                          &VIEW_NUMB &MSGID &MSGDTA)
             MONMSG     MSGID(CPF0000 RNX0000) EXEC(GOTO CMDLBL(ERROR))
             IF         COND(&MSGID *NE ' ') THEN(DO)
             SNDPGMMSG  MSGID(&MSGID) MSGF(QCPFMSG) MSGDTA(&MSGDTA) +
                          MSGTYPE(*DIAG)
             GOTO       CMDLBL(ENDPGM)
             ENDDO

/* Clear source file members.                                        */
             CHKOBJ     OBJ(QTEMP/QSOURCE) OBJTYPE(*FILE)
             MONMSG     MSGID(CPF9801) EXEC(DO)
             CRTSRCPF   FILE(QTEMP/QSOURCE) RCDLEN(240)
             ENDDO
             CHKOBJ     OBJ(QTEMP/QSOURCE) OBJTYPE(*FILE) MBR(QSOURCE)
             MONMSG     MSGID(CPF9815) EXEC(DO)
             ADDPFM     FILE(QTEMP/QSOURCE) MBR(QSOURCE)
             ENDDO

             CLRPFM     FILE(&FILE_LIB/&FILE) MBR(&MEMBER)
             CLRPFM     FILE(QTEMP/QSOURCE)

/* Retrieve Source Code.                                             */
             CALLPRC    PRC(RTVSRC2) PARM(&OBJECT &OBJ_LIB &MODULE +
                          &TYPE &SQL &DESCRIPT &TIMESTAMP +
                          &VIEW_NUMB &SRCTYPE &MSGID &MSGDTA)
             MONMSG     MSGID(CPF0000 RNX0000) EXEC(GOTO CMDLBL(ERROR))
             IF         COND(&MSGID *NE ' ') THEN(SNDPGMMSG +
                          MSGID(&MSGID) MSGF(QCPFMSG) +
                          MSGDTA(&MSGDTA) MSGTYPE(*DIAG))

/* Copy retrieved source into the named source file member.          */
             CPYF       FROMFILE(QSOURCE) TOFILE(&FILE_LIB/&FILE) +
                          TOMBR(&MEMBER) MBROPT(*REPLACE) +
                          FMTOPT(*MAP *DROP)

/* Change the source type for the retrieved source.                  */
             IF         COND(&SQL *EQ '1') THEN(CHGVAR VAR(&SRCTYPE) +
                          VALUE('SQL' *TCAT &SRCTYPE))
             CHGPFM     FILE(&FILE_LIB/&FILE) MBR(&MEMBER) +
                          SRCTYPE(&SRCTYPE)

             SNDPGMMSG  MSG('Source for' *BCAT &MODULE *BCAT 'in' +
                          *BCAT &OBJ_LIB *TCAT '/' *TCAT &OBJECT +
                          *BCAT 'retrieved.')
             GOTO       CMDLBL(ENDPGM)

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
/* Error Handling logic                                              */
ERROR:

/* If looping in the error handling routine, end in error            */
             IF         COND(&ERRORFLAG) THEN(DO)
             SNDPGMMSG  MSGID(CPF9999) MSGF(QCPFMSG) MSGTYPE(*ESCAPE)
             MONMSG     MSGID(CPF0000)
             GOTO       CMDLBL(ENDPGM)
             ENDDO

/* Set flag to prevent looping                                       */
             CHGVAR     VAR(&ERRORFLAG) VALUE('1')

/* Re-send any diagnostic messages sent to this program              */
 ERROR1:     RCVMSG     MSGTYPE(*DIAG) RMV(*NO) KEYVAR(&MSGKEY) +
                          MSG(&MSG) MSGDTA(&MSGDTA) MSGID(&MSGID) +
                          MSGF(&MSGF) SNDMSGFLIB(&MSGFLIB)
             IF         COND(&MSGKEY *EQ ' ') THEN(GOTO CMDLBL(ERROR2))
             RMVMSG     MSGKEY(&MSGKEY)

/* Re-send any messages (suppress debug messages).                   */
             IF         COND(&MSGID *NE 'CPD0039') THEN(SNDPGMMSG +
                          MSGID(&MSGID) MSGF(&MSGFLIB/&MSGF) +
                          MSGDTA(&MSGDTA) MSGTYPE(*DIAG))
             GOTO       CMDLBL(ERROR1)

/* Obtain error message.                                             */
 ERROR2:
             RCVMSG     MSGTYPE(*EXCP) RMV(*NO) MSG(&MSG) +
                          MSGDTA(&MSGDTA) MSGID(&MSGID) SEV(&SEV) +
                          MSGF(&MSGF) SNDMSGFLIB(&MSGFLIB)

/* Re-send escape message - cannot send severity 0 escape message    */
             IF         COND(&SEV *GT 00) THEN(DO)
             SNDPGMMSG  MSGID(&MSGID) MSGF(&MSGFLIB/&MSGF) +
                          MSGDTA(&MSGDTA) MSGTYPE(*ESCAPE)
             ENDDO
             ELSE       CMD(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA(&MSG) +
                          MSGTYPE(*ESCAPE)
             ENDDO

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
ENDPGM:
             ENDDBG
             MONMSG     MSGID(CPF0000)

             ENDPGM
