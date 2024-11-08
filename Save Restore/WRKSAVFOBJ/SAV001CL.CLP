/*===============================================================*/
/* To compile:                                                   */
/*                                                               */
/*           CRTCLPGM   PGM(XXX/SAV001CL) SRCFILE(XXX/QCLSRC)    */
/*                                                               */
/*===============================================================*/
             PGM        PARM(&SAVF &OBJ &OBJTYP)

             DCL        VAR(&SAVF) TYPE(*CHAR) LEN(20)
             DCL        VAR(&OBJ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OBJTYP) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OBJATR) TYPE(*CHAR) LEN(10)
             DCL        VAR(&RTNLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&ERRDTA) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(80)

             /* Send all errors to error handling routine */
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERROR))

             /* Don't allow this command to be called recursively */
             SNDPGMMSG  MSG(' ') TOPGMQ(*SAME (SAV001RG))
             MONMSG     MSGID(CPF2469) EXEC(GOTO CMDLBL(CONTINUE))
             RMVMSG     PGMQ(*SAME (SAV001RG)) CLEAR(*ALL)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Command +
                          WRKSAVFOBJ already in use within this +
                          job') MSGTYPE(*ESCAPE)

             /* Check to be sure file exists */
 CONTINUE:   CHKOBJ     OBJ(%SST(&SAVF 11 10)/%SST(&SAVF 1 10)) +
                          OBJTYPE(*FILE)

             /* Check to be sure file is a save file */
             RTVOBJD    OBJ(%SST(&SAVF 11 10)/%SST(&SAVF 1 10)) +
                          OBJTYPE(*FILE) RTNLIB(&RTNLIB) +
                          OBJATR(&OBJATR)
             IF         COND(&OBJATR *NE 'SAVF') THEN(SNDPGMMSG +
                          MSGID(CPF3782) MSGF(QCPFMSG) +
                          MSGDTA(&SAVF) MSGTYPE(*ESCAPE))
             CHGVAR     VAR(%SST(&SAVF 11 10)) VALUE(&RTNLIB)

             /* Re-create the user space */
             DLTUSRSPC  USRSPC(QTEMP/SAV001US)
             MONMSG     MSGID(CPF0000)
             CALL       PGM(QUSCRTUS) PARM('SAV001US  QTEMP' '' +
                          100000 '' '*ALL' '')

             /* Call program to display save file information */
             CALL       PGM(SAV001RG) PARM(&SAVF &OBJ &OBJTYP &ERRDTA)
             IF         COND(&ERRDTA *EQ '*EMPTY') THEN(SNDPGMMSG +
                          MSGID(CPF3707) MSGF(QCPFMSG) +
                          MSGDTA(&SAVF) MSGTYPE(*ESCAPE))
             ELSE       CMD(IF COND(&ERRDTA *NE ' ') THEN(SNDPGMMSG +
                          MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Save +
                          file data generated with' *BCAT &ERRDTA +
                          *BCAT 'command not supported') +
                          MSGTYPE(*ESCAPE)))

             /* Branch around error handling routine */
             GOTO       CMDLBL(ENDPGM)

             /* Error handling routine */
 ERROR:      RCVMSG     MSGTYPE(*EXCP) MSGDTA(&MSGDTA) MSGID(&MSGID)
             SNDPGMMSG  MSGID(&MSGID) MSGF(QCPFMSG) MSGDTA(&MSGDTA) +
                          MSGTYPE(*ESCAPE)
 ENDPGM:     ENDPGM
