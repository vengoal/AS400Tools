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
                        Prompt( 'CL var for STRIPLDAT    ( 8)' )
                                                                     +
             Parm       Kwd( STRIPLTIM )                             +
                        Type( *CHAR )                                +
                        Len( 8 )                                     +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'CL var for STRIPLTIM    ( 8)' )

             Parm       Kwd( ENDIPLDAT )                             +
                        Type( *Char )                                +
                        Len(  8 )                                    +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'CL var for ENDIPLDAT    ( 8)' )
                                                                     +
             Parm       Kwd( ENDIPLTIM )                             +
                        Type( *CHAR )                                +
                        Len( 8 )                                     +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'CL var for ENDIPLTIM    ( 8)' )

             Parm       Kwd( IPLSEC )                                +
                        Type( *Dec  )                                +
                        Len( 5 0 )                                   +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'CL var for IPLSEC      (5 0)' )

             Parm       Kwd( STRPWRDWND )                            +
                        Type( *Char )                                +
                        Len(  8 )                                    +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'CL var for STRPWRDWND   ( 8)' )
                                                                     +
             Parm       Kwd( STRPWRDWNT )                            +
                        Type( *CHAR )                                +
                        Len( 8 )                                     +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'CL var for STRPWRDWNT   ( 8)' )

             Parm       Kwd( ENDPWRDWND )                            +
                        Type( *Char )                                +
                        Len(  8 )                                    +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'CL var for ENDPWRDWND   ( 8)' )
                                                                     +
             Parm       Kwd( ENDPWRDWNT )                            +
                        Type( *CHAR )                                +
                        Len( 8 )                                     +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'CL var for ENDPWRDWNT   ( 8)' )

             Parm       Kwd( PWRDWNSEC )                             +
                        Type( *Dec  )                                +
                        Len( 5 0 )                                   +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt( 'CL var for PWRDWNSEC   (5 0)' )

