/*           CRTCMD     CMD(mylib/RTVDTAQD) +                      */
/*                      PGM(QSYS/QMHQRDQD) +                       */
/*                      SRCFILE(mylib/mysrcf) +                    */
/*                      SRCMBR(RTVDTAQD) +                         */
/*                      ALLOW( +                                   */
/*                        *IREXX +                                 */
/*                        *BREXX +                                 */
/*                        *BPGM +                                  */
/*                        *IPGM)                                   */

             CMD        PROMPT('Retrieve *dtaq description')
             PARM       KWD(DTAQD) +
                        TYPE(*CHAR) +
                        LEN(80) +
                        RTNVAL(*YES) +
                        MIN(1) +
                        PROMPT('Dtaq description returned' 2)
             PARM       KWD(DTAQDLEN) +
                        TYPE(*INT4) +
                        CONSTANT(80) +
                        MIN(1)
             PARM       KWD(FORMAT) +
                        TYPE(*NAME) +
                        LEN(8) +
                        CONSTANT(RDQD0100) +
                        MIN(1)
             PARM       KWD(DTAQ) +
                        TYPE(Q014D) +
                        MIN(1) +
                        CHOICE(*NONE) +
                        PROMPT('Dtaq name' 1)
Q014D:       QUAL       TYPE(*NAME) +
                        LEN(10) +
                        MIN(1)
             QUAL       TYPE(*NAME) +
                        LEN(10) +
                        DFT(*LIBL) +
                        SPCVAL( +
                          (*CURLIB ) +
                          (*LIBL )) +
                        PROMPT('Library')
