/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CVTDATE                                            */
/*  Description : Convert date                                       */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : November 25, 2024                                  */
/*                                                                   */
/*  Program function:  CVTDATE    command processing program         */
/*                                                                   */
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
/*    CrtClPgm   Pgm( CVTDATE )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &Date                  +
                &ToVar                 +
                &FromFmt               +
                &ToFmt                 +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &Date        *Char    10
     Dcl        &DateCvt     *Char    10
     Dcl        &ToVar       *Char    10
     Dcl        &FromFmt     *int
     Dcl        &ToFmt       *int
     Dcl        &FromFmtC    *Char    10
     Dcl        &ToFmtC      *Char    10
     Dcl        &ToSep       *Char     1
     Dcl        &Lilian      *Char     4
     Dcl        &DateLenC    *Char     2
     Dcl        &DateLen     *Dec    ( 2 0 )
     Dcl        &RtnLen      *Dec    ( 2 0 )
     Dcl        &RtnLenC     *Char     2
     Dcl        &DateFmt     *Char     3
     Dcl        &SysDatFmt   *Char    10
     Dcl        &JDateFmt    *Char     7
     Dcl        &JobDatFmt   *Char    10
     Dcl        &Century     *Char     1
     Dcl        &RtnYear     *Char     2

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error

/*-- Retrieve system date format ------------------------------------*/
     RtvSysVal   QDATFMT     &DateFmt
     Select
       when    ( &DateFmt *EQ 'MDY' )    Do
         Chgvar  &SysDatFmt  'MMDDYY'
         Chgvar  %bin(&RtnLenC)  6
       EndDo
       when    ( &DateFmt *EQ 'DMY' )    Do
         Chgvar  &SysDatFmt  'DDMMYY'
         Chgvar  %bin(&RtnLenC)  6
       EndDo
       when    ( &DateFmt *EQ 'YMD' )    Do
         Chgvar  &SysDatFmt  'YYMMDD'
         Chgvar  %bin(&RtnLenC)  6
       EndDo
       when    ( &DateFmt *EQ 'JUL' )    Do
         Chgvar  &SysDatFmt  'YYDDD'
         Chgvar  %bin(&RtnLenC)  5
       EndDo
     EndSelect

