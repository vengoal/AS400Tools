/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : RTVJOBMSGW                                         */
/*  Description : Retrieve Job Waiting Message key and MsgQ info     */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : December 23, 2024                                  */
/*                                                                   */
/*                                                                   */
/*  Programmer's notes:                                              */
/*      MSGF      MSGID                                              */
/*      QCPFMSG   CPA0701                                            */
/*                CPA0702                                            */
/*                                                                   */
/*      QRPGMSGE  RPG0100                                            */
/*                RPG0200                                            */
/*                RPG0300                                            */
/*                RPG0400                                            */
/*                RPG0500                                            */
/*                RPG0800                                            */
/*                RPG0900                                            */
/*                RPG1000                                            */
/*                RPG1100                                            */
/*                RPG1200                                            */
/*                RPG1300                                            */
/*                                                                   */
/*      QRNXMSG   RNQ0100 RNQ0102                                    */
/*                                                                   */
/*                RNQ0200                                            */
/*                RNQ0300                                            */
/*                RNQ0400                                            */
/*                RNQ0500                                            */
/*                RNQ0800                                            */
/*                RNQ0900                                            */
/*                RNQ1000                                            */
/*                RNQ1200                                            */
/*                RNQ1300                                            */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( RTVJOBMSGW )                                   */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
    Pgm      ( &QualJob               +
               &IntJobIdp             +
               &RtnMsgRpy             +
               &RtnMsgKey             +
               &RtnMsgq               +
               &RtnMsgqLib            +
               &RtnMsgId              +
               &RtnMsgType            +
               &RtnMsgTxt             +
               &RtnSecLvl             +
               &RtnMsgDta             +
               &RtnMsgF               +
               &RtnMsgFLib            +
               &ErrPgm                +
               &ErrPgmLib             +
               &ErrMsgId              +
               &ErrPgmStmt            +
             )

/*-- Global variables:  ---------------------------------------------*/
    Dcl   &QualJob    *Char    26
    Dcl   &IntJobIdp  *Char    16
    Dcl   &RtnMsgRpy  *Char     1
    Dcl   &RtnMsgKey  *Char     4
    Dcl   &RtnMsgq    *Char    10
    Dcl   &RtnMsgqLib *Char    10
    Dcl   &RtnMsgId   *Char     7
    Dcl   &RtnMsgType *Char     2
    Dcl   &RtnMsgTxt  *Char   132
    Dcl   &RtnSecLvl  *Char   256
    Dcl   &RtnMsgDta  *Char   192
    Dcl   &RtnMsgF    *Char    10
    Dcl   &RtnMsgFLib *Char    10
    Dcl   &ErrPgm     *Char    10
    Dcl   &ErrPgmLib  *Char    10
    Dcl   &ErrMsgId   *Char     7
    Dcl   &ErrPgmStmt *Char    10

