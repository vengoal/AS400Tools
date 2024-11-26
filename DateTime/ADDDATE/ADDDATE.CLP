/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : AddDate                                            */
/*  Description : Add Date                                           */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : November 26, 2024                                  */
/*                                                                   */
/*  Program function:  AddDate    command processing program         */
/*                     Allows  a number  of  days  to be  added  or  */
/*                     subtracted from  any date.                    */
/*                                                                   */
/*  Program summary                                                  */
/*  ---------------                                                  */
/*                                                                   */
/*  Work management APIs:                                            */
/*    CEEDAYS     Convert Date to Lilian Format                      */
/*                                                                   */
/*    CEEDATE     Formats a number representing a Lilian date        */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtBndCL   Pgm( AddDate )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &Days                  +
                &NewDat                +
                &FrmDat                +
                &FrmDatFmt             +
                &NewDatFmt             +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &Days        *Dec   ( 10 0 )
     Dcl        &NewDat      *Char    10
     Dcl        &FrmDat      *Char    10
     Dcl        &FrmDatFmt   *Char     8
     Dcl        &NewDatFmt   *Char     8
     Dcl        &TmpDat      *Char    10
     Dcl        &TmpDatFmt   *Char     8         'YYYYMMDD'
     Dcl        &Lilian      *Char     4
     Dcl        &LilianDec   *Dec   ( 10 0 )
     Dcl        &QDateTime   *Char    20
     Dcl        &QDatFmt     *Char     3
     Dcl        &DateLenC    *Char     2
     Dcl        &DateLen     *Dec    ( 2 0 )
     Dcl        &RtnLen      *Dec    ( 2 0 )
     Dcl        &RtnLenC     *Char     2

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg      CPF0000      *N        GoTo Error

     Chgvar      &DateLenC    %sst(&FrmDat 1 2)
     Chgvar      &DateLen     %bin(&DateLenC)
     ChgVar      &FrmDat      %SST( &FrmDat 3 &DateLen )

     If        ( &FrmDat      *EQ '*SYSVAL' ) Do
     RtvSysVal  QDateTime        &QDateTime
     RtvSysVal  QDatFmt          &QDatFmt
     ChgVar     &FrmDat          %SST( &QDateTime 1 8 )
     ChgVar     &FrmDatFmt       '*YYMD'
     EndDo

     If        ( &FrmDat      *EQ '*JOB' )    Do
     RtvJobA     DatFmt(&FrmDatFmt)                                   +
                 Date( &FrmDat )
     EndDo

     CvtDate     Date( &FrmDat )                                      +
                 ToVar( &TmpDat )                                     +
                 FromFmt( &FrmDatFmt )                                +
                 ToFmt( *YYMD )

     ChgVar      &TmpDatFmt   'YYYYMMDD'
     CallPrc     CEEDAYS    ( &TmpDat                                 +
                              &TmpDatFmt                              +
                              &Lilian                                 +
                              *Omit                                   +
                            )
     ChgVar      &LilianDec   %Bin( &Lilian )
     ChgVar      &LilianDec ( &LilianDec + &Days )
     ChgVar      %Bin( &Lilian )  &LilianDec

     CallPrc     CEEDATE    ( &Lilian                                 +
                              &TmpDatFmt                              +
                              &TmpDat                                 +
                              *Omit                                   +
                            )

     CvtDate     Date( &TmpDat )                                      +
                 ToVar( &NewDat )                                     +
                 FromFmt( *YYMD )                                     +
                 ToFmt( &NewDatFmt )
     Select
       when    ( &NewDatFmt   *EQ  '*MDY' *OR                         +
                 &NewDatFmt   *EQ  '*DMY' *OR                         +
                 &NewDatFmt   *EQ  '*YMD'  )                          +
         Chgvar  %bin(&RtnLenC)  6
       when    ( &NewDatFmt   *EQ  '*MDYY' *OR                        +
                 &NewDatFmt   *EQ  '*DMYY' *OR                        +
                 &NewDatFmt   *EQ  '*YYMD' )                          +
         Chgvar  %bin(&RtnLenC)  8
       when    ( &NewDatFmt   *EQ  '*CYMD' )                          +
         Chgvar  %bin(&RtnLenC)  7
       when    ( &NewDatFmt   *EQ  '*JUL'  )                          +
         Chgvar  %bin(&RtnLenC)  5
       when    ( &NewDatFmt   *EQ  '*LONGJUL' )                       +
         Chgvar  %bin(&RtnLenC)  7
     EndSelect

     Chgvar      &NewDat    ( &RtnLenC *Cat &NewDat )

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
