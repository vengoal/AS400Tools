/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : RtvJOBDT                                           */
/*  Description : RTVJOBD command test program  - CPP                */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400 ePaper                                       */
/*  Date  . . . : November 14, 2024                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( RTVJOBDT )                                     */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/

     Pgm

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &JobD        *Char    10   'QDFTJOBD'
     Dcl        &JobDLib     *Char    10   'QGPL'
     Dcl        &RtnLib      *Char    10
     Dcl        &User        *Char    10
     Dcl        &JobQ        *Char    10
     Dcl        &JobQLib     *Char    10
     Dcl        &JobPty      *Char     2
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
     Dcl        &OutPty      *Char     2
     Dcl        &Hold        *Char    10
     Dcl        &Date        *Char     8
     Dcl        &Sws         *Char     8
     Dcl        &DevRcyAcn   *Char    13
     Dcl        &TsePool     *Char    10
     Dcl        &JobMsgQMax  *Dec   (  3 0 )
     Dcl        &JobMsgQFul  *Char    10
     Dcl        &AlwMltThd   *Char    10
     Dcl        &SplfAcn     *Char    10
     Dcl        &InlAspGrp   *Char    10
     Dcl        &DdmCnv      *Char    10
     Dcl        &LogOutput   *Char    10
     Dcl        &Text        *Char    50

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error

     RtvJobD    JobD( &JOBDLIB/&JOBD )                 +
                RtnLib( &RTNLIB )                      +
                User( &USER )                          +
                JobQ( &JOBQ )                          +
                JobQLib( &JOBQLIB )                    +
                JobPty( &JOBPTY )                      +
                PrtDev( &PRTDEV )                      +
                LogCLPgm( &LOGCLPGM )                  +
                InqMsgRpy( &INQMSGRPY )                +
                AcgCde( &ACGCDE )                      +
                PrtTxt( &PRTTXT )                      +
                RtgDta( &RTGDTA )                      +
                RqsDta( &RQSDTA )                      +
                Syntax( &SYNTAX )                      +
                InlLibl( &INLLIBL )                    +
                EndSev( &ENDSEV )                      +
                LogSev( &LOGSEV )                      +
                LogLvl( &LOGLVL )                      +
                LogTxt( &LOGTXT )                      +
                OutQ( &OUTQ )                          +
                OutQLib( &OUTQLIB )                    +
                OutPty( &OUTPTY )                      +
                Hold( &HOLD )                          +
                Date( &DATE )                          +
                SWS( &SWS )                            +
                DevRcyAcn( &DEVRCYACN )                +
                TsePool( &TSEPOOL )                    +
                JobMsgQMax( &JOBMSGQMAX )              +
                JobMsgQFul( &JOBMSGQFUL )              +
                AlwMltThd( &ALWMLTTHD )                +
                SplfAcn( &SPLFACN )                    +
                InlAspGrp( &INLASPGRP )                +
                DdmCnv( &DDMCNV )                      +
                LogOutput( &LOGOUTPUT )                +
                Text( &TEXT )

             DMPCLPGM

     Return

 Error:
    MovDiagMsg
    Monmsg    CPF0000
    RsnEscMsg
    Monmsg    CPF0000

Endpgm