/*-- QUSRJOBI API variables:  ---------------------------------------*/
    Dcl   &RcvLen     *Int
    Dcl   &JobI0200   *Char  1024
    Dcl   &RtnByte    *Int         Stg( *Defined )  Defvar( &JobI0200   1 )
    Dcl   &RtnAvl     *Int         Stg( *Defined )  Defvar( &JobI0200   5 )
    Dcl   &Job        *Char    10  Stg( *Defined )  Defvar( &JobI0200   9 )
    Dcl   &User       *Char    10  Stg( *Defined )  Defvar( &JobI0200  19 )
    Dcl   &Nbr        *Char     6  Stg( *Defined )  Defvar( &JobI0200  29 )
    Dcl   &IntJobId   *Char    16  Stg( *Defined )  Defvar( &JobI0200  35 )
    Dcl   &JobSts     *Char    10  Stg( *Defined )  Defvar( &JobI0200  51 )
    Dcl   &JobType    *Char     1  Stg( *Defined )  Defvar( &JobI0200  61 )
    Dcl   &JobSubType *Char     1  Stg( *Defined )  Defvar( &JobI0200  62 )
    Dcl   &SbsD       *Char    10  Stg( *Defined )  Defvar( &JobI0200  63 )
    Dcl   &RunPtyN    *Int         Stg( *Defined )  Defvar( &JobI0200  73 )
    Dcl   &CPUTime    *Int         Stg( *Defined )  Defvar( &JobI0200  81 )
    Dcl   &AuxIO      *Int         Stg( *Defined )  Defvar( &JobI0200  85 )
    Dcl   &NbrIntTxn  *Int         Stg( *Defined )  Defvar( &JobI0200  89 )
    Dcl   &RspTimTot  *Int         Stg( *Defined )  Defvar( &JobI0200  93 )
    Dcl   &FcnTyp     *Char     1  Stg( *Defined )  Defvar( &JobI0200  97 )
    Dcl   &FcnNme     *Char    10  Stg( *Defined )  Defvar( &JobI0200  98 )
    Dcl   &ActSts     *Char     4  Stg( *Defined )  Defvar( &JobI0200 108 )
    Dcl   &NbrDbLckW  *Int         Stg( *Defined )  Defvar( &JobI0200 112 )
    Dcl   &NbrMchLckW *Int         Stg( *Defined )  Defvar( &JobI0200 116 )
    Dcl   &NbrNDbLckW *Int         Stg( *Defined )  Defvar( &JobI0200 120 )
    Dcl   &CurSysPId  *Int         Stg( *Defined )  Defvar( &JobI0200 137 )
    Dcl   &ThreadCnt  *Int         Stg( *Defined )  Defvar( &JobI0200 141 )
    Dcl   &CpuTimL    *Char     8  Stg( *Defined )  Defvar( &JobI0200 145 )
    Dcl   &AuxIOL     *Char     8  Stg( *Defined )  Defvar( &JobI0200 153 )
    Dcl   &CpuDbL     *Char     8  Stg( *Defined )  Defvar( &JobI0200 161 )
    Dcl   &PageFault  *Char     8  Stg( *Defined )  Defvar( &JobI0200 169 )
    Dcl   &ActStsEnd  *Char     4  Stg( *Defined )  Defvar( &JobI0200 177 )
    Dcl   &PoolName   *Char    10  Stg( *Defined )  Defvar( &JobI0200 181 )
    Dcl   &MsgRpy     *Char     1  Stg( *Defined )  Defvar( &JobI0200 191 )
    Dcl   &MsgKey     *Char     4  Stg( *Defined )  Defvar( &JobI0200 192 )
    Dcl   &MsgQ       *Char    10  Stg( *Defined )  Defvar( &JobI0200 196 )
    Dcl   &MsgQLib    *Char    10  Stg( *Defined )  Defvar( &JobI0200 206 )
    Dcl   &MsgQAsp    *Char    10  Stg( *Defined )  Defvar( &JobI0200 216 )
    Dcl   &PJUseCnt   *Int         Stg( *Defined )  Defvar( &JobI0200 229 )
    Dcl   &PJMaxUse   *Int         Stg( *Defined )  Defvar( &JobI0200 233 )

/*-- RCVMSG variables:  ---------------------------------------------*/
    Dcl   &MsgID      *Char     7
    Dcl   &MsgTxt     *Char   132
    Dcl   &SecLvl     *Char   256
    Dcl   &MsgType    *Char     2
    Dcl   &MsgDta     *Char   192
    Dcl   &MsgF       *Char    10
    Dcl   &MsgFLib    *Char    10

/*-- Global error monitoring:  --------------------------------------*/
    MonMsg     CPF0000     *N       GoTo Error

