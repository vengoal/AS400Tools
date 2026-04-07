/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : RTVDTAARAD                                         */
/*  Description : Retrieve Data Area Description                     */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : November 12, 2024                                  */
/*                                                                   */
/*  Program function:  Retrieve Data Area Description.               */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm    Pgm( RTVDTAARAD )                                  */
/*                SrcFile( QCLSRC )                                  */
/*                SrcMbr( *PGM )                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &Dtaara_q              +
                &RtnLib                +
                &Type                  +
                &Length                +
                &DecPos                +
                &Text                  +
                &Owner                 +
              )

/*-- Parameters:  ---------------------------------------------------*/
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

     Dcl        &RcvVar      *Char  2048
     Dcl        &RcvVarLen   *Char     4
     Dcl        &Start       *Char     4
     Dcl        &LenOfData   *Char     4
     Dcl        &Data        *Char  2000
     Dcl        &ErrCod      *Char     4    X'00000000'

     Dcl        &DecVal      *Dec   ( 15 5 )

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error

     ChkObj     Obj( &DtaaraLib/&Dtaara )             +
                ObjType( *Dtaara )
     RtvObjd    Obj( &DtaaraLib/&Dtaara )             +
                ObjType( *Dtaara )                    +
                RtnLib( &RtnLib )

     ChgVar   ( %SST( &Dtaara_q 11 10) ) &DtaaraLib
     ChgVar     %Bin( &RcvVarLen )     2048
     ChgVar     %Bin( &Start )           -1
     ChgVar     %Bin( &LenOfData )     2000
     ChgVar     %Bin( &ErrCod )           0

     Call       QWCRDTAA   ( &RcvVar             +
                             &RcvVarLen          +
                             &Dtaara_q           +
                             &Start              +
                             &LenOfData          +
                             &ErrCod             +
                           )
     ChgVar     &Type        %Sst( &RcvVar  9  10 )
     ChgVar     &RtnLib      %Sst( &RcvVar 19  10 )
     ChgVar     &NbrC        %Sst( &RcvVar 29   4 )
     ChgVar     &Length      %Bin( &NbrC )
     ChgVar     &NbrC        %Sst( &RcvVar 33   4 )
     ChgVar     &DecPos      %Bin( &NbrC )
     ChgVar     &Data        %Sst( &RcvVar 37 &Length)

     RtvObjD    Obj( &RtnLib/&Dtaara )           +
                ObjType( *Dtaara )               +
                Text( &Text )                    +
                Owner( &Owner )
     If       ( &Type *EQ '*DEC' ) Do
     RtvDtaara  Dtaara( &RtnLib/&Dtaara )        +
                RtnVar( &DecVal )
     dmpclpgm
     EndDo

     Return
 Error:
     MovDiagMsg
     MonMsg     MsgID(CPF0000 MCH0000)
     RsnEscMsg
     MonMsg     MsgID(CPF0000 MCH0000)

 EndPgm
