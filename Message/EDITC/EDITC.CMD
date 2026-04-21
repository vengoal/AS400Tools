/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Command . . : EDITC                                              */
/*  Description : Edit Code                                          */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : December  2, 2024                                  */
/*                                                                   */
/*                                                                   */
/*  Command processing API:                                          */
/*    QECCVTEC    Convert Edit Code                                  */
/*                                                                   */
/*    QECEDT      Edit (QECEDT) API                                  */
/*                                                                   */
/*  Programmer's notes:                                              */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( EDITC   )                                          */
/*           Pgm( EDITC    )                                         */
/*           SrcMbr( EDITC   )                                       */
/*           Allow( *IPGM *BPGM )                                    */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Edit Code' )

             Parm       Kwd( NbrIn )                                 +
                        Type( *DEC )                                 +
                        Len( 15 5 )                                  +
                        Min( 1 )                                     +
                        Prompt( 'Number to be converted' )

             Parm       Kwd( Digits )                                +
                        Type( *Int4 )                                +
                        Constant( 15 )

             Parm       Kwd( Decimal )                               +
                        Type( *Int4 )                                +
                        Min( 1 )                                     +
                        Range( 0  5 )                                +
                        Prompt( 'Decimal position' )

             Parm       Kwd( EditCode )                              +
                        Type( *Char )                                +
                        Len( 1 )                                     +
                        Rstd( *YES )                                 +
                        Dft( 1 )                                     +
                        Spcval(                                      +
                          ( A )                                      +
                          ( B )                                      +
                          ( C )                                      +
                          ( D )                                      +
                          ( J )                                      +
                          ( K )                                      +
                          ( L )                                      +
                          ( M )                                      +
                          ( N )                                      +
                          ( O )                                      +
                          ( P )                                      +
                          ( Q )                                      +
                          ( 1 )                                      +
                          ( 2 )                                      +
                          ( 2 )                                      +
                          ( 4 ))                                     +
                        Prompt( 'Edit code' )

             Parm       Kwd( RtnEdtVal )                             +
                        Type( *Char )                                +
                        Len( 50 )                                    +
                        RTNVAL( *YES )                               +
                        Prompt( 'CL var for RtnEdtVal    (50)' )