/*-- Mainline -------------------------------------------------------*/

    ChgVar     &RcvLen       1024
    Call       QUSRJOBI    ( &JobI0200                          +
                             &RcvLen                            +
                             'JOBI0200'                         +
                             &QualJob                           +
                             &IntJobIdp                         +
                           )

    If       ( &MsgRpy = '1' )           Do
    RcvMsg     Msgq( &MsgqLib/&Msgq )                           +
               MsgKey( &MsgKey )                                +
               Rmv( *KEEPEXCP )                                 +
               Msg( &MsgTxt )                                   +
               SecLvl( &SecLvl )                                +
               MsgDta( &MsgDta )                                +
               MsgID( &MsgId )                                  +
               RtnType( &MsgType )                              +
               Msgf( &Msgf )                                    +
               MsgfLib( &MsgfLib )

    ChgVar     &RtnMsgRpy    &MsgRpy
    Monmsg     MCH3601
    ChgVar     &RtnMsgKey    &MsgKey
    Monmsg     MCH3601
    ChgVar     &RtnMsgq      &Msgq
    Monmsg     MCH3601
    ChgVar     &RtnMsgqLib   &MsgqLib
    Monmsg     MCH3601
    ChgVar     &RtnMsgTxt    &MsgTxt
    Monmsg     MCH3601
    ChgVar     &RtnSecLvl    &SecLvl
    Monmsg     MCH3601
    ChgVar     &RtnMsgId     &MsgId
    Monmsg     MCH3601
    ChgVar     &RtnMsgType   &MsgType
    Monmsg     MCH3601
    ChgVar     &RtnMsgDta    &MsgDta
    Monmsg     MCH3601
    ChgVar     &RtnMsgF      &MsgF
    Monmsg     MCH3601
    ChgVar     &RtnMsgFLib   &MsgFLib
    Monmsg     MCH3601

    Select
    When     ( &MsgId *EQ 'CPA0701'   *OR                       +
               &MsgId *EQ 'CPA0702' )    Do
    Chgvar     &ErrPgm       %sst(&MsgDta  1 10 )
    Monmsg     MCH3601
    Chgvar     &ErrPgmLib    %sst(&MsgDta 11 10 )
    Monmsg     MCH3601
    Chgvar     &ErrMsgId     %sst(&MsgDta 21  7 )
    Monmsg     MCH3601
    Chgvar     &ErrPgmStmt   %sst(&MsgDta 28 10 )
    Monmsg     MCH3601
    EndDo
    When     ( &MsgId *EQ 'RPG0120' )    Do
    Chgvar     &ErrPgm       %sst(&MsgDta  1 10 )
    Monmsg     MCH3601
    Chgvar     &ErrPgmLib    %sst(&MsgDta 21 10 )
    Monmsg     MCH3601
    Chgvar     &ErrMsgId     &MsgId
    Monmsg     MCH3601
    Chgvar     &ErrPgmStmt   ' '
    Monmsg     MCH3601
    EndDo
    When     ( %SST(&MsgId 1 5) *EQ 'RPG01'  *Or                +
               %SST(&MsgId 1 5) *EQ 'RPG02'  *Or                +
               %SST(&MsgId 1 5) *EQ 'RPG03'  *Or                +
               %SST(&MsgId 1 5) *EQ 'RPG04'  *Or                +
               %SST(&MsgId 1 5) *EQ 'RPG05'  *Or                +
               %SST(&MsgId 1 5) *EQ 'RPG08'  *Or                +
               %SST(&MsgId 1 5) *EQ 'RPG09'  *Or                +
               %SST(&MsgId 1 5) *EQ 'RPG10'  )        Do
    Chgvar     &ErrPgm       %sst(&MsgDta  1 10 )
    Monmsg     MCH3601
    Chgvar     &ErrPgmLib    %sst(&MsgDta 21 10 )
    Monmsg     MCH3601
    Chgvar     &ErrMsgId     &MsgId
    Monmsg     MCH3601
    Chgvar     &ErrPgmStmt   %sst(&MsgDta 11 10 )
    Monmsg     MCH3601

    If       ( &MsgId        *EQ  'RPG0120' )         Do
    Chgvar     &ErrPgmStmt   ' '
    Monmsg     MCH3601
    EndDo

    If       ( &MsgId        *EQ  'RPG0299' )         Do
    Chgvar     &ErrPgm       ' '
    Monmsg     MCH3601
    Chgvar     &ErrPgmLib    ' '
    Monmsg     MCH3601
    Chgvar     &ErrMsgId     &MsgId
    Monmsg     MCH3601
    Chgvar     &ErrPgmStmt   ' '
    Monmsg     MCH3601
    Chgvar     &ErrPgmStmt   ' '
    Monmsg     MCH3601
    EndDo
    EndDo

    When     ( %SST(&MsgId 1 5) *EQ 'RPG11'  *Or                +
               %SST(&MsgId 1 5) *EQ 'RPG12'  *Or                +
               %SST(&MsgId 1 5) *EQ 'RPG13'  *Or                +
               %SST(&MsgId 1 5) *EQ 'RPG19'  )        Do
    Chgvar     &ErrPgm       %sst(&MsgDta  1 10 )
    Monmsg     MCH3601
    Chgvar     &ErrPgmLib    %sst(&MsgDta 11 10 )
    Monmsg     MCH3601
    Chgvar     &ErrMsgId     %sst(&MsgDta 21  7 )
    Monmsg     MCH3601
    Chgvar     &ErrPgmStmt   %sst(&MsgDta 28 10 )
    Monmsg     MCH3601
    EndDo

    When     ( %SST(&MsgId 1 3) *EQ 'RNQ')  Do
    Chgvar     &ErrPgm       %sst(&MsgDta 11 10 )
    Monmsg     MCH3601
    Chgvar     &ErrPgmLib    %sst(&MsgDta 21 10 )
    Monmsg     MCH3601
    Chgvar     &ErrMsgId     %sst(&MsgDta 41  7 )
    Monmsg     MCH3601
    Chgvar     &ErrPgmStmt   %sst(&MsgDta 31 10 )
    Monmsg     MCH3601
    EndDo
    EndSelect  /* End &MsgId  */

 /* DMPCLPGM                  */

    EndDo    /* End &MsgRpy */

 Return:
     Return

/*-- Error processor ------------------------------------------------*/
 Error:
    Call       QMHMOVPM    ( '    '                             +
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
