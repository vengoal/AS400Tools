     Pgm      (                      +
                &UsrPrf              +
                &TKEY0100            +
              )

/*-- PARAMETERS:  ---------------------------------------------------*/
     Dcl        &UsrPrf       *Char    10
     Dcl        &TKEY0100     *Char   512
     Dcl        &KeyFmt       *Char     8      'TKEY0100'
     Dcl        &RcvVar       *Char   512
     Dcl        &RcvVarLen    *Int
     Dcl        &BytRtn       *Int    STG(*DEFINED) +
                                      DEFVAR(&RCVVAR 1)
     Dcl        &BytAvl       *Int    STG(*DEFINED) +
                                      DEFVAR(&RCVVAR 5)
     Dcl        &User         *Char   LEN( 10 )  +
                                      STG(*DEFINED) +
                                      DEFVAR(&RCVVAR  9)
     Dcl        &KeyData      *Char   LEN( 400 ) +
                                      STG(*DEFINED) +
                                      DEFVAR(&RCVVAR 19)
     Dcl        &ErrCode      *Char     8  X'0000000000000000'

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000       *N        GoTo Error

     ChgVar     &RcvVarLen    512

     Call       QSYRTVK     ( &RcvVar      +
                              &RcvVarLen   +
                              &KeyFmt      +
                              &UsrPrf      +
                              &ErrCode     +
                            )

     ChgVar     &TKEY0100     &RCVVAR

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
