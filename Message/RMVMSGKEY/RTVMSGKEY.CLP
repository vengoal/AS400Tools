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