/*-- Retrieve job date format ---------------------------------------*/
     RtvJobA     DatFmt( &JDatefmt )
     Select
       when    ( &JDateFmt *EQ '*SYSVAL' ) Do
         Chgvar  &JobDatFmt  &SysDatFmt
       EndDo
       when    ( &JDateFmt *EQ '*MDY' )    Do
         Chgvar  &JobDatFmt  'MMDDYY'
         Chgvar  %bin(&RtnLenC)  6
       EndDo
       when    ( &JDateFmt *EQ '*DMY' )    Do
         Chgvar  &JobDatFmt  'DDMMYY'
         Chgvar  %bin(&RtnLenC)  6
       EndDo
       when    ( &JDateFmt *EQ '*YMD' )    Do
         Chgvar  &JobDatFmt  'YYMMDD'
         Chgvar  %bin(&RtnLenC)  6
       EndDo
       when    ( &JDateFmt *EQ '*JUL' )    Do
         Chgvar  &JobDatFmt  'YYDDD'
         Chgvar  %bin(&RtnLenC)  5
       EndDo
     EndSelect

     Chgvar      &DateLenC   %sst(&Date 1 2)
     Chgvar      &DateLen    %bin(&DateLenC)
     ChgVar      &DateCvt    %SST( &Date 3 &DateLen )

     Select
       when    ( &FromFmt *EQ  1 )       +
         Chgvar  &FromFmtC   &SysDatFmt
       when    ( &FromFmt *EQ  2 )       +
         Chgvar  &FromFmtC   'MMDDYY'
       when    ( &FromFmt *EQ  3 )       +
         Chgvar  &FromFmtC   'DDMMYY'
       when    ( &FromFmt *EQ  4 )       +
         Chgvar  &FromFmtC   'YYMMDD'
       when    ( &FromFmt *EQ  5 )       +
         Chgvar  &FromFmtC   'YYDDD'
       when    ( &FromFmt *EQ  6 )       +
         Chgvar  &FromFmtC   &JobDatFmt
       when    ( &FromFmt *EQ  7 )       +
         Chgvar  &FromFmtC   'MMDDYYYY'
       when    ( &FromFmt *EQ  8 )       +
         Chgvar  &FromFmtC   'DDMMYYYY'
       when    ( &FromFmt *EQ  9 )       +
         Chgvar  &FromFmtC   'YYYYMMDD'
       when    ( &FromFmt *EQ 10 )       Do       /* *CYMD */
         Chgvar  &FromFmtC   'YYYYMMDD'
         Chgvar  &Century    %Sst( &DateCvt 1 1 )
         Select
           when  ( &Century  *EQ '0' )   +
             Chgvar          &DateCvt   ( '19' *CAT %SST( &DateCvt 2 6 ))
           when  ( &Century  *EQ '1' )   +
             Chgvar          &DateCvt   ( '20' *CAT %SST( &DateCvt 2 6 ))
           when  ( &Century  *EQ '2' )   +
             Chgvar          &DateCvt   ( '21' *CAT %SST( &DateCvt 2 6 ))
           when  ( &Century  *EQ '3' )   +
             Chgvar          &DateCvt   ( '22' *CAT %SST( &DateCvt 2 6 ))
           when  ( &Century  *EQ '4' )   +
             Chgvar          &DateCvt   ( '23' *CAT %SST( &DateCvt 2 6 ))
           when  ( &Century  *EQ '5' )   +
             Chgvar          &DateCvt   ( '24' *CAT %SST( &DateCvt 2 6 ))
           when  ( &Century  *EQ '6' )   +
             Chgvar          &DateCvt   ( '25' *CAT %SST( &DateCvt 2 6 ))
           when  ( &Century  *EQ '7' )   +
             Chgvar          &DateCvt   ( '26' *CAT %SST( &DateCvt 2 6 ))
           when  ( &Century  *EQ '8' )   +
             Chgvar          &DateCvt   ( '27' *CAT %SST( &DateCvt 2 6 ))
           when  ( &Century  *EQ '9' )   +
             Chgvar          &DateCvt   ( '28' *CAT %SST( &DateCvt 2 6 ))
         EndSelect
         EndDo
       when    ( &FromFmt *EQ 15 )       +
         Chgvar  &FromFmtC   'YYYYDDD'
     EndSelect

     Select
       when    ( &ToFmt   *EQ  1 )       Do
         Chgvar  &ToFmtC     &SysDatFmt
         EndDo
       when    ( &ToFmt *EQ  2 )         Do
         Chgvar  &ToFmtC   'MMDDYY'
         Chgvar  %bin(&RtnLenC)  6
         EndDo
       when    ( &ToFmt *EQ  3 )         Do
         Chgvar  &ToFmtC   'DDMMYY'
         Chgvar  %bin(&RtnLenC)  6
         EndDo
       when    ( &ToFmt *EQ  4 )         Do
         Chgvar  &ToFmtC   'YYMMDD'
         Chgvar  %bin(&RtnLenC)  6
         EndDo
       when    ( &ToFmt *EQ  5 )         Do
         Chgvar  &ToFmtC   'YYDDD'
         Chgvar  %bin(&RtnLenC)  5
         EndDo
       when    ( &ToFmt   *EQ  6 )       Do
         Chgvar  &ToFmtC     &JobDatFmt
         EndDo
       when    ( &ToFmt *EQ  7 )         Do
         Chgvar  &ToFmtC   'MMDDYYYY'
         Chgvar  %bin(&RtnLenC)  8
         EndDo
       when    ( &ToFmt *EQ  8 )         Do
         Chgvar  &ToFmtC   'DDMMYYYY'
         Chgvar  %bin(&RtnLenC)  8
         EndDo
       when    ( &ToFmt *EQ  9 )         Do
         Chgvar  &ToFmtC   'YYYYMMDD'
         Chgvar  %bin(&RtnLenC)  8
         EndDo
       when    ( &ToFmt *EQ 10 )         Do
         Chgvar  &ToFmtC   'YYYYMMDD'
         Chgvar  %bin(&RtnLenC)  7           /* *CYMD */
         EndDo
       when    ( &ToFmt *EQ 15 )         Do
         Chgvar  &ToFmtC   'YYYYDDD'
         Chgvar  %bin(&RtnLenC)  7
         EndDo
     EndSelect

     CallPrc     CEEDAYS    ( &DateCvt                                +
                              &FromFmtC                               +
                              &Lilian                                 +
                              *Omit                                   +
                            )

     CallPrc     CEEDATE    ( &Lilian                                 +
                              &ToFmtC                                 +
                              &ToVar                                  +
                              *Omit                                   +
                            )
     If        ( &ToFmt  *EQ  10 )       Do
         Chgvar  &RtnYear    %Sst( &ToVar   1 2 )
         Select
           when  ( &RtnYear  *EQ '19' )   +
             Chgvar          &ToVar     ( '0' *CAT %SST( &ToVar   3 6 ))
           when  ( &RtnYear  *EQ '20' )   +
             Chgvar          &ToVar     ( '1' *CAT %SST( &ToVar   3 6 ))
           when  ( &RtnYear  *EQ '21' )   +
             Chgvar          &ToVar     ( '2' *CAT %SST( &ToVar   3 6 ))
           when  ( &RtnYear  *EQ '22' )   +
             Chgvar          &ToVar     ( '3' *CAT %SST( &ToVar   3 6 ))
           when  ( &RtnYear  *EQ '23' )   +
             Chgvar          &ToVar     ( '4' *CAT %SST( &ToVar   3 6 ))
           when  ( &RtnYear  *EQ '24' )   +
             Chgvar          &ToVar     ( '5' *CAT %SST( &ToVar   3 6 ))
           when  ( &RtnYear  *EQ '25' )   +
             Chgvar          &ToVar     ( '6' *CAT %SST( &ToVar   3 6 ))
           when  ( &RtnYear  *EQ '26' )   +
             Chgvar          &ToVar     ( '7' *CAT %SST( &ToVar   3 6 ))
           when  ( &RtnYear  *EQ '27' )   +
             Chgvar          &ToVar     ( '8' *CAT %SST( &ToVar   3 6 ))
           when  ( &RtnYear  *EQ '28' ) +
             Chgvar          &ToVar     ( '9' *CAT %SST( &ToVar   3 6 ))
         EndSelect
     EndDo

     Chgvar      &ToVar     ( &RtnLenC *Cat &ToVar )

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
