Pgm

   Dcl        &UsrPrf        *Char    10
   Dcl        &TKEY0100      *Char   512

   Chgvar     &UsrPrf        'TOTPUSR01'
   Chgvar     &UsrPrf        'A123USR01'
   Call       RTVTOTPKEY   ( &UsrPrf        +
                             &TKEY0100      +
                           )

   Call       SETTOTPKEY   (                +
                             &TKEY0100      +
                           )

EndPgm
