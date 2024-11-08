     Pgm

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &LowKey      *Char     4
     Dcl        &HiKey       *Char     4
     Dcl        &MsgKey      *Char     4
     Dcl        &Msg         *Char   256

     RtvMsgKey  MsgKey( &LowKey )

     call       RtvJobqAt

     RmvMsgKey  MsgKey( &LowKey )

     Return

EndPgm
