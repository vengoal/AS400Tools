RTVEXITKEY: CMD        PROMPT('Retrieve F3/F12 Status')
   /* Command processing program is RTVEXITKEY *CLP  */
             PARM       KWD(RTNF3) TYPE(*CHAR) LEN(1) RTNVAL(*YES) +
                          PROMPT('CL var for F3 key        (1)')

             PARM       KWD(RTNF12) TYPE(*CHAR) LEN(1) RTNVAL(*YES) +
                          PROMPT('CL var for F12 key       (1)')
