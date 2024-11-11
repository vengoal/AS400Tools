     Pgm      ( &QualUsrSpc            +
                &AutoExt               +
                &InitChr               +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &QualUsrSpc       *Char       20
     Dcl        &UsrSpc           *Char  Stg(*DEFINED) +
                                         Len(10) DefVar( &QualUsrSpc  1 )
     Dcl        &UsrSpcLib        *Char  Stg(*DEFINED) +
                                         Len(10) DefVar( &QualUsrSpc 11 )
     Dcl        &AutoExt          *Char        4
     Dcl        &InitChr          *Char        1      X'00'
     Dcl        &RtnLib           *Char       10

     Dcl        &NewAttr          *Char       23
     Dcl        &AttrCount        *Int   Stg(*DEFINED) +
                                         DefVar( &NewAttr 1 )
     Dcl        &AutoExtAtr       *Char  Stg(*DEFINED) +
                                         Len(9) DefVar( &NewAttr 5 )
     Dcl        &AutoExtKey       *Int   Stg(*DEFINED) +
                                         DefVar( &AutoExtAtr 1 )
     Dcl        &AutoExtLen       *Int   Stg(*DEFINED) +
                                         DefVar( &AutoExtAtr 5 )
     Dcl        &AutoExtVal       *Char  Stg(*DEFINED) +
                                         Len(1) DefVar( &AutoExtAtr 9 )

     Dcl        &InitChar         *Char  Stg(*DEFINED) +
                                         Len(9) DefVar( &NewAttr 14)
     Dcl        &InitChrKey       *Int   Stg(*DEFINED) +
                                         DefVar( &InitChar    1 )
     Dcl        &InitChrLen       *Int   Stg(*DEFINED) +
                                         DefVar( &InitChar    5 )
     Dcl        &InitChrVal       *Char  Stg(*DEFINED) +
                                         Len(1) DefVar( &InitChar   9 )

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error

     ChkObj     Obj( &UsrSpcLib/&UsrSpc )             +
                ObjType( *USRSPC )

     ChgVar     &AttrCount        2

     ChgVar     &AutoExtKey         3
     ChgVar     &AutoExtLen         1
     If       ( &AutoExt *EQ '*YES' ) Do
                ChgVar            &AutoExtVal         '1'
     EndDo
     Else     Do
                ChgVar            &AutoExtVal         '0'
     EndDo

     ChgVar     &InitChrKey       2
     ChgVar     &InitChrLen       1
     ChgVar     &InitChrVal       &InitChr

     Call       QUSCUSAT   ( &RtnLib                  +
                             &QualUsrSpc              +
                             &NewAttr                 +
                             X'0000000000000000'      +
                           )

     Return

/*-- Error handling:  -----------------------------------------------*/
 Error:
     MOVDIAGMSG
     Monmsg     CPF0000
     RSNESCMSG
     Monmsg     CPF0000

 EndPgm:
     EndPgm
