/*           CRTCMD     CMD(mylib/RCVDTAQE) +                      */
/*                      PGM(QSYS/QRCVDTAQ) +                       */
/*                      SRCFILE(mylib/mysrcf) +                    */
/*                      SRCMBR(RCVDTAQE) +                         */
/*                      ALLOW( +                                   */
/*                        *IREXX +                                 */
/*                        *BREXX +                                 */
/*                        *BPGM +                                  */
/*                        *IPGM)                                   */

             CMD        PROMPT('Receive Data Queue Entry')
             PARM       KWD(DTAQ) +
                        TYPE(*NAME) +
                        LEN(10) +
                        MIN(1) +
                        PROMPT('Data queue to receive from')
             PARM       KWD(DTAQLIB) +
                        TYPE(*NAME) +
                        LEN(10) +
                        DFT(*LIBL) +
                        SPCVAL( +
                          (*LIBL ) +
                          (*CURLIB )) +
                        PROMPT('Data queue library')
             PARM       KWD(DTAQFLDLEN) +
                        TYPE(*DEC) +
                        LEN(5 0) +
                        RTNVAL(*YES) +
                        PROMPT('Entry length')
             PARM       KWD(DTAQFLD) +
                        TYPE(*CHAR) +
                        LEN(5000) +
                        RTNVAL(*YES) +
                        PROMPT('Entry return variable')
             PARM       KWD(RCVQWAIT) +
                        TYPE(*DEC) +
                        LEN(5 0) +
                        DFT(*NOWAIT) +
                        SPCVAL( +
                          (*NOMAX -1) +
                          (*NOWAIT 0)) +
                        CHOICE('Seconds (negative=no limit)') +
                        PROMPT('Seconds to wait')
