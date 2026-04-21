/*  ===============================================================  */
/*  = Command....... MonMqmCnn                                    =  */
/*  = CPP........... MonMqmCnn                                    =  */
/*  = Description... Monitor MQ Qmgr Connection Status            =  */
/*  =                                                             =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( MonMqmCnn  )                               =  */
/*  =             Pgm( MonMqmCnn  )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  =             Allow( *Ipgm *Bpgm )                            =  */
/*  ===============================================================  */
/*  = Date  : 2017/12/14                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  =                                                             =  */
/*  ===============================================================  */
/*  =                                                             =  */
/*  = Notes:                                                      =  */
/*  =                                                             =  */
/*  =  Start MQ Command Server (STRMQMCSVR)                       =  */
/*  =                                                             =  */
/*  ===============================================================  */

             Cmd        Prompt('Monitor MQ Qmgr Conn Status')

             Parm       Kwd(QmName) Type(*Name) Len(48) Min(1)    +
                          Prompt('Queue manager name')

             Parm       Kwd(OutFile) Type(Qual1)                  +
                          Prompt('File to receive output')

             Parm       Kwd(RC) Type(*Char) Len(4)         Min(1) +
                          RtnVal(*Yes) +
                          Prompt('CL var for MQ reason      (4)')

 Qual1:      Qual       Type(*NAME) Len(10) Dft(MQMCNN)
             Qual       Type(*NAME) Len(10) Dft(QTEMP) +
                          Prompt('Library')
