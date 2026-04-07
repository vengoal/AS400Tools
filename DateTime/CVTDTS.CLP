/*  ===============================================================  */
/*  = Command CVTDTS     CPP                                      =  */
/*  = Program....... CvtDts                                       =  */
/*  = Description... Convert DTS to Date/Time                     =  */
/*  ===============================================================  */
/*  = Date  : 2011/07/28                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */

     Pgm      ( &Dts                   +
                &RtnDate               +
                &RtnTime               +
                &RtnMillsec            +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &Dts         *Char     8
     Dcl        &RtnDate     *Char     8
     Dcl        &RtnTime     *Char     6
     Dcl        &RtnMillSec  *Char     3
     Dcl        &OutDatTim   *Char    20

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error

     Call       QWCCVTDT    ( '*DTS'             +
                              &Dts               +
                              '*YYMD'            +
                              &OutDatTim         +
                              x'00000000'        +
                            )

     ChgVar &RtnDate    %SST(&OutDatTim 1 8)
     MonMsg     MCH3601
     ChgVar &RtnTime    %SST(&OutDatTim 9 6)
     MonMsg     MCH3601
     ChgVar &RtnMillSec %SST(&OutDatTim 15 3)
     MonMsg     MCH3601

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
