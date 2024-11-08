/*  ===============================================================  */
/*  = Command....... RtvMsgKey                                    =  */
/*  = CPP........... RtvMsgKey CLP                                =  */
/*  = Description... Retrieve Message key                         =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( RtvMsgKey )                                =  */
/*  =             Pgm( RtvMsgKey  )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  =             Allow( (*BPGM) (*IPGM ) )                       =  */
/*  ===============================================================  */
/*  = Date  : 2024/11/06                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             CMD        Prompt( 'Retrieve Message Key' )

             Parm       Kwd( MSGKEY )                                +
                        Type( *Char )                                +
                        Len(  4 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'Message key               ( 4)' )
