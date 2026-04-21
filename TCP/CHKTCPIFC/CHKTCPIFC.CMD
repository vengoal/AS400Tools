/*  ===============================================================  */
/*  = Command....... ChkTcpIfc                                    =  */
/*  = CPP........... ChkTcpIfc                                    =  */
/*  = Description... Check TCP/IP Interface Status                =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( ChkTcpIfc )                                =  */
/*  =             Pgm( ChkTcpIfc )                                =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  =                                                             =  */
/*  = For V5R1 and later use                                      =  */
/*  =                                                             =  */
/*  = Usage in CLP:                                               =  */
/*  =   ChkTcpIfc NETIFC( ip_address )                            =  */
/*  =   MONMSG CPF9898 => Possible error as following:            =  */
/*  =                     1. TCP/IP is not active.                =  */
/*  =                     2. Interface address is not active.     =  */
/*  =                     3. Interface address is not defined.    =  */
/*  ===============================================================  */
/*  = Date  : 2007/06/26                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             CMD        PROMPT('Check TCP/IP Interface Status')

             PARM       KWD(NETIFC) TYPE(*CHAR) LEN(15) MIN(1) +
                          PROMPT('Network interface address')
