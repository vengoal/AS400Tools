/*           CRTCMD     CMD(mylib/MOVDIAGMSG) +                    */
/*                      PGM(QSYS/QMHMOVPM) +                       */
/*                      SRCFILE(mylib/mysrc) +                     */
/*                      SRCMBR(MOVDIAGMSG) +                       */
/*                      ALLOW( +                                   */
/*                        *IREXX +                                 */
/*                        *BREXX +                                 */
/*                        *BPGM +                                  */
/*                        *IPGM)                                   */

             CMD        PROMPT('Move Diagnostic Message')
             PARM       KWD(MSGKEY) +
                        TYPE(*CHAR) +
                        LEN(4) +
                        CONSTANT('    ')
             PARM       KWD(MSGTYP) +
                        TYPE(*CHAR) +
                        LEN(10) +
                        CONSTANT(*DIAG)
             PARM       KWD(NBRTYPS) +
                        TYPE(*INT4) +
                        CONSTANT(1)
             PARM       KWD(MSGQ) +
                        TYPE(*CHAR) +
                        LEN(10) +
                        CONSTANT(*)
             PARM       KWD(STCKCNT) +
                        TYPE(*INT4) +
                        CONSTANT(1)
             PARM       KWD(ERRCOD) +
                        TYPE(*INT4) +
                        CONSTANT(0)
