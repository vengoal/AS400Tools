/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : RTVJOBQA                                           */
/*  Description : Retrieve job queue attributes - CPP                */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400 ePaper                                       */
/*  Date  . . . : November  4, 2024                                  */
/*                                                                   */
/*  Program function:  RTVJOBQA   command processing program         */
/*                                                                   */
/*                                                                   */
/*  Program summary                                                  */
/*  ---------------                                                  */
/*                                                                   */
/*  Work management APIs:                                            */
/*    QSPRJOBQ       Retrieve Job       Retrieve information         */
/*                   Queue Information  associated with a specified  */
/*                                      job queue.                   */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( RTVJOBQA )                                     */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &JobqFull              +
                &RtnLib                +
                &OprCtl                +
                &AutChk                +
                &NbrJobs               +
                &QStatus               +
                &SbsNam                +
                &SbsLib                +
                &SeqNbr                +
                &MaxAct                +
                &CurAct                +
                &Text                  +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &JobqFull    *Char    20
     Dcl        &Jobq        *Char  Stg( *Defined )         +
                                    Len( 10 ) DefVar( &JobqFull  1 )
     Dcl        &JobqLib     *Char  Stg( *Defined )         +
                                    Len( 10 ) DefVar( &JobqFull 11 )
     Dcl        &RcvVarLen   *Char     4
     Dcl        &RcvVar      *Char  2000
     Dcl        &ErrCde      *Char     4
     Dcl        &RtnLib      *Char    10
     Dcl        &OprCtl      *Char    10
     Dcl        &AutChk      *Char    10
     Dcl        &NbrJobs     *Dec    ( 9 0 )
     Dcl        &QStatus     *Char    10
     Dcl        &SbsNam      *Char    10
     Dcl        &SbsLib      *Char    10
     Dcl        &SeqNbr      *Dec    ( 9 0 )
     Dcl        &MaxAct      *Dec    ( 9 0 )
     Dcl        &CurAct      *Dec    ( 9 0 )
     Dcl        &Text        *Char    50

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error

     ChkObj     Obj( &JobqLib/&Jobq )  ObjType( *JOBQ )
     ChgVar     %Bin( &RcvVarLen 1 4 ) 1000
     ChgVar     %Bin( &ErrCde    1 4 )    0

     Call       QSPRJOBQ   ( &RcvVar             +
                             &RcvVarLen          +
                             JOBQ0100            +
                             &JobqFull           +
                             &ErrCde             +
                           )
 RtnLib:
     ChgVar     &RtnLib      %Sst( &RcvVar 19 10 )
     Monmsg     MCH3601
 OprCtl:
     ChgVar     &OPRCTL      %Sst( &RcvVar 29 10 )
     Monmsg     MCH3601
 AutChk:
     ChgVar     &AutChk      %Sst( &RcvVar 39 10 )
     Monmsg     MCH3601
 NbrJobs:
     ChgVar     &NbrJobs     %Bin( &RcvVar 49  4 )
     Monmsg     MCH3601
 QStatus:
     ChgVar     &QStatus     %Sst( &RcvVar 53 10 )
     Monmsg     MCH3601
 SbsNam:
     ChgVar     &SbsNam      %Sst( &RcvVar 63 10 )
     Monmsg     MCH3601
 Text:
     ChgVar     &Text        %Sst( &RcvVar 73 50 )
     Monmsg     MCH3601

 SbsLib:
     ChgVar     &SbsLib      %Sst( &RcvVar 123 10 )
     Monmsg     MCH3601

 SeqNbr:
     ChgVar     &SeqNbr      %Bin( &RcvVar 133  4 )
     Monmsg     MCH3601

 MaxAct:
     ChgVar     &MaxAct      %Bin( &RcvVar 137  4 )
     Monmsg     MCH3601

 CurAct:
     ChgVar     &CurAct      %Bin( &RcvVar 141  4 )
     Monmsg     MCH3601

     RmvMsg     Clear( *ALL )
     Return

 Error:
    MovDiagMsg
    Monmsg    CPF0000
    RsnEscMsg
    Monmsg    CPF0000

Endpgm
