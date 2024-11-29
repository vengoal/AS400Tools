/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Command . . : RTVIPLTIM                                          */
/*  Description : Retrieve IPL Time                                  */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : November 26, 2024                                  */
/*                                                                   */
/*                                                                   */
/*  Command processing API:                                          */
/*                                                                   */
/*  Programmer's notes:                                              */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RTVIPLTIM )                                        */
/*           Pgm( RTVIPLTIM )                                        */
/*           SrcMbr( RTVIPLTIM )                                     */
/*           Allow( *IPGM *BPGM )                                    */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Retrieve IPL Time')

             Parm       Kwd( STRIPLDAT )                             +
                        Type( *Char )                                +
                        Len(  8 )                                    +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'Date of IPL started' )
                                                                     +
             Parm       Kwd( STRIPLTIM )                             +
                        Type( *CHAR )                                +
                        Len( 8 )                                     +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'Time of IPL started' )

             Parm       Kwd( ENDIPLDAT )                             +
                        Type( *Char )                                +
                        Len(  8 )                                    +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'Date of IPL ended' )
                                                                     +
             Parm       Kwd( ENDIPLTIM )                             +
                        Type( *CHAR )                                +
                        Len( 8 )                                     +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'Time of IPL ended' )

             Parm       Kwd( IPLSEC )                                +
                        Type( *Dec  )                                +
                        Len( 5 0 )                                   +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'Number of seconds for IPL' )

             Parm       Kwd( STRPWRDWND )                            +
                        Type( *Char )                                +
                        Len(  8 )                                    +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'Date of power down started' )
                                                                     +
             Parm       Kwd( STRPWRDWNT )                            +
                        Type( *CHAR )                                +
                        Len( 6 )                                     +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'Time of power down started' )

             Parm       Kwd( ENDPWRDWND )                            +
                        Type( *Char )                                +
                        Len(  8 )                                    +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'Date of power down ended' )
                                                                     +
             Parm       Kwd( ENDPWRDWNT )                            +
                        Type( *CHAR )                                +
                        Len( 8 )                                     +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'Time of power down ended' )

             Parm       Kwd( PWRDWNSEC )                             +
                        Type( *Dec  )                                +
                        Len( 5 0 )                                   +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'Number of seconds for PWRDWN' )

