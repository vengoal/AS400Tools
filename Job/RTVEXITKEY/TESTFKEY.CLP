TESTFKEY:   PGM
             DCL        VAR(&F3) TYPE(*CHAR) LEN(1)
             DCL        VAR(&F12) TYPE(*CHAR) LEN(1)

 SPLF:       WRKSPLF

             RTVEXITKEY  RTNF3(&F3)
             IF          (&F3 = '1') DO
              /*  user pressed F3 to exit WrkSplf  */
             ENDDO

 ENDPGM:     ENDPGM
