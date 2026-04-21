/*  ===============================================================  */
/*  = Command....... RmvMsgKey                                    =  */
/*  = CPP........... RmvMsgKey CLP                                =  */
/*  = Description... Remove Message From msgkey                   =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( RmvMsgKey )                                =  */
/*  =             Pgm( RmvMsgKey  )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  =             Allow( (*BPGM) (*IPGM ) )                       =  */
/*  ===============================================================  */
/*  = Date  : 2024/11/06                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             CMD        Prompt( 'Remove Message From MsgKey' )

             Parm       Kwd( MSGKEY )                                +
                        Type( *Char )                                +
                        Len(  4 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'Message key               ( 4)' )
