/*  ===============================================================  */
/*  = Command....... RtvMqMqAtr                                   =  */
/*  = CPP........... RtvMqMqAtr                                   =  */
/*  = Description... Retrieve Mq Queue  attributes                =  */
/*  =                produced by the MQINQ    API.                =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( RtvMqMqAtr )                               =  */
/*  =             Pgm( RtvMqMqAtr )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  =             Allow( (*BPGM) (*IPGM ) )                       =  */
/*  ===============================================================  */
/*  = Date  : 2025/03/11                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             CMD        Prompt('Retrieve MQ Queue Attributes')
             Parm       Kwd( QName )                                 +
                        Type( *Char )                                +
                        Len( 48 )                                    +
                        Min( 1 )                                     +
                        Prompt( 'Queue name . . . . . . . . . .')

             Parm       Kwd( MQMName )                               +
                        Type( *Char )                                +
                        Len( 48 )                                    +
                        Min( 1 )                                     +
                        Prompt( 'Message Queue Manager name . .')

             Parm       Kwd( InhibitGet )                            +
                        Type( *Int4 )                                +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for InhibitGet (10 0) .' )

             Parm       Kwd( InhibitPut )                            +
                        Type( *Int4 )                                +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for InhibitPut (10 0) .' )

             Parm       Kwd( NbrOfMsg   )                            +
                        Type( *Int4 )                                +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for NbrOfMsg   (10 0) .' )

             Parm       Kwd( OpnInpCnt  )                            +
                        Type( *Int4 )                                +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for OpnInpCnt  (10 0) .' )

             Parm       Kwd( OpnOutCnt  )                            +
                        Type( *Int4 )                                +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for OpnOutCnt  (10 0) .' )

             Parm       Kwd( QType      )                            +
                        Type( *Int4 )                                +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for QType      (10 0) .' )

             Parm       Kwd( QUsage     )                            +
                        Type( *Int4 )                                +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for QUsage     (10 0) .' )

             Parm       Kwd( ErrApi )                                +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for ERRAPI       (10) .' )

             Parm       Kwd( Reason )                                +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for REASON       (10) .' )

