/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RTVMQMQH )                                         */
/*           Pgm( RTVMQMQHR )                                        */
/*           SrcMbr( RTVMQMQH )                                      */
/*           Allow( *IPGM *BPGM )                                    */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Retrieve MQM Queue Handle')

          Parm     Kwd( QName )                          +
                   Type( *CHAR )                         +
                   Len( 48 )                             +
                   Min( 1 )                              +
                   Prompt( 'Queue name' )

          Parm     Kwd( MqmName )                        +
                   Type( *CHAR )                         +
                   Len( 48 )                             +
                   Min( 1 )                              +
                   Prompt( 'Message Queue Manager name' )

          Parm     Kwd( JobCnt )                         +
                   Type( *Dec  )                         +
                   Len( 5 0 )                            +
                   RtnVal( *Yes )                        +
                   Prompt('Queue handles job count')

          Parm     Kwd( JobList )                        +
                   Type( *Char )                         +
                   Len( 1400 )                           +
                   RtnVal( *Yes )                        +
                   Prompt( 'Queue handles job list' )

          Parm     Kwd( MQERROR )                        +
                   Type( *LGL  )                         +
                   RtnVal( *Yes )                        +
                   Prompt( 'MQ API error' )

          Parm     Kwd( CC )                             +
                   Type( *Dec )                          +
                   Len( 10 0 )                           +
                   RtnVal( *Yes )                        +
                   Prompt( 'Completetion code')

          Parm     Kwd( RC )                             +
                   Type( *Dec )                          +
                   Len( 10 0 )                           +
                   RtnVal( *Yes )                        +
                   Prompt( 'Reason code')

          Parm     Kwd( MQINFO )                         +
                   Type( *Char )                         +
                   Len( 256 )                            +
                   RtnVal( *Yes )                        +
                   Prompt( 'MQ error information')
