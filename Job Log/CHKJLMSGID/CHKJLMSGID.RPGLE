     **
     **  Program . . : CHKJLMSGID
     **  Description : Check Joblog by MsgId
     **  Author  . . : Vengoal Chang
     **  Published . : Dimerco Data System Corporation
     **  Date  . . . : July  1, 2009
     **
     **
     **  Program summary
     **  ---------------
     **
     **  Message handling API:
     **    QGYOLJBL      Open list of joblog   Lists messages from the specified
     **                  messages              job's joblog in sending data and
     **                                        time order. Replies to inquiry-
     **                                        messages are listed immediately
     **                                        after the message it is associated
     **                                        with.
     **
     **                                        The QGYOLJBL API is found in the
     **                                        QGY library as are all other open
     **                                        list APIs - prior to V5R3.
     **
     **                                        To retrieve open lists entries
     **                                        from an already open list the
     **                                        QGYGTLE (Get List Entries) API
     **                                        is available.
     **
     **  Open list APIs:
     **    QGYGTLE       Get list entries      To retrieve open lists entries
     **                                        from an already open list the
     **                                        QGYGTLE (Get List Entries) API
     **                                        is available.
     **
     **    QGYCLST       Close list            This API closes the previously
     **                                        opened list identified by the
     **                                        request handle parameter.
     **                                        Storage allocated is freed.
     **
     **  Sequence of events:
     **    1. The API input parameters are initialized
     **
     **    2. The open list of joblog messages API is called
     **
     **    3. If an error occurred calling the API or
     **       no entry is found blanks are returned to
     **       the caller
     **
     **    4. The most recent secified message id joblog message
     **       data is retrieved and returned to the caller.
     **
     **
     **  Parameters:
     **    PxJobId     INPUT      Qualified job name of the job whose joblog
     **                           messages are to be listed. The following
     **                           format applies:
     **
     **                            1-10  Char 10   Job name
     **                           11-20  Char 10   Job user
     **                           21-26  Char  6   Job number
     **
     **                           The special value '*' is allowed. This value
     **                           identifies the current job.
     **
     **    PxMsgF      OUTPUT     The MSGF   of the most recent found msgid
     **                           is returned.  If no msgid found blanks
     **                           are returned.
     **
     **    PxMsgFLib   OUTPUT     The MSGFLIB of the most recent found msgid
     **                           is returned.  If no msgid found blanks
     **                           are returned.
     **
     **    PxMsgDta    OUTPUT     The MSGDTA of the most recent found msgid
     **                           is returned.  If no msgid found blanks
     **                           are returned.
     **
     **
     **  Programmer's note:
     **    As mentioned above library QGY must be in the job library list
     **    to succesfully run this program on releases prior to V5R3.
     **
     **    To list another user's joblog *JOBCTL special authority is
     **    required.
     **
     **    To list the joblog of a user having user class *SECOFR, special
     **    authority *ALLOBJ is required.
     **
     **
     **  Compile options:
     **
     **   CrtRpgMod  Module( CHKJLMSGID )
     **
     **   CrtPgm     Pgm( CHKJLMSGID )
     **              Module( CHKJLMSGID )
     **              ActGrp( QILE )
     **
     **
     **-- Control spec:  -----------------------------------------------------**
     H Option( *SrcStmt ) DftActGrp(*NO)
     **-- API error data structure:  -----------------------------------------**
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- API parameters:  ---------------------------------------------------**
     D RtnRcdNbr       s             10i 0
     **
     D SltInf          Ds                  Qualified
     D  RtvDrc                       10a
     D  JobId                        26a   Inz( '*' )
     D  IntJobId                     16a
     D  StrKey                        4a
     D  MsgLenMax                    10i 0 Inz( -1 )
     D  HlpLenMax                    10i 0 Inz( 0 )
     D  FldIdsOfs                    10i 0 Inz( 84 )
     D  FldIdsNbr                    10i 0 Inz( %Elem( SltInf.FldIds ))
     D  CalMsqOfs                    10i 0 Inz( 88 )
     D  CalMsqLen                    10i 0 Inz( 1 )
     D                                4a
     D  FldIds                       10i 0 Dim( 1 ) Inz( 201 )
     D  CalMsq                       10a   Inz( '*' )
     **
     D LstInf          Ds                  Qualified
     D  RcdNbrTot                    10i 0
     D  RcdNbrRtn                    10i 0
     D  Handle                        4a
     D  RcdLen                       10i 0
     D  InfSts                        1a
     D  TimStp                       13a
     D  LstSts                        1a
     D                                1a
     D  InfLen                       10i 0
     D  Rcd1                         10i 0
     D                               40a
     **
     D OLJL0100        Ds         32767    Qualified
     D  NxtMsgOfs                    10i 0
     D  FldDtaOfs                    10i 0
     D  FldNbrOfs                    10i 0
     D  MsgSev                       10i 0
     D  MsgId                         7a
     D  MsgTyp                        2a
     D  MsgKey                        4a
     D  MsgF                         10a
     D  MsgFlib                      10a
     D  DatSnt                        7a
     D  TimSnt                        6a
     D  MicSec                        6a
     **
     D FldDta          Ds                  Qualified  Based( pFldDta )
     D  NxtFldOfs                    10i 0
     D  FldDtaLen                    10i 0
     D  FldId                        10i 0
     D  DtaTyp                        1a
     D  DtaSts                        1a
     D                               14a
     D  DtaLen                       10i 0
     D  Dta                        1024a

     **-- Open list of job log messages:
     D LstLogMsg       Pr                  ExtPgm( 'QGYOLJBL' )
     D  LlRcvVar                  65535a          Options( *VarSize )
     D  LlRcvVarLen                  10i 0 Const
     D  LlLstInf                     80a
     D  LlNbrRcdRtn                  10i 0 Const
     D  LlLogSltInf                1024a   Const  Options( *VarSize )
     D  LlLogSltLen                  10i 0 Const
     D  LlError                    1024a          Options( *VarSize )
     **-- Get list entry:
     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
     D  GlRcvVar                  65535a          Options( *VarSize )
     D  GlRcvVarLen                  10i 0 Const
     D  GlHandle                      4a   Const
     D  GlLstInf                     80a
     D  GlNbrRcdRtn                  10i 0 Const
     D  GlRtnRcdNbr                  10i 0 Const
     D  GlError                    1024a          Options( *VarSize )
     **-- Close list:
     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
     D  ClHandle                      4a   Const
     D  ClError                    1024a          Options( *VarSize )

     D CmdStr          S           1024    INZ
     D CmdLen          S             15P 5 INZ(1024)
     **-- Call system command:
     D  QCMDEXC        PR                  ExtPgm('QCMDEXC')
     D   Cmd                        500A   options(*varsize) Const
     D   CmdLen                      15P 5 Const


     D CHKJLMSGID      Pr
     D  PxJobId                      26a
     D  PxMsgId                       7a
     D  PxMsgF                       10a
     D  PxMsgFLib                    10a
     D  PxMsgDta                    256a
     **
     D CHKJLMSGID      Pi
     D  PxJobId                      26a
     D  PxMsgId                       7a
     D  PxMsgF                       10a
     D  PxMsgFLib                    10a
     D  PxMsgDta                    256a

      /Free

        CmdStr = 'ADDLIBLE QGY' ;
        CmdLen = %len(%trim(CmdStr));
        Monitor;
        QCMDEXC(%trim(CmdStr) : CmdLen);
        On-Error;
        EndMon;

        PxMsgF    = *Blanks;
        PxMsgFLib = *Blanks;
        PxMsgDta  = *Blanks;

        SltInf.JobId  = PxJobId;
        SltInf.RtvDrc = '*PRV';
        SltInf.StrKey = x'FFFFFFFF';

        LstLogMsg( OLJL0100
                 : %Size( OLJL0100 )
                 : LstInf
                 : 1
                 : SltInf
                 : %Size( SltInf )
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl = *Zero;

          DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= RtnRcdNbr;

            pFldDta = %Addr( OLJL0100 ) + OLJL0100.FldDtaOfs;

            If  OLJL0100.MsgId = PxMsgId  ;

              PxMsgF   = OLJL0100.MsgF;
              PxMsgFLib= OLJL0100.MsgFLib;
              PxMsgDta = %Subst( FldDta.Dta: 1: FldDta.DtaLen );
              Leave;
            EndIf;

            RtnRcdNbr += 1;

            GetLstEnt( OLJL0100
                     : %Size( OLJL0100 )
                     : LstInf.Handle
                     : LstInf
                     : 1
                     : RtnRcdNbr
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl > *Zero;
              Leave;
            EndIf;
          EndDo;

          CloseLst( LstInf.Handle: ERRC0100 );
        EndIf;

        *InLr = *On;
        Return;

      /End-Free

