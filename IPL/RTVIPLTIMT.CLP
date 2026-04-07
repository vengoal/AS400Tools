     Pgm

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &STRIPLDAT   *Char     8
     Dcl        &STRIPLTIM   *Char     8
     Dcl        &ENDIPLDAT   *Char     8
     Dcl        &ENDIPLTIM   *Char     8
     Dcl        &IPLSEC      *Dec    ( 5 0 )
     Dcl        &STRPWRDWND  *Char     8
     Dcl        &STRPWRDWNT  *Char     8
     Dcl        &ENDPWRDWND  *Char     8
     Dcl        &ENDPWRDWNT  *Char     8
     Dcl        &PWRDWNSEC   *Dec    ( 5 0 )

     RTVIPLTIM  STRIPLDAT( &STRIPLDAT )          +
                STRIPLTIM( &STRIPLTIM )          +
                ENDIPLDAT( &ENDIPLDAT )          +
                ENDIPLTIM( &ENDIPLTIM )          +
                IPLSEC(    &IPLSEC    )          +
                STRPWRDWND(&STRPWRDWND)          +
                STRPWRDWNT(&STRPWRDWNT)          +
                ENDPWRDWND(&ENDPWRDWND)          +
                ENDPWRDWNT(&ENDPWRDWNT)          +
                PWRDWNSEC( &PWRDWNSEC )
     DMPCLPGM

     ENDPGM
