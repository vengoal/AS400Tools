/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : EDITCTEST                                          */
/*  Description : Edit number with edit code in CL TEST              */
/*  Author  . . : Vengoa Chang                                       */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : December  2, 2024                                  */
/*                                                                   */
/*  Program function:                                                */
/*                                                                   */
/*                                                                   */
/*  Programmer's notes:                                              */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( EDITCTEST )                                    */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm                                                             +

/*-- Global variables:  ---------------------------------------------*/
     Dcl        &NbrIn            *Dec   ( 15 5 )
     Dcl        &Digits           *Dec   ( 15 0 )
     Dcl        &Decimal          *Dec   (  5 0 )
     Dcl        &EditCode         *Char     1
     Dcl        &NbrEdited        *Char    50

     Chgvar     &NbrIn       12345678.123
     Chgvar     &Digits      15
     Chgvar     &Decimal     3
     Chgvar     &EditCode    '1'

     EDITC      NBRIN(&NBRIN)  +
                DECIMAL(&DECIMAL) EDITCODE(&EDITCODE) +
                RTNEDTVAL(&NBREDITED)

     SNDPGMMSG  MSG( %CHAR(&NBRIN) *BCAT 'with edit code'  *BCAT  +
                     &EDITCODE *BCAT  'result is' *Bcat           +
                     %TRIM( &NbrEdited ) )

     EDITC      NBRIN(&NBRIN) DECIMAL(4) +
                EDITCODE(&EDITCODE) RTNEDTVAL(&NBREDITED)

     SNDPGMMSG  MSG( %CHAR(&NBRIN) *BCAT 'with edit code'  *BCAT  +
                     &EDITCODE *BCAT  'result is' *Bcat           +
                     %TRIM( &NbrEdited ) )

     EDITC      NBRIN(&NBRIN) DECIMAL(5) +
                EDITCODE(&EDITCODE) RTNEDTVAL(&NBREDITED)

     SNDPGMMSG  MSG( %CHAR(&NBRIN) *BCAT 'with edit code'  *BCAT  +
                     &EDITCODE *BCAT  'result is' *Bcat           +
                     %TRIM( &NbrEdited ) )

     EDITC      NBRIN(&NBRIN) DECIMAL(2) +
                EDITCODE(&EDITCODE) RTNEDTVAL(&NBREDITED)

     SNDPGMMSG  MSG( %CHAR(&NBRIN) *BCAT 'with edit code'  *BCAT  +
                     &EDITCODE *BCAT  'result is' *Bcat           +
                     %TRIM( &NbrEdited ) )

     EDITC      NBRIN(&NBRIN) DECIMAL(0) +
                EDITCODE( 4 ) RTNEDTVAL(&NBREDITED)

     SNDPGMMSG  MSG( %CHAR(&NBRIN) *BCAT 'with edit code'  *BCAT  +
                     &EDITCODE *BCAT  'result is' *Bcat           +
                     %TRIM( &NbrEdited ) )
 Return:
     Return

/*-- Error processor ------------------------------------------------*/
 Error:
     Call      QMHMOVPM    ( '    '                             +
                             '*DIAG'                            +
                             x'00000001'                        +
                             '*PGMBDY   '                       +
                             x'00000001'                        +
                             x'0000000800000000'                +
                           )

     Call      QMHRSNEM    ( '    '                             +
                             x'0000000800000000'                +
                           )


 EndPgm:
     EndPgm
