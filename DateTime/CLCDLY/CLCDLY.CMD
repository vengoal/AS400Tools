/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Command . . : CLCDLY                                             */
/*  Description : Calculate Delay                                    */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : October  23, 2025                                  */
/*                                                                   */
/*                                                                   */
/*  Command processing API:                                          */
/*                                                                   */
/*  Programmer's notes:                                              */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( CLCDLY  )                                          */
/*           Pgm( CLCDLY   )                                         */
/*           SrcMbr( CLCDLY  )                                       */
/*           Allow( *IPGM *BPGM )                                    */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Calculate Delay')

             Parm       Kwd( STRTIME )                               +
                        Type( *CHAR )                                +
                        Len( 6 )                                     +
                        Dft( 000000 )                                +
                        Range(  000000   235959  )                   +
                        Prompt('Start time')

             Parm       Kwd( ENDTIME )                               +
                        Type( *CHAR )                                +
                        Len( 6 )                                     +
                        Dft(  235959  )                              +
                        Range(  000000   235959  )                   +
                        Prompt('End   time')

             Parm       Kwd( ITV )                                   +
                        Type( *CHAR )                                +
                        Len( 6 )                                     +
                        Dft(  010000  )                              +
                        Prompt( 'Interval HHMMSS' )

             Parm       Kwd( DLY     )                               +
                        Type( *Dec )                                 +
                        Len( 5 0 )                                   +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt('CL var for DLY         (5 0)')

             Parm       Kwd( RSMTIME )                               +
                        Type( *Char )                                +
                        Len( 6 )                                     +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Prompt('CL var for RSMTIME       (6)')

