/* ** Start of specifications ************************************************/
/*PARMS                                                                      */
/*                                                                           */
/* Module name . . . . . . . : STRCLRDRC                                     */
/*                                                                           */
/* Descriptive name  . . . . : Start CL Reader                               */
/*                                                                           */
/* Function  . . . . . . . . : Reads a CL source member and executes         */
/*                             each CL statement by sending each line        */
/*                             as a *RQS message to the *EXT message         */
/*                             queue of the job and then calling the         */
/*                             command executor to run them.                 */
/*                             Allows interactive CL interpretation of       */
/*                             CL command groups similar to STRDBRDR.        */
/*                                                                           */
/* Copyright:                                                                */
/*   (C) Copyright S.H. Coulter 1987, 2002. All rights reserved.             */
/*   (C) Copyright FlyByNight Software. 1987, 2002. All rights reserved.     */
/*                                                                           */
/* Module type:                                                              */
/*   Processor . . . . . . . : CLP                                           */
/*                                                                           */
/*   Module size . . . . . . :                                               */
/*                                                                           */
/*   Attributes  . . . . . . :                                               */
/*                                                                           */
/* Entry:                                                                    */
/*   Entry point . . . . . . : STRCLRDRC                                     */
/*                                                                           */
/*   Purpose . . . . . . . . : (See function)                                */
/*                                                                           */
/*   Linkage . . . . . . . . : CPP for STRCLRDR                              */
/*                                                                           */
/* Input . . . . . . . . . . : &QUALSRCF   - Qualifed source file            */
/*                             &SRCMBR     - Member name                     */
/*                                                                           */
/* Output  . . . . . . . . . : *NONE                                         */
/*                                                                           */
/* External references:                                                      */
/*   Routines  . . . . . . . : STDERR     - Standard error handler           */
/*                             EXTQUALOBJ - Extract qualified object         */
/*                                                                           */
/*   Files . . . . . . . . . :                                               */
/*                                                                           */
/*   Data areas  . . . . . . :                                               */
/*                                                                           */
/*   Control blocks  . . . . :                                               */
/*                                                                           */
/*   References from UIM . . :                                               */
/*                                                                           */
/* Exits-- Normal  . . . . . : Return to NSI                                 */
/*      -- Error . . . . . . : Resignal escape message to caller             */
/*                                                                           */
/* Messages:                                                                 */
/*   Generated . . . . . . . : CPF9898 - Impromptu messages                  */
/*                                                                           */
/*   Resignalled . . . . . . : *ESCAPE messages                              */
/*                             *NOTIFY messages                              */
/*                                                                           */
/*   Monitored . . . . . . . : CPF9999 - Function check exceptions           */
/*                             CPF0864 - End of file.                        */
/*                                                                           */
/* Macros/Includes . . . . . :                                               */
/*                                                                           */
/* Data/Tables . . . . . . . :                                               */
/*                                                                           */
/* Notes:                                                                    */
/*   Dependencies  . . . . . : STDERR     - Standard error handler           */
/*                             EXTQUALOBJ - Extract qualified object         */
/*                                                                           */
/*   Restrictions  . . . . . :                                               */
/*                                                                           */
/*   Register conventions  . : N/A                                           */
/*                                                                           */
/*   Patch label . . . . . . : N/A                                           */
/*                                                                           */
/*   Support . . . . . . . . : shc@flybnight.com.au                          */
/*                                                                           */
/* Change activity:                                                          */
/*               Rlse &                                                      */
/* Flag Reason   Level  Date   Pgmr       Comments                           */
/* ---- -------- ------ ------ ---------- -----------------------------------*/
/* $A0= D               870128 SHC:       Initial coding of module.          */
/* $A1= D               920107 SHC:       Support both S/38 and AS/400 syntax*/
/* $A2= D               020926 SHC:       Remove dumb defaults and make more */
/*                                          like an IBM command.             */
/* --------------------------------------------------------------------------*/
/* $A3=  Modified by Vengoal Chang 2024/11/08                                */
/*                             STDERR     replaced by MOVDIAGMSG, RSNESCMSG  */
/*                             EXTQUALOBJ replaced by CHGVAR                 */
/*                                                                           */
/* ** End of specifications **************************************************/

 STRCLRDRC:  PGM        PARM(&QUALSRCF &SRCMBR)

