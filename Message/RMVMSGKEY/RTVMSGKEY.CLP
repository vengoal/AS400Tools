/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : RTVMSGKEY                                          */
/*  Description : Retrieve message key                               */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : November  8, 2024                                  */
/*                                                                   */
/*  Program function:  RTVMSGKEY  command processing program         */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( RTVMSGKEY )                                    */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &MsgKey )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &MsgKey      *Char     4
     Dcl        &Msg         *Char   256

/*-- Determine message key:  ----------------------------------------*/
     SndPgmMsg  Msg( TESTSTR )                           +
                ToPgmq( *Prv  )                           +
                KeyVar( &MsgKey )

     RmvMsg     MsgKey( &MsgKey )

     Return

EndPgm
