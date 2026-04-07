     Pgm

     Dcl        &Dtaara_q    *Char    20
     Dcl        &Dtaara      *Char  Stg(*DEFINED) +
                             Len(10) DefVar( &Dtaara_q    1 )
     Dcl        &DtaaraLib   *Char  Stg(*DEFINED) +
                              Len(10) DefVar( &Dtaara_q  11 )
     Dcl        &RtnLib      *Char    10
     Dcl        &Type        *Char    10
     Dcl        &Length      *Dec    ( 5 0 )
     Dcl        &DecPos      *Dec    ( 2 0 )
     Dcl        &NbrC        *Char     4
     Dcl        &Text        *Char    50
     Dcl        &Owner       *Char    10

     DLTDTAARA  DTAARA(QTEMP/CHAR)
     MONMSG     CPF0000
     CRTDTAARA  DTAARA(QTEMP/CHAR) TYPE(*CHAR) LEN(200)
     CHGDTAARA  DTAARA(QTEMP/CHAR (1 10)) VALUE('1234567890')
     CHGDTAARA  DTAARA(QTEMP/CHAR (191 10)) VALUE('1234567890')
     RtvDtaAraD Dtaara(QTEMP/CHAR     )   +
                RtnLib(&RtnLib   )   +
                Type(&Type     )     +
                Length(&Length   )   +
                DecPos(&DecPos   )   +
                Text(&Text     )     +
                Owner(&Owner    )
     DMPCLPGM

     DLTDTAARA  DTAARA(QTEMP/NBR10)
     MONMSG     CPF0000
     CRTDTAARA  DTAARA(QTEMP/NBR10) TYPE(*DEC ) LEN(10 0)
     CHGDTAARA  DTAARA(QTEMP/NBR10) VALUE(1234567890)
     RtvDtaAraD Dtaara(QTEMP/NBR10)   +
                RtnLib(&RtnLib   )   +
                Type(&Type     )     +
                Length(&Length   )   +
                DecPos(&DecPos   )   +
                Text(&Text     )     +
                Owner(&Owner    )
     DMPCLPGM

     DLTDTAARA  DTAARA(QTEMP/NBRDEC155)
     MONMSG     CPF0000
     CRTDTAARA  DTAARA(QTEMP/NBRDEC155) TYPE(*DEC ) LEN(15 5)
     CHGDTAARA  DTAARA(QTEMP/NBRDEC155) VALUE(1234567890.12345)
     RtvDtaAraD Dtaara(QTEMP/NBRDEC155)   +
                RtnLib(&RtnLib   )   +
                Type(&Type     )     +
                Length(&Length   )   +
                DecPos(&DecPos   )   +
                Text(&Text     )     +
                Owner(&Owner    )
     DMPCLPGM


ENDPGM
