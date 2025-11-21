     Pgm      ( &TKEY0100 )

/*-- PARAMETERS:  ---------------------------------------------------*/
     Dcl        &TKEY0100     *Char   512   /* FROM QSYRTVK RCVVAR */
     Dcl        &KeyFmt       *Char     8   'TKEY0100'
     Dcl        &ErrCode      *Char     8   X'0000000000000000'

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg    CPF0000       *N        GoTo Error

     Call      QSYSETK     ( &TKEY0100    +
                             &KeyFmt      +
                             &ErrCode     +
                           )

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
