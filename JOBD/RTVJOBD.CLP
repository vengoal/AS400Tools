/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : RtvJOBD                                            */
/*  Description : Retrieve job description      - CPP                */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400 ePaper                                       */
/*  Date  . . . : November 14, 2024                                  */
/*                                                                   */
/*  Program function:  RTVJOBD    command processing program         */
/*                                                                   */
/*                                                                   */
/*  Program summary                                                  */
/*  ---------------                                                  */
/*                                                                   */
/*  Work management APIs:                                            */
/*    QWDRJOBD       Retrieve Job       Retrieve Job Description     */
/*                   Description        associated with a specified  */
/*                                      jobD.                        */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( RTVJOBD  )                                     */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &JobD_q                +
                &RtnLib                +
                &User                  +
                &JobQ                  +
                &JobQLib               +
                &JobPty                +
                &PrtDev                +
                &LogClPgm              +
                &InqMsgRpy             +
                &AcgCde                +
                &PrtTxt                +
                &RtgDta                +
                &RqsDta                +
                &Syntax                +
                &InLLibL               +
                &EndSev                +
                &LogSev                +
                &LogLvl                +
                &LogTxt                +
                &OutQ                  +
                &OutQLib               +
                &OutPty                +
                &Hold                  +
                &Date                  +
                &Sws                   +
                &DevRcyAcn             +
                &TsePool               +
                &JobMsgQMax            +
                &JobMsgQFul            +
                &AlwMltThd             +
                &SplfAcn               +
                &InlAspGrp             +
                &DdmCnv                +
                &LogOutput             +
                &Text                  +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &JobD_q      *Char    20
     Dcl        &JobD        *Char  Stg( *Defined )         +
                                    Len( 10 ) DefVar( &JobD_q  1 )
     Dcl        &JobDLib     *Char  Stg( *Defined )         +
                                    Len( 10 ) DefVar( &JobD_q 11 )
     Dcl        &RtnLib      *Char    10
     Dcl        &User        *Char    10
     Dcl        &JobQ        *Char    10
     Dcl        &JobQLib     *Char    10
     Dcl        &JobPty      *Char     2
     Dcl        &OutPty      *Char     2
     Dcl        &PrtDev      *Char    10
     Dcl        &LogClPgm    *Char    10
     Dcl        &InqMsgRpy   *Char    10
     Dcl        &AcgCde      *Char    15
     Dcl        &PrtTxt      *Char    30
     Dcl        &RtgDta      *Char    80
     Dcl        &RqsDta      *Char   260
     Dcl        &Syntax      *Dec   (  2 0 )
     Dcl        &InLLibL     *Char  2750
     Dcl        &EndSev      *Dec   (  2 0 )
     Dcl        &LogSev      *Dec   (  2 0 )
     Dcl        &LogLvl      *Char     1
     Dcl        &LogTxt      *Char    10
     Dcl        &OutQ        *Char    10
     Dcl        &OutQLib     *Char    10
     Dcl        &Hold        *Char     4
     Dcl        &Date        *Char     8
     Dcl        &Sws         *Char     8
     Dcl        &DevRcyAcn   *Char    13
     Dcl        &TsePool     *Char     7
     Dcl        &JobMsgQMax  *Dec   (  3 0 )
     Dcl        &JobMsgQFul  *Char    10
     Dcl        &AlwMltThd   *Char    10
     Dcl        &SplfAcn     *Char    10
     Dcl        &InlAspGrp   *Char    10
     Dcl        &DdmCnv      *Char    10
     Dcl        &LogOutput   *Char    10
     Dcl        &Text        *Char    50
     Dcl        &RcvVar      *Char  4096
     Dcl        &RcvVarLen   *Char     4
     Dcl        &ErrCde      *Char     4
     Dcl        &InlOfs      *Int
     Dcl        &InlLen      *Int
     Dcl        &RqsOfs      *Int
     Dcl        &RqsLen      *Int
     Dcl        &RqsLen      *Int
     Dcl        &InlAspOfs   *Int
     Dcl        &NbrAspEnt   *Int
     Dcl        &LenAspEnt   *Int
     Dcl        &InlAspLen   *Int

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error

     ChkObj     Obj( &JobDLib/&JobD )  ObjType( *JOBD )
     ChgVar     %Bin( &RcvVarLen 1 4 ) 4096
     ChgVar     %Bin( &ErrCde    1 4 )    0

     Call       QWDRJOBD   ( &RcvVar             +
                             &RcvVarLen          +
                             JOBD0100            +
                             &JobD_q             +
                             &ErrCde             +
                           )
 RtnLib:
     ChgVar     &RtnLib      %Sst( &RcvVar 19 10 )
     Monmsg     MCH3601

 User:
     ChgVar     &User        %SST( &RcvVar   29 10 )
     Monmsg     MCH3601

 Date:
     ChgVar     &Date        %SST( &RcvVar   39  8 )
     Monmsg     MCH3601

 SWS:
     ChgVar     &SWS         %SST( &RcvVar   47  8 )
     Monmsg     MCH3601

 Jobq:
     ChgVar     &JobQ        %SST( &RcvVar   55 10 )
     Monmsg     MCH3601

 JobqLib:
     ChgVar     &JobQLib     %SST( &RcvVar   65 10 )
     Monmsg     MCH3601

 JobPty:
     ChgVar     &JobPty      %SST( &RcvVar   75  2 )
     Monmsg     MCH3601

 Hold:
     ChgVar     &Hold        %SST( &RcvVar   77 10 )
     Monmsg     MCH3601

 Outq:
     ChgVar     &OutQ        %SST( &RcvVar   87 10 )
     Monmsg     MCH3601

 OutqLib:
     ChgVar     &OutQLib     %SST( &RcvVar   97 10 )
     Monmsg     MCH3601

 OutPty:
     ChgVar     &OutPty      %SST( &RcvVar  107  2 )
     Monmsg     MCH3601

 PrtDev:
     ChgVar     &PrtDev      %SST( &RcvVar  109 10 )
     Monmsg     MCH3601

 PrtTxt:
     ChgVar     &PrtTxt      %SST( &RcvVar  119 30 )
     Monmsg     MCH3601

 Syntax:
     ChgVar     &Syntax      %BIN( &RcvVar  149  4 )
     Monmsg     MCH3601

 EndSev:
     ChgVar     &EndSev      %BIN( &RcvVar  153  4 )
     Monmsg     MCH3601

 LogSev:
     ChgVar     &LogSev      %BIN( &RcvVar  157  4 )
     Monmsg     MCH3601

 LogLvl:
     ChgVar     &LogLvl      %SST( &RcvVar  161  1 )
     Monmsg     MCH3601

 LogTxt:
     ChgVar     &LogTxt      %SST( &RcvVar  162 10 )
     Monmsg     MCH3601

 LogClPgm:
     ChgVar     &LogClPgm    %SST( &RcvVar  172 10 )
     Monmsg     MCH3601

 InqMsgRpy:
     ChgVar     &InqMsgRpy   %SST( &RcvVar  182 10 )
     Monmsg     MCH3601

 DevRcyAcn:
     ChgVar     &DevRcyAcn   %SST( &RcvVar  192 13 )
     Monmsg     MCH3601

 TsePool:
     ChgVar     &TsePool     %SST( &RcvVar  205 10 )
     Monmsg     MCH3601

 AcgCde:
     ChgVar     &AcgCde      %SST( &RcvVar  215 15 )
     Monmsg     MCH3601

 RtgDta:
     ChgVar     &RtgDta      %SST( &RcvVar  230 80 )
     Monmsg     MCH3601

 Text:
     ChgVar     &Text        %SST( &RcvVar  310 50 )
     Monmsg     MCH3601

 InlOfs:
     ChgVar     &InlOfs    ( %Bin(&RcvVar   361 4) + 1 )
     Monmsg     MCH3601

 InlLen:
     ChgVar     &InlLen    ( %Bin(&RcvVar   365 4) * 11 )
     Monmsg     MCH3601

 RqsOfs:
     ChgVar     &RqsOfs    ( %Bin(&RcvVar   369 4) + 1 )
     Monmsg     MCH3601

 RqsLen:
     ChgVar     &RqsLen    ( %Bin(&RcvVar   373 4) * 11 )
     Monmsg     MCH3601

 JobMsgQMax:
     ChgVar     &JobMsgQMax  %Bin(&RcvVar   377 4)
     Monmsg     MCH3601

 JobMsgQFul:
     ChgVar     &JobMsgQFul  %SST( &RcvVar  381 10 )
     Monmsg     MCH3601

 AlwMltThd:
     ChgVar     &AlwMltThd   %SST( &RcvVar  401 10 )
     Monmsg     MCH3601

 SplfAcn:
     ChgVar     &SplfAcn     %SST( &RcvVar  411 10 )
     Monmsg     MCH3601

 InlLibl:
     ChgVar     &InlLibl     %SST( &RcvVar &InlOfs &InlLen )
     Monmsg     MCH3601

 RqsDta:
     ChgVar     &RqsDta      %SST( &RcvVar &RqsOfs &RqsLen )
     Monmsg     MCH3601

 InlAspGrp:
     ChgVar     &InlAspOfs ( %Bin(&RcvVar   421 4) + 1 )
     Monmsg     MCH3601

     ChgVar     &NbrAspEnt ( %Bin(&RcvVar   425 4) )
     Monmsg     MCH3601

     ChgVar     &LenAspEnt ( %Bin(&RcvVar   429 4) )
     Monmsg     MCH3601

     ChgVar     &InlAspLen   (&NbrAspEnt * &LenAspEnt)
     If       ( &InlAspOfs *NE   0  *And &InlAspLen *NE   0 ) Do
     ChgVar     &InlAspGrp   %SST( &RcvVar &InlAspOfs &InlAspLen )
     Monmsg     MCH3601
     EndDo

 DdmCnv:
     ChgVar     &DdmCnv      %SST( &RcvVar   433 10 )
     Monmsg     MCH3601

 LogOutput:
     ChgVar     &LogOutput   %SST( &RcvVar   443 10 )
     Monmsg     MCH3601

     RmvMsg     Clear( *ALL )

     Return

 Error:
    MovDiagMsg
    Monmsg    CPF0000
    RsnEscMsg
    Monmsg    CPF0000

Endpgm
