/*           CRTCMD     CMD(mylib/RSNESCMSG) +                     */
/*                      PGM(QSYS/QMHRSNEM) +                       */
/*                      SRCFILE(mylib/mysrc) +                     */
/*                      SRCMBR(RSNESCMSG)                          */

             CMD        PROMPT('Resend Escape Message')
             PARM       KWD(MSGKEY) +
                        TYPE(*CHAR) +
                        LEN(4) +
                        CONSTANT('    ')
             PARM       KWD(ERRCOD) +
                        TYPE(*INT4) +
                        CONSTANT(0)
