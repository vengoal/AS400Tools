/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : EndJobQJob                                         */
/*  Description : End Jobq Job by date CPP                           */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400 ePaper                                       */
/*  Date  . . . : June  26, 2024                                     */
/*                                                                   */
/*  Program function:  End Jobq Job by date                          */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm    Pgm( EndJobQJob )                                  */
/*                SrcFile( QCLSRC )                                  */
/*                SrcMbr( *PGM )                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &JobQ_q &Days &Action )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl     &JobQ_q        *Char     20
     Dcl     &JobQ          *Char     Stg(*DEFINED) Len(10) +
                                      DefVar( &JobQ_q  1 )
     Dcl     &JobQLib       *Char     Stg(*DEFINED) Len(10) +
                                      DefVar( &JobQ_q 11 )
     Dcl     &Days          *UInt
     Dcl     &Action        *Char     10

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000     *N         GoTo Error

     ChkObj  ( &JobQLib/&JobQ )        ObjType(*JobQ)

Call:
     Call       Pgm( EndJqJobR )            +
                Parm( &JobQ_q &Days &Action )

 Return:
     Return

/*-- Error processor ------------------------------------------------*/
Error:
     Call      QMHMOVPM    ( '    '                   +
                             '*DIAG'                  +
                             x'00000001'              +
                             '*PGMBDY   '             +
                             x'00000001'              +
                             x'0000000800000000'      +
                           )

     Call      QMHRSNEM    ( '    '                   +
                             x'0000000800000000'      +
                           )
 EndPgm:
     EndPgm
