/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Command . . : MOVJOBQ                                            */
/*  Description : Move jobs in Job Queue                             */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : November 26, 2024                                  */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( xxx/MOVJOBQ )                                      */
/*           Pgm( xxx/MOVJOBQ  )                                     */
/*           SrcMbr( MOVJOBQ )                                       */
/*                                                                   */
/*-------------------------------------------------------------------*/

 MOVJOBQ:    Cmd        Prompt('Move jobs in Job Queue')

             Parm       Kwd( FROMJOBQ )                              +
                        Type( JOBQ )                                 +
                        PROMPT( 'From Job  queue' )

             Parm       Kwd( TOJOBQ )                                +
                        Type( JOBQ )                                 +
                        Prompt( 'To Job queue' )

             Parm       Kwd( JOB )                                   +
                        Type( *NAME )                                +
                        Dft( *ALL )                                  +
                        SpcVal( *ALL )                               +
                        Prompt( 'Job name' )

             Parm       Kwd( STATUS )                                +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        Rstd( *YES )                                 +
                        Dft( *ALL )                                  +
                        SpcVal( *ALL HLD RLS SCD )                   +
                        Prompt( 'Job on Jobq status' )

             Parm       Kwd( ACTION )                                +
                        Type( *CHAR )                                +
                        Len(  4 )                                    +
                        Rstd( *YES )                                 +
                        Dft( *MSG  )                                 +
                        SpcVal( *MOV *MSG )                          +
                        Prompt( 'Action Move or SndPgmMsg' )

 JOBQ:       Qual       Type( *NAME )                                +
                        Len( 10 )
             Qual       Type( *NAME )                                +
                        Len( 10 )                                    +
                        DFT( *LIBL )                                 +
                        SpcVal( (*CURLIB) (*LIBL) )                  +
                        Prompt( 'Library' )
