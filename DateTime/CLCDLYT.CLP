
/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &StrTime     *Char     6       /* 24 hour HHMMSS */
     Dcl        &EndTime     *Char     6       /* 24 hour HHMMSS */
     Dcl        &Itv         *Char     6       /* HHMMSS */
     Dcl        &Dly         *Dec   (  5 0 )
     Dcl        &RsmTime     *Char     6       /* 24 hour HHMMSS */
     Dcl        &Time        *Char     6       /* 24 hour HHMMSS */

     Dcl        &StrDatTim   *Char    12
     Dcl        &EndDatTim   *Char    12
     Dcl        &CurDatTim   *Char    12
     Dcl        &PicStr      *Char    12         'YYMMDDHHMISS'
     Dcl        &Cur_Float   *Char     8
     Dcl        &Str_Float   *Char     8
     Dcl        &End_Float   *Char     8
     Dcl        &StrSec_Dec  *Dec   ( 15 0 )
     Dcl        &EndSec_Dec  *Dec   ( 15 0 )
     Dcl        &CurSec_Dec  *Dec   ( 15 0 )
     Dcl        &TgtSec_Dec  *Dec   ( 15 0 )
     Dcl        &DiffSec     *Dec   ( 15 0 )
     Dcl        &ItvSecs     *Dec   ( 15 0 )
     Dcl        &DiffSecC    *Char    15
     Dcl        &Float_Dfn   *Char     7         X'01000800000000'
     Dcl        &Dec_Dfn     *Char     7         X'03000F00000000'
     Dcl        &MsgText     *Char   256
     Dcl        &HH          *Dec    ( 5 0 )
     Dcl        &MM          *Dec    ( 5 0 )
     Dcl        &SS          *Dec    ( 5 0 )
     Dcl        &HHSecs      *Dec    ( 5 0 )
     Dcl        &MMSecs      *Dec    ( 5 0 )
     Dcl        &SS          *Dec    ( 5 0 )
     Dcl        &DATETIME    *Char    20

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg      CPF0000      *N        GoTo Error

    /*       CLCDLY     DLY(&DLY) RSMTIME(&RSMTIME)  */
    /*       dmpclpgm                                */
    /*       CLCDLY     STRTIME(081000) ENDTIME(170000) DLY(&DLY) +  */
    /*                    RSMTIME(&RSMTIME)                          */
    /*       dmpclpgm                                                */

loop:
             CLCDLY     STRTIME(081000) ENDTIME(122000) DLY(&DLY) +
                          RSMTIME(&RSMTIME)
             dmpclpgm
             If       ( &Dly >= 0 ) Do
             SndPgmMsg   MsgId(CPF9898)                                 +
                         MsgF(QCPFMSG)                                  +
                         MsgDTA('RSMTIME:' *Bcat                        +
                             &RSMTIME  )                                +
                         ToPgmq( *Ext )                                 +
                         MsgType( *INFO )
             If       ( &Dly > 0 )                                      +
               DlyJob     Dly( &Dly )

             /* run your code here */
             /* run your code here */
             /* run your code here */

             If       ( &Dly = 0 )                                      +
               DlyJob     Dly( 1 )

             Goto       Loop
             EndDo

             SndPgmMsg   MsgId(CPF9898)                                 +
                         MsgF(QCPFMSG)                                  +
                         MsgDTA('RSMTIME:' *Bcat                        +
                             &RSMTIME  )                                +
                         ToPgmq( *Ext )                                 +
                         MsgType( *INFO )

 Return:
     Return

/*-- Error handling:  -----------------------------------------------*/
 Error:
     Call      QMHMOVPM    ( '    '                                  +
                             '*DIAG'                                 +
                             x'00000001'                             +
                             '*PGMBDY'                               +
                             x'00000001'                             +
                             x'0000000800000000'                     +
                           )

     Call      QMHRSNEM    ( '    '                                  +
                             x'0000000800000000'                     +
                           )

 EndPgm:
     EndPgm

