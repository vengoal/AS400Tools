/*  ===============================================================  */
/*  = Command....... RtvTcpSts                                    =  */
/*  = CPP........... RtvTcpSts RPGLE                              =  */
/*  = Description... Retrieve TCP/IP Status                       =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( RtvTcpSts )                                =  */
/*  =             Pgm( RtvTcpSts  )                               =  */
/*  =             SrcFile( YourSourceFile ) Allow(*Ipgm *Bpgm)    =  */
/*  ===============================================================  */
/*  = Date  : 2022/04/24                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             CMD        PROMPT('Retrieve TCP/TP Status')
             PARM       KWD(TCPSTS) TYPE(*CHAR) LEN(10) RTNVAL(*YES) +
                          PROMPT('TCP/IP status')
             PARM       KWD(LMTMODE) TYPE(*CHAR) LEN(4) RTNVAL(*YES) +
                          PROMPT('Limit mode')
             PARM       KWD(STRDATE) TYPE(*CHAR) LEN(8) RTNVAL(*YES) +
                          PROMPT('Last start date')
             PARM       KWD(STRTIME) TYPE(*CHAR) LEN(6) RTNVAL(*YES) +
                          PROMPT('Last start time')
             PARM       KWD(EndDate) TYPE(*CHAR) LEN(8) RTNVAL(*YES) +
                          PROMPT('Last End date')
             PARM      KWD(EndDTime) TYPE(*CHAR) LEN(6) RTNVAL(*YES) +
                          PROMPT('Last End date')
             PARM      KWD(StrJob) TYPE(*CHAR) LEN(10) RTNVAL(*YES) +
                          PROMPT('Last started job')
             PARM      KWD(StrUsr) TYPE(*CHAR) LEN(10) RTNVAL(*YES) +
                          PROMPT('Last started job user')
             PARM      KWD(StrNbr) TYPE(*CHAR) LEN( 6) RTNVAL(*YES) +
                          PROMPT('Last started job number')
             PARM      KWD(EndJob) TYPE(*CHAR) LEN(10) RTNVAL(*YES) +
                          PROMPT('Last ended job')
             PARM      KWD(EndUsr) TYPE(*CHAR) LEN(10) RTNVAL(*YES) +
                          PROMPT('Last ended job user')
             PARM      KWD(EndNbr) TYPE(*CHAR) LEN( 6) RTNVAL(*YES) +
                          PROMPT('Last ended job number')
