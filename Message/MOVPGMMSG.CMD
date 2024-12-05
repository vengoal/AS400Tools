/* Command ...... : MOVPGMMSG - Move Program Messages             */
/* CPP .......... : QMHMOVPM                                      */
/* Author ....... : Brian Rusch                                   */
/*                                                                */
/* This is a command interface over IBM's API.                    */
/*                                                                */
/* Published in Four Hundred Guru on May 2, 2012                  */
/* No warranties expressed or implied. Use at your own risk.      */
/*                                                                */
/* Compile with ALLOW(*BPGM *IPGM *BMOD *IMOD)                    */

            CMD        PROMPT('Move Program Messages')

            PARM       KWD(MSGKEY) TYPE(*CHAR) LEN(4) CONSTANT(' ')

            PARM       KWD(MSGTYPE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                         DFT(*DIAG) VALUES(*COMP *DIAG *ESCAPE +
                         *INFO) PROMPT('Message type')

            PARM       KWD(NBRTYPS) TYPE(*INT4) CONSTANT(1)

            PARM       KWD(TOPGMQ) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                         DFT(*PGMBDY) VALUES(* *CTLBDY *PGMBDY) +
                         PROMPT('Call stack entry')

            PARM       KWD(UPSTKCNT) TYPE(*INT4) CONSTANT(1)

            PARM       KWD(ERRCOD) TYPE(*CHAR) LEN(8) +
                         CONSTANT(X'0000000800000000')

/******************************************************************/
/* Command ...... : RSNESCMSG - Resend Escape Message             */
/* CPP .......... : QMHRSNEM                                      */
/* Author ....... : Brian Rusch                                   */
/*                                                                */
/* This is a command interface over IBM's API.                    */
/*                                                                */
/* Published in Four Hundred Guru on May 2, 2012                  */
/* No warranties expressed or implied. Use at your own risk.      */
/*                                                                */
/* Compile with ALLOW(*BPGM *IPGM *BMOD *IMOD)                    */

            CMD        PROMPT('Resend Escape Message')

            PARM       KWD(MSGKEY) TYPE(*CHAR) LEN(4) CONSTANT(' ')

            PARM       KWD(ERRCOD) TYPE(*CHAR) LEN(8) +
                         CONSTANT(X'0000000800000000')

/* Null pointer, to call stack counter (1), pointer qualifier (*PGMBDY) */
            PARM       KWD(TOSTKE) TYPE(*CHAR) LEN(30) +
                         CONSTANT(X'00000000000000000000000000000000+
                         000000015CD7C7D4C2C4E8404040')

            PARM       KWD(TOSTKELEN) TYPE(*INT4) CONSTANT(30)

            PARM       KWD(TOSTKEFMT) TYPE(*CHAR) LEN(8) +
                         CONSTANT(RSNM0200)

            PARM       KWD(FRSTKEADDR) TYPE(*CHAR) LEN(16) +
                         CONSTANT('*')

            PARM       KWD(FRSTKCNT) TYPE(*INT4) CONSTANT(0)
