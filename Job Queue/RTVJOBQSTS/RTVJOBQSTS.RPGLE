     **
     **  Program . . : RtvJobqSts
     **  Description : Retrieve Job Queue Status CPP
     **  Author  . . : Vengoal Chang
     **  Published . : AS400 ePaper
     **  Date  . . . : November 5, 2024
     **
     **
     **
     **    CrtRpgMod   Module( RtvJobqSts )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( RtvJobqSts )
     **                Module( RtvJobqSts )
     **                ActGrp( *NEW )
     **                Aut( *USE )
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt ) DftActGrp( *NO )
     H Debug

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a

     **-- Global constants:
     D OFS_MSGDTA      c                   16
     **
     D NUM_ZON         c                   2
     D CHAR_NLS        c                   4
     D SORT_ASC        c                   '1'
     D EC              s             10i 0 Inz( 0 )
     D QStatus         s             10
     D ActCount        s             10i 0
     D ScdCount        s             10i 0
     D HldCount        s             10i 0
     D RlsCount        s             10i 0

     **-- Global variables:
     D SysDts          s               z
     D KeyDtaVal       s             32a
     D Idx             s             10i 0
     **
     D ObjNam_q        Ds
     D  ObjNam                       10a
     D  ObjLib                       10a

     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0 Inz( 1 )
     D  NbrFldRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
     D  KeyFld                       10i 0 Dim( 13 )

     **-- Job queue information:
     D OJBQ0100        Ds                  Qualified  Inz
     D  JobQue                       10a
     D  JobQueLib                    10a
     D  JobQueSts                     1a
     D  ActSbs                       10a
     D  ActSbsLib                    10a
     D                                3a
     D  NbrJobOnQue                  10i 0
     D  SeqNbr                       10i 0
     D  MaxAct                       10i 0
     D  CurAct                       10i 0
     D  QueDsc                       50a
     **-- Filter information:
     D FltInf          Ds                  Qualified
     D  FltInfLen                    10i 0 Inz( %Size( FltInf ))
     D  JobQue_q                     20a
     D   JobQue                      10a   Overlay( JobQue_q:  1 )
     D   JobQueLib                   10a   Overlay( JobQue_q: 11 )
     D  ActSbs                       10a
     **-- Job information:
     D OLJB0200        Ds           512    Qualified
     D  JobId                        26a
     D  JobNam                       10a   Overlay( JobId:  1 )
     D  UsrPrf                       10a   Overlay( JobId: 11 )
     D  JobNbr                        6s 0 Overlay( JobId: 21 )
     D  JobIdInt                     16a
     D  Status                       10a
     D  JobTyp                        1a
     D  JobSubTyp                     1a
     D                                2a
     D  JobInfSts                     1a
     D                                3a
     D  Data                        128a
     **-- Job information key fields:
     D KeyDta          Ds                  Qualified
     D  JobQue_q                     20a
     D  JobPty                        2a
     D  SbsNam_q                     20a
     D  ActJobSts                     4a
     D  CurUsr                       10a
     D  JobEntDts                    13a
     D   JobEntDat                    7a   Overlay( JobEntDts: 1 )
     D   JobEntTim                    6a   Overlay( JobEntDts: 8 )
     D  JobTypE                      10i 0
     D  RunPty                       10i 0
     D  JobQueSts                    10a
     D  SbmJob_q                     26a
     D   SbmJobNam                   10a   Overlay( SbmJob_q:  1 )
     D   SbmJobUsr                   10a   Overlay( SbmJob_q: 11 )
     D   SbmJobNbr                    6s 0 Overlay( SbmJob_q: 21 )
     D  MsgRpy                        1a
     D  MsgQue_q                     20a
     D  MsgKey                        4a
     **-- Key information:
     D KeyInf          Ds                  Qualified
     D  FldNbrRtn                    10i 0
     D  KeyStr                       20a   Dim( %Elem( LstApi.KeyFld ))
     D   FldInfLen                   10i 0 Overlay( KeyStr:  1 )
     D   KeyFld                      10i 0 Overlay( KeyStr:  5 )
     D   DtaTyp                       1a   Overlay( KeyStr:  9 )
     D                                3a   Overlay( KeyStr: 10 )
     D   DtaLen                      10i 0 Overlay( KeyStr: 13 )
     D   DtaOfs                      10i 0 Overlay( KeyStr: 17 )
     **-- Sort information:
     D SrtInf          Ds                  Qualified
     D  NbrKeys                      10i 0 Inz( 0 )
     D  SrtStr                       12a   Dim( 4 )
     D   KeyFldOfs                   10i 0 Overlay( SrtStr:  1 )
     D   KeyFldLen                   10i 0 Overlay( SrtStr:  5 )
     D   KeyFldTyp                    5i 0 Overlay( SrtStr:  9 )
     D   SrtOrd                       1a   Overlay( SrtStr: 11 )
     D   Rsv                          1a   Overlay( SrtStr: 12 )
     **-- List information:
     D LstInf          Ds                  Qualified
     D  RcdNbrTot                    10i 0
     D  RcdNbrRtn                    10i 0
     D  Handle                        4a
     D  RcdLen                       10i 0
     D  InfSts                        1a
     D  Dts                          13a
     D  LstSts                        1a
     D                                1a
     D  InfLen                       10i 0
     D  Rcd1                         10i 0
     D                               40a
     **-- Selection information:
     D OLJS0200        Ds                  Qualified
     D  JobNam                       10a   Inz( '*ALL' )
     D  UsrPrf                       10a   Inz( '*ALL' )
     D  JobNbr                        6a   Inz( '*ALL' )
     D  JobTyp                        1a   Inz( '*' )
     D                                1a
     D  OfsPriSts                    10i 0 Inz( 108 )
     D  NbrPriSts                    10i 0 Inz( 2 )
     D  OfsActSts                    10i 0 Inz( 128 )
     D  NbrActSts                    10i 0 Inz( 0 )
     D  OfsJbqSts                    10i 0 Inz( 136 )
     D  NbrJbqSts                    10i 0 Inz( 0 )
     D  OfsJbqNam                    10i 0 Inz( 146 )
     D  NbrJbqNam                    10i 0 Inz( 1 )
     D  OfsCurUsr                    10i 0 Inz( 166 )
     D  NbrCurUsr                    10i 0 Inz( 0 )
     D  OfsSvrTyp                    10i 0 Inz( 176 )
     D  NbrSvrTyp                    10i 0 Inz( 0 )
     D  OfsActSbs                    10i 0 Inz( 206 )
     D  NbrActSbs                    10i 0 Inz( 0 )
     D  OfsMemPool                   10i 0 Inz( 216 )
     D  NbrMemPool                   10i 0 Inz( 0 )
     D  OfsJobTypE                   10i 0 Inz( 220 )
     D  NbrJobTypE                   10i 0 Inz( 0 )
     D  OfsJobNamQ                   10i 0 Inz( 228 )
     D  NbrJobNamQ                   10i 0 Inz( 0 )
     **
     D  PriSts                       10a   Dim( 2 )
     D  ActSts                        4a   Dim( 2 )
     D  JbqSts                       10a   Dim( 1 )
     D  JbqNam                       20a   Dim( 1 )
     D  CurUsr                       10a   Dim( 1 )
     D  SvrTyp                       30a   Dim( 1 )
     D  ActSbs                       10a   Dim( 1 )
     D  MemPool                      10i 0 Dim( 1 )
     D  JobTypE                      10i 0 Dim( 1 )
     D  JobNamQ                      26a   Dim( 1 )

     **-- Open list of job queues:
     D LstJobQs        Pr                  ExtPgm( 'QSPOLJBQ' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  LstInf                       80a
     D  FltInf                       32a   Const  Options( *VarSize )
     D  SrtInf                     1024a   Const  Options( *VarSize )
     D  NbrRcdRtn                    10i 0 Const
     D  Error                      1024a          Options( *VarSize )
     **-- Open list of jobs:
     D LstJobs         Pr                  ExtPgm( 'QGYOLJOB' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  RcvVarDfn                 65535a          Options( *VarSize )
     D  RcvDfnLen                    10i 0 Const
     D  LstInf                       80a
     D  NbrRcdRtn                    10i 0 Const
     D  SrtInf                     1024a   Const  Options( *VarSize )
     D  JobSltInf                  1024a   Const  Options( *VarSize )
     D  JobSltLen                    10i 0 Const
     D  NbrFldRtn                    10i 0 Const
     D  KeyFldRtn                    10i 0 Const  Options( *VarSize )  Dim( 32 )
     D  Error                      1024a          Options( *VarSize )
     D  JobSltFmt                     8a   Const  Options( *NoPass )
     D  ResStc                        1a   Const  Options( *NoPass )
     D  GenRtnDta                    32a          Options( *NoPass: *VarSize )
     D  GenRtnDtaLn                  10i 0 Const  Options( *NoPass )
     **-- Get open list entry:
     D GetOplEnt       Pr                  ExtPgm( 'QGYGTLE' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  Handle                        4a   Const
     D  LstInf                       80a
     D  NbrRcdRtn                    10i 0 Const
     D  RtnRcdNbr                    10i 0 Const
     D  Error                      1024a          Options( *VarSize )
     **-- Close list:
     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
     D  Handle                        4a   Const
     D  Error                      1024a          Options( *VarSize )
     **-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ObjNamQ                      20a   Const
     D  ObjTyp                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Copy memory:
     D memcpy          Pr              *   ExtProc( '_MEMMOVE' )
     D  MemOut                         *   Value
     D  MemInp                         *   Value
     D  MemSiz                       10u 0 Value
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      128a   Const
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  CalStkE                      10a   Const  Options( *VarSize )
     D  CalStkCtr                    10i 0 Const
     D  MsgKey                        4a
     D  Error                     32767a          Options( *VarSize )

     **-- Get list entry:
     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a   Const  Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  LstNam                       10a   Const
     D  PosOpt                        4a   Const
     D  CpyOpt                        1a   Const
     D  SltCri                       20a   Const
     D  SltHdl                        4a   Const
     D  ExtOpt                        1a   Const
     D  LstEntHdl                     4a
     D  Error                     32767a          Options( *VarSize )

     **-- Get object library:
     D GetObjLib       Pr            10a
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D RTVJOBQSTS      Pr
     D  PxJobQue_q                         LikeDs( ObjNam_q )
     D  PxRtnLib                     10a
     D  PxQstatus                    10a
     D  PxSbsName                    10a
     D  PxSbsLib                     10a
     D  PxCurAct                      9  0
     D  PxScdJob                      9  0
     D  PxHldJob                      9  0
     D  PxRlsJob                      9  0
     **
     D RTVJOBQSTS      Pi
     D  PxJobQue_q                         LikeDs( ObjNam_q )
     D  PxRtnLib                     10a
     D  PxQstatus                    10a
     D  PxSbsName                    10a
     D  PxSbsLib                     10a
     D  PxCurAct                      9  0
     D  PxScdJob                      9  0
     D  PxHldJob                      9  0
     D  PxRlsJob                      9  0

      /Free

        ExSr  GetJobQueInf;
        ExSr  BldJobLst;

        *InLr = *On;
        Return;


        BegSr  BldJobLst;

          ExSr  InzApiPrm;

          LstApi.RtnRcdNbr = 1;

          LstJobs( OLJB0200
                 : %Size( OLJB0200 )
                 : 'OLJB0200'
                 : KeyInf
                 : %Size( KeyInf )
                 : LstInf
                 : -1
                 : SrtInf
                 : OLJS0200
                 : %Size( OLJS0200 )
                 : LstApi.NbrFldRtn
                 : LstApi.KeyFld
                 : ERRC0100
                 : 'OLJS0200'
                 );

          If  ERRC0100.BytAvl = *Zero  And  LstInf.RcdNbrTot > *Zero;

            ExSr  PrcLstEnt;

            DoW  LstInf.RcdNbrTot > LstApi.RtnRcdNbr;
              LstApi.RtnRcdNbr += 1;

              GetOplEnt( OLJB0200
                       : %Size( OLJB0200 )
                       : LstInf.Handle
                       : LstInf
                       : 1
                       : LstApi.RtnRcdNbr
                       : ERRC0100
                       );

              If  ERRC0100.BytAvl > *Zero;
                Leave;
              EndIf;

              ExSr  PrcLstEnt;
            EndDo;

            Select;
            When  OJBQ0100.JobQueSts = '0'  ;
                  QStatus = 'HELD';

            When  OJBQ0100.JobQueSts = '1'  ;
                  QStatus = 'RELEASED';

            When  OJBQ0100.JobQueSts = '2'  ;
                  QStatus = 'DAMAGED' ;

            When  OJBQ0100.JobQueSts = '3'  ;
                  QStatus = 'NOTEXIST' ;
            Other;
            EndSl;

            PxRtnLib  =  PxJobQue_q.ObjLib;
            PxQstatus =  QStatus;
            PxSbsName =  OJBQ0100.ActSbs;
            PxSbsLib  =  OJBQ0100.ActSbsLib;
            PxCurAct  =  ActCount;
            PxScdJob  =  ScdCount;
            PxHldJob  =  HldCount;
            PxRlsJob  =  RlsCount;

          EndIf;

          CloseLst( LstInf.Handle: ERRC0100 );

        EndSr;

        BegSr  PrcLstEnt;

          Clear  KeyDta;

          For Idx = 1  To KeyInf.FldNbrRtn;

            KeyDtaVal = %SubSt( OLJB0200
                              : KeyInf.DtaOfs(Idx) + 1
                              : KeyInf.DtaLen(Idx)
                              );

            Select;
            When  KeyInf.KeyFld(Idx) = 101;
              KeyDta.ActJobSts = KeyDtaVal;

            When  KeyInf.KeyFld(Idx) = 305;
              KeyDta.CurUsr = KeyDtaVal;

            When  KeyInf.KeyFld(Idx) = 402;
              KeyDta.JobEntDts = KeyDtaVal;

            When  KeyInf.KeyFld(Idx) = 1004;
              KeyDta.JobQue_q = KeyDtaVal;

            When  KeyInf.KeyFld(Idx) = 1005;
              KeyDta.JobPty = KeyDtaVal;

            When  KeyInf.KeyFld(Idx) = 1307;
              KeyDta.MsgRpy = KeyDtaVal;

            When  KeyInf.KeyFld(Idx) = 1308;
              KeyDta.MsgKey = KeyDtaVal;

            When  KeyInf.KeyFld(Idx) = 1309;
              KeyDta.MsgQue_q = KeyDtaVal;

            When  KeyInf.KeyFld(Idx) = 1016;
              memcpy( %Addr( KeyDta.JobTypE )
                    : %Addr( KeyDtaVal )
                    : %Size( KeyDta.JobTypE )
                    );

            When  KeyInf.KeyFld(Idx) = 1802;
              memcpy( %Addr( KeyDta.RunPty )
                    : %Addr( KeyDtaVal )
                    : %Size( KeyDta.RunPty )
                    );

            When  KeyInf.KeyFld(Idx) = 1903;
              KeyDta.JobQueSts = KeyDtaVal;

            When  KeyInf.KeyFld(Idx) = 1904;
              KeyDta.SbmJob_q = KeyDtaVal;

            When  KeyInf.KeyFld(Idx) = 1906;
              KeyDta.SbsNam_q = KeyDtaVal;
            EndSl;

            If  KeyDta.JobQue_q > *Blanks  And  KeyDta.JobQue_q <> PxJobQue_q;
              Leave;
            EndIf;
          EndFor;

          If  KeyDta.JobQue_q = PxJobQue_q;
            ExSr  ProcessEnt;
          EndIf;

        EndSr;

        BegSr  ProcessEnt;

          Select;
          When  OLJB0200.Status = '*ACTIVE';
            ActCount  = ActCount + 1;

          When  OLJB0200.Status = '*JOBQ';
            If  KeyDta.JobQueSts = 'SCD';
              ScdCount  = ScdCount + 1;
            ElseIf KeyDta.JobQueSts = 'HLD';
              HldCount  = HldCount + 1;
            ElseIf KeyDta.JobQueSts = 'RLS';
              RlsCount  = RlsCount + 1;
            EndIf;

          Other;

          EndSl;

        EndSr;

        BegSr  GetJobQueInf;

          FltInf.JobQue_q = PxJobQue_q;
          FltInf.ActSbs = *Blanks;

          SrtInf.NbrKeys = *Zero;

          LstJobQs( OJBQ0100
                  : %Size( OJBQ0100 )
                  : 'OJBQ0100'
                  : LstInf
                  : FltInf
                  : SrtInf
                  : -1
                  : ERRC0100
                  );

          If  ERRC0100.BytAvl > *Zero  Or  LstInf.RcdNbrTot = *Zero;
            Reset  OJBQ0100;
          EndIf;

          CloseLst( LstInf.Handle: ERRC0100 );

        EndSr;

        BegSr  InzApiPrm;

          OLJS0200.PriSts(1) = '*ACTIVE';
          OLJS0200.PriSts(2) = '*JOBQ';

          OLJS0200.JbqNam(1) = PxJobQue_q;

          SrtInf.NbrKeys      = 4;
          SrtInf.KeyFldOfs(1) = 43;
          SrtInf.KeyFldLen(1) = %Size( OLJB0200.Status );
          SrtInf.KeyFldTyp(1) = CHAR_NLS;
          SrtInf.SrtOrd(1)    = SORT_ASC;
          SrtInf.Rsv(1)       = x'00';

          SrtInf.KeyFldOfs(2) = 61;
          SrtInf.KeyFldLen(2) = %Size( KeyDta.JobQue_q );
          SrtInf.KeyFldTyp(2) = CHAR_NLS;
          SrtInf.SrtOrd(2)    = SORT_ASC;
          SrtInf.Rsv(2)       = x'00';

          SrtInf.KeyFldOfs(3) = 81;
          SrtInf.KeyFldLen(3) = %Size( KeyDta.JobPty );
          SrtInf.KeyFldTyp(3) = CHAR_NLS;
          SrtInf.SrtOrd(3)    = SORT_ASC;
          SrtInf.Rsv(3)       = x'00';

          SrtInf.KeyFldOfs(4) = 21;
          SrtInf.KeyFldLen(4) = %Size( OLJB0200.JobNbr );
          SrtInf.KeyFldTyp(4) = NUM_ZON;
          SrtInf.SrtOrd(4)    = SORT_ASC;
          SrtInf.Rsv(4)       = x'00';

          LstApi.KeyFld(1) = 1004;
          LstApi.KeyFld(2) = 1005;
          LstApi.KeyFld(3) = 402;
          LstApi.KeyFld(4) = 1906;
          LstApi.KeyFld(5) = 101;
          LstApi.KeyFld(6) = 305;
          LstApi.KeyFld(7) = 1016;
          LstApi.KeyFld(8) = 1802;
          LstApi.KeyFld(9) = 1903;
          LstApi.KeyFld(10) = 1904;
          LstApi.KeyFld(11) = 1307;
          LstApi.KeyFld(12) = 1308;
          LstApi.KeyFld(13) = 1309;

        EndSr;

        BegSr  EscApiErr;

          If  ERRC0100.BytAvl < OFS_MSGDTA;
            ERRC0100.BytAvl = OFS_MSGDTA;
          EndIf;

          SndEscMsg( ERRC0100.MsgId
                   : 'QCPFMSG'
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
                   );

        EndSr;

        BegSr  *InzSr;

          If  PxJobQue_q.ObjLib = '*LIBL';
            PxJobQue_q.ObjLib = GetObjLib( PxJobQue_q: '*JOBQ' );
          EndIf;

        EndSr;

      /End-Free

     **-- Get object library:
     P GetObjLib       B
     D                 Pi            10a
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const
     **
     D OBJD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a
     D  ObjLibRtn                    10a
     D  ObjASP                       10i 0
     D  ObjOwn                       10a
     D  ObjDmn                        2a

      /Free

         RtvObjD( OBJD0100
                : %Size( OBJD0100 )
                : 'OBJD0100'
                : PxObjNam_q
                : PxObjTyp
                : ERRC0100
                );

         If  ERRC0100.BytAvl > *Zero;
           Return  *Blanks;

         Else;
           Return  OBJD0100.ObjLibRtn;
         EndIf;

      /End-Free

     P GetObjLib       E
     **-- Send escape message:
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : PxMsgF + '*LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*ESCAPE'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndEscMsg       E