/*                                                                 */
/* ---------------- Input Parameter Declarations ----------------- */
/*                                                                 */
             DCL        VAR(&QUALSRCF) TYPE(*CHAR) LEN(20)
                        /* Qualified soucre file                   */
             DCL        VAR(&SRCMBR) TYPE(*CHAR) LEN(10)
                        /* Source member name                      */

/*                                                                 */
/* ------------------- Program Declarations ---------------------- */
/*                                                                 */
             DCLF       FILE(QCLSRC)
                        /* Source file template                    */

             DCL        VAR(&SRCF) TYPE(*CHAR) LEN(10)
                        /* Source file                             */
             DCL        VAR(&SRCFLIB) TYPE(*CHAR) LEN(10)
                        /* Source file library                     */
             DCL        VAR(&TYPE) TYPE(*CHAR) LEN(1)
                        /* Source member type                      */
             DCL        VAR(&SRCTYPE) TYPE(*CHAR) LEN(10)
                        /* Source member type                      */
             DCL        VAR(&ERROR) TYPE(*LGL) LEN(1)
                        /* Error flag                              */

/*                                                                 */
/* ---------------- Mnemonic Value Declarations ------------------ */
/*                                                                 */
             DCL        VAR(&BLANK) TYPE(*CHAR) LEN(1) VALUE(X'40')
                        /* Mnemonic for 'blank'                    */
             DCL        VAR(&TRUE) TYPE(*LGL) LEN(1) VALUE('1')
                        /* Mnemonic for 'true'                     */
             DCL        VAR(&FALSE) TYPE(*LGL) LEN(1) VALUE('0')
                        /* Mnemonic for 'false'                    */
             DCL        VAR(&STAR) TYPE(*CHAR) LEN(1) VALUE('*')
                        /* Mnemonic for 'asterisk'                 */
             DCL        VAR(&QUOTE) TYPE(*CHAR) LEN(1) VALUE('''')
                        /* Mnemonic for 'quote'                    */
             DCL        VAR(&BATCH) TYPE(*CHAR) LEN(1) VALUE('0')
                        /* Mnemonic for 'batch job'                */
             DCL        VAR(&INTER) TYPE(*CHAR) LEN(1) VALUE('1')
                        /* Mnemonic for 'interactive job'          */
             DCL        VAR(&ZERO) TYPE(*DEC) LEN(1 0) VALUE(0)
                        /* Mnemonic for 'zero'                     */
             DCL        VAR(&HEX00) TYPE(*CHAR) LEN(2) VALUE(X'0000')
                        /* Mnemonic for 'binary zero'              */

/*                                                                 */
/* ------------------- Copyright Declarations -------------------- */
/*                                                                 */
             DCL        VAR(&COPYRIGHT) TYPE(*CHAR) LEN(80) +
                          VALUE('Copyright (C) FlyByNight Software. +
                          1987, 2002')

/*                                                                 */
/* -------------- Global Message Monitor Intercept --------------- */
/*                                                                 */
             MONMSG     MSGID(CPF9999) EXEC(GOTO CMDLBL(FAILED))

/*                                                                 */
/* ---------- Force Copyright Notice in Executable Code ---------- */
/*                                                                 */
             CHGVAR     VAR(&COPYRIGHT) VALUE(&COPYRIGHT)

             /* Initialise error indicator                         */
             CHGVAR     VAR(&ERROR) VALUE(&FALSE)

             /* Find out job type. Force SBMDBJOB in batch job.    */
             /* Belts and braces code - CDO not allowed in batch.  */
             RTVJOBA    TYPE(&TYPE)
             IF         COND(&TYPE *EQ '0') THEN(DO)
               SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('STRCLRDR +
                            is only valid in an interactive job. Use +
                            SBMDBJOB for batch execution') +
                            MSGTYPE(*ESCAPE)
             ENDDO

             /* Split out the qualified source file names.         */
         /*  EXTQUALOBJ QUALOBJ(&QUALSRCF) OBJ(&SRCF) LIB(&SRCFLIB)*/
             CHGVAR     &SRCF          %SST(&QUALSRCF  1 10)
             CHGVAR     &SRCFLIB       %SST(&QUALSRCF 11 10)

             /* Ensure the source member exists and can be read.   */
             CHKOBJ     OBJ(&SRCFLIB/&SRCF) OBJTYPE(*FILE) MBR(&SRCMBR) +
                          AUT(*USE)

             /* Check that source type is valid for CL interpreter */
             RTVMBRD    FILE(&SRCFLIB/&SRCF) MBR(&SRCMBR) SRCTYPE(&SRCTYPE)
             IF         COND( (&SRCTYPE *NE 'CL')   *AND +
                              (&SRCTYPE *NE 'CL38') *AND +
                              (&SRCTYPE *NE 'CLP')  *AND +
                              (&SRCTYPE *NE 'CLP38') *AND +
                              (&SRCTYPE *NE 'CLLE') ) THEN(DO)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Source +
                          type of member' *BCAT &SRCMBR *BCAT 'in +
                          file' *BCAT &SRCF *BCAT 'in' *BCAT +
                          &SRCFLIB *BCAT 'must be CL, CL38, CLP, +
                          CLP38, or CLLE') MSGTYPE(*ESCAPE)
             ENDDO

             /* Point to the correct source member.                */
             OVRDBF     FILE(QCLSRC) TOFILE(&SRCFLIB/&SRCF) MBR(&SRCMBR)

             /* Read each record in the source member.             */
 READ:       RCVF
             MONMSG     MSGID(CPF0864) EXEC(DO)
               RCVMSG     MSGTYPE(*LAST)
               GOTO CMDLBL(EOF)
             ENDDO

             /* Send the command to the external queue as a        */
             /*   request message.                                 */
             IF         COND(&SRCDTA *NE &BLANK) THEN(DO)
               SNDPGMMSG  MSG(&SRCDTA) TOPGMQ(*EXT) MSGTYPE(*RQS)
             ENDDO

             GOTO       CMDLBL(READ) /* Get the next command       */

 EOF:        DLTOVR     FILE(QCLSRC)

             /* Send message to return control to the module       */
             /* after all source statements have been executed.    */
             SNDPGMMSG  MSG(RETURN) TOPGMQ(*EXT) MSGTYPE(*RQS)

             /* Execute the request messages                       */
             /*   -- QCL is used for System/38 commands            */
             IF         COND((&SRCTYPE *EQ 'CL38') *OR +
                             (&SRCTYPE *EQ 'CLP38')) THEN(DO)
               CALL       PGM(QCL)
             ENDDO
             /*   -- QCMD is used for AS/400 commands              */
             ELSE       CMD(DO)
               CALL       PGM(QCMD)
             ENDDO

/*                                                                 */
/* -------------------- Send User a Message ---------------------- */
/*                                                                 */
             /* Send completion message. This does not guarantee   */
             /* SUCCESSFUL completion of all commands, only that   */
             /* the file was read and statements were processed.   */
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                          MSGDTA('Commands in member' *BCAT &SRCMBR +
                          *BCAT 'in file' *BCAT &SRCF *BCAT 'in' +
                          *BCAT &SRCFLIB *BCAT 'completed') MSGTYPE(*COMP)
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Check +
                          low-level messages for any errors +
                          encountered') MSGTYPE(*COMP)

 EXIT:       RETURN     /* Normal end of program                   */

/*                                                                 */
/* --------------------- Exception Routine ----------------------- */
/*                                                                 */
 FAILED: /*  STDERR     PGMTYPE(*CPP)                              */
         /*  MONMSG     MSGID(CPF9999) /* Just in case             */
             MOVDIAGMSG
             MONMSG     MSGID(CPF0000)
             RSNESCMSG
             MONMSG     MSGID(CPF0000)

 STRCLRDRX:  ENDPGM
