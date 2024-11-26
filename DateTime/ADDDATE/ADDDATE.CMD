/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Command . . : ADDDATE                                            */
/*  Description : Add Date                                           */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : November 26, 2024                                  */
/*                                                                   */
/*                                                                   */
/*  Command processing API:                                          */
/*    CEEDAYS     Convert Date to Lilian Format                      */
/*                                                                   */
/*    CEEDATE     Formats a number representing a Lilian date        */
/*                                                                   */
/*  Programmer's notes:                                              */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( ADDDATE )                                          */
/*           Pgm( ADDDATE  )                                         */
/*           SrcMbr( ADDDATE )                                       */
/*           Allow( *IPGM *BPGM )                                    */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Add Date' )

             Parm       Kwd( DAYS )                                  +
                        Type( *DEC )                                 +
                        Len( 10 0 )                                  +
                        Min( 1 )                                     +
                        Prompt( 'Number of days to add or sub' )
                                                                     +
             Parm       Kwd( NEWDAT )                                +
                        Type( *CHAR )                                +
                        Len(10 )                                     +
                        Rtnval( *YES )                               +
                        Min( 1 )                                     +
                        Vary( *YES )                                 +
                        Prompt('CL var for new date')

             Parm       Kwd( FRMDAT )                                +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        Dft( *SYSVAL )                               +
                        Spcval( (*SYSVAL) (*JOB) )                   +
                        Vary( *YES )                                 +
                        Expr( *YES )                                 +
                        Prompt( 'From Date to be used as a base' )

             Parm       Kwd( FRMDATFMT )                             +
                        Type( *Char )                                +
                        Len( 8 )                                     +
                        Rstd( *YES )                                 +
                        Dft( *JOB )                                  +
                        Spcval(                                      +
                          ( *SYSVAL )                                +
                          ( *MDY )                                   +
                          ( *DMY )                                   +
                          ( *YMD )                                   +
                          ( *JUL )                                   +
                          ( *JOB )                                   +
                          ( *MDYY )                                  +
                          ( *DMYY )                                  +
                          ( *YYMD )                                  +
                          ( *CYMD  )                                 +
                          ( *LONGJUL  ))                             +
                        Expr( *YES )                                 +
                        Prompt( 'From date format' )

             Parm       Kwd( NEWDATFMT )                             +
                        Type( *Char )                                +
                        Rstd( *YES )                                 +
                        Dft( *JOB )                                  +
                        Spcval(                                      +
                          ( *SYSVAL )                                +
                          ( *MDY )                                   +
                          ( *DMY )                                   +
                          ( *YMD )                                   +
                          ( *JUL )                                   +
                          ( *JOB )                                   +
                          ( *MDYY )                                  +
                          ( *DMYY )                                  +
                          ( *YYMD )                                  +
                          ( *CYMD  )                                 +
                          ( *LONGJUL  ))                             +
                        Expr( *YES )                                 +
                        Prompt( 'New date format' )
