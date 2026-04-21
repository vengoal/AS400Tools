/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : RMVMSGKEY                                          */
/*  Description : Remove message by message key                      */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : November  8, 2024                                  */
/*                                                                   */
/*  Program function:  RMVMSGKEY  command processing program         */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( RMVMSGKEY )                                    */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &LowKey )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &LowKey      *Char     4
     Dcl        &HiKey       *Char     4
     Dcl        &MsgKey      *Char     4
     Dcl        &Msg         *Char   256
     Dcl        &MsgID       *Char     7

/*-- Determine end message key:  ------------------------------------*/
     SndPgmMsg  Msg( TESTEND )                            +
                ToPgmq( *Prv  )                           +
                KeyVar( &HiKey )

     RmvMsg     MsgKey( &HiKey )

/*-----------------------------------------------------------------*/
/*-- Loop to receive messages with RCVMSG command                  */
/*-----------------------------------------------------------------*/
     ChgVar     %Bin( &MsgKey 1 4 )  ( %Bin( &LowKey 1 4 ) + 1 )

Loop:
     RmvMsg     MsgKey( &MsgKey )
/* Handle MSGKEY not found                                         */
     Monmsg     CPF2410 Exec( Do )
/*-- Remove unwanted exception                                     */
     RcvMsg     MsgType( *EXCP )      +
                RMV(*YES)
     Goto       Skip
     EndDo

Skip:
     ChgVar     %Bin( &MSGKEY 1 4 )  ( %Bin( &MsgKey 1 4 ) + 1 )
     If ( &MsgKey *LT &HiKey ) GOTO LOOP

     Return

EndPgm
