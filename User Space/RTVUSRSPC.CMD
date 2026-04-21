/*           CRTCMD     CMD(mylib/RTVUSRSPC) +                     */
/*                      PGM(QSYS/QUSRTVUS) +                       */
/*                      SRCFILE(mylib/mysrc) +                     */
/*                      SRCMBR(RTVUSRSPC) +                        */
/*                      TEXT('QUSRTVUS') +                         */
/*                      ALLOW( +                                   */
/*                        *IREXX +                                 */
/*                        *BREXX +                                 */
/*                        *BPGM +                                  */
/*                        *IPGM)                                   */

             CMD        PROMPT('Retrieve User Space (QUSRTVUS)')
             PARM       KWD(USRSPC) +
                        TYPE(Q00AB) +
                        MIN(1) +
                        CHOICE(*NONE) +
                        PROMPT('User space name')
Q00AB:       QUAL       TYPE(*NAME) +
                        LEN(10) +
                        MIN(1)
             QUAL       TYPE(*NAME) +
                        LEN(10) +
                        DFT(*LIBL) +
                        SPCVAL( +
                          (*CURLIB ) +
                          (*LIBL )) +
                        PROMPT('User space library')
             PARM       KWD(STRPOS) +
                        TYPE(*INT4) +
                        DFT(1) +
                        RANGE( +
                          1 +
                          16776704) +
                        PROMPT('Starting position')
             PARM       KWD(RTVLEN) +
                        TYPE(*INT4) +
                        DFT(120) +
                        RANGE( +
                          1 +
                          1000) +
                        PROMPT('Retrieval length')
             PARM       KWD(RCVVAR) +
                        TYPE(*CHAR) +
                        LEN(1000) +
                        RTNVAL(*YES) +
                        PROMPT('Retrieved data     *char(1000)')
