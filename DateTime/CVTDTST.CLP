PGM

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &Dts         *Char     8
     Dcl        &Dts2        *Char     8
     Dcl        &RtnDate     *Char     8
     Dcl        &RtnTime     *Char     6
     Dcl        &RtnMillSec  *Char     3
     Dcl        &RtnDate2    *Char     8
     Dcl        &RtnTime2    *Char     6
     Dcl        &RtnMillSe2  *Char     3
     Dcl        &RtnDts      *Char     8
     Dcl        &RtnDts2     *Char     8

             callprc    'mattod' parm(&DTS)

             CVTDTS     DTS(&DTS) RTNDATE(&RTNDATE) +
                          RTNTIME(&RTNTIME) RTNMILLSEC(&RTNMILLSEC)
             CVTTODTS   DATE(&RTNDATE) TIME(&RTNTIME) +
                          MILLSEC(&RTNMILLSEC) DTS(&RTNDTS)

             CVTDTS     DTS(&RTNDTS) RTNDATE(&RTNDATE2) +
                          RTNTIME(&RTNTIME2) RTNMILLSEC(&RTNMILLSE2)
             CVTTODTS   DATE(&RTNDATE2) TIME(&RTNTIME2) +
                          MILLSEC(&RTNMILLSE2) DTS(&RTNDTS2)

             DMPCLPGM
             
             DSPSPLF    FILE(QPPGMDMP) SPLNBR(*LAST)

ENDPGM
