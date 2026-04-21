/*           CRTCMD     CMD(mylib/CRTUSRSPC) +                     */
/*                      PGM(QSYS/QUSCRTUS) +                       */
/*                      SRCFILE(mylib/mysrc) +                     */
/*                      SRCMBR(CRTUSRSPC) +                        */
/*                      TEXT('QUSCRTUS')                           */

             CMD        PROMPT('Create User Space')
             PARM       KWD(USRSPC) +
                        TYPE(Q00AB) +
                        MIN(1) +
                        CHOICE(*NONE) +
                        PROMPT('Qualified user space name' 1)
Q00AB:       QUAL       TYPE(*NAME) +
                        LEN(10) +
                        MIN(1)
             QUAL       TYPE(*NAME) +
                        LEN(10) +
                        DFT(*CURLIB) +
                        SPCVAL( +
                          (*CURLIB )) +
                        PROMPT('Space library')
             PARM       KWD(EXTATR) TYPE(*NAME) LEN(10) DFT(*NONE) +
                          SPCVAL((*NONE '    ')) PROMPT('Extended +
                          attribute' 2)
             PARM       KWD(INLSIZE) +
                        TYPE(*INT4) +
                        DFT(4096) +
                        RANGE( +
                          1 +
                          16776704) +
                        PROMPT('User space length in bytes' 3)
             PARM       KWD(INLVALUE) +
                        TYPE(*HEX) +
                        LEN(1) +
                        DFT(X'F0F0') +
                        CHOICE('Single-char *HEX') +
                        PROMPT('Initial value to fill' 4)
             PARM       KWD(AUT) +
                        TYPE(*CHAR) +
                        LEN(10) +
                        RSTD(*YES) +
                        DFT(*LIBCRTAUT) +
                        VALUES( +
                          '*ALL' +
                          '*CHANGE' +
                          '*EXCLUDE' +
                          '*LIBCRTAUT' +
                          '*USE') +
                        PROMPT('Default *public authority' 5)
             PARM       KWD(TEXT) +
                        TYPE(*CHAR) +
                        LEN(50) +
                        DFT(*NONE) +
                        SPCVAL( +
                          (*NONE ' ')) +
                        PROMPT('User space text' 7)
             PARM       KWD(DELETE) +
                        TYPE(*CHAR) +
                        LEN(10) +
                        RSTD(*YES) +
                        DFT(*NO) +
                        VALUES( +
                          '*YES' +
                          '*NO') +
                        PROMPT('Delete if it exists' 6)
             PARM       KWD(ERRCOD) +
                        TYPE(*INT4) +
                        CONSTANT(0)
