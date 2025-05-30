/********************************************************************/
/*   Title:      CHKJLMSGID: Check JobLog by MsgId                  */
/*                                                                  */
/*   Description - This command performs job log checked by MSGID   */
/*                                                                  */
/*   The Create Command command should include the following:       */
/*                                                                  */
/*           CRTCMD     CMD(CHKJLMSGID) PGM(CHKJLMSGID)             */
/*                                                                  */
/********************************************************************/
      /*------------------------------------------------*/
      /*  Command Definition                            */
      /*------------------------------------------------*/

             CMD        PROMPT('Check JobLog by MsgID')
             PARM       KWD(JOB) +
                        TYPE(Q10DD) +
                        DFT(*) +
                        SNGVAL( +
                          (* )) +
                        KEYPARM(*YES) +
                        PROMPT('Job name' 1)
             PARM       KWD(MSGID) TYPE(*CHAR) LEN(7) MIN(1) +
                          PROMPT('Message ID to be checked')
             PARM       KWD(MSGF) TYPE(*CHAR) LEN(10) +
                          RTNVAL(*YES) PROMPT('CL var for +
                          MSGF         (10)')
             PARM       KWD(MSGFLIB) TYPE(*CHAR) LEN(10) +
                          RTNVAL(*YES) PROMPT('CL var for +
                          MSGFLIB      (10)')
             PARM       KWD(MSGDTA) TYPE(*CHAR) LEN(256) +
                          RTNVAL(*YES) PROMPT('CL var for +
                          MSGDTA      (256)')
Q10DD:       QUAL       TYPE(*NAME) +
                        LEN(10) +
                        MIN(1) +
                        EXPR(*YES)
             QUAL       TYPE(*NAME) +
                        LEN(10) +
                        EXPR(*YES) +
                        PROMPT('User')
             QUAL       TYPE(*CHAR) +
                        LEN(6) +
                        RANGE( +
                          '000000' +
                          '999999') +
                        FULL(*YES) +
                        EXPR(*YES) +
                        PROMPT('Number')
