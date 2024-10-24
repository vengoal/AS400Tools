     **
     **  Program . . : ChkLicExpD
     **  Description : Check License Expiration Date
     **  Author  . . : Vengoal Chang
     **  Published . : AS400ePaper
     **  Date  . . . : 2024/10/23
     **
     **
     **  Program summary
     **  ---------------
     **
     **  Software product APIs:
     **    QLZARTVK       Retrieve License     Returns license key information
     **                   Key                  about a software product.
     **                                        You must have *USE authority
     **                                        to QLZARTVK program.
     **
     **  Compile and setup instructions:
     **    CrtBndRpg   Pgm( CHKLICEXPD )
     **                DbgView( *LIST )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )  BndDir( 'QC2LE' ) DftActGrp( *NO )
     H Debug

     D PSDS           SDS
     D  Proc_Name        *PROC
     D  Pgm_Status       *STATUS
     D  Excp_MsgId            40     46
     D  Excp_Type             40     42
     D  Excp_Num              43     46
     D  Excp_Data             91    170
     D  Excp_ID              171    174
     D  JobNam               244    253
     D  JobUsr               254    263
     D  JobNbr               264    269

     **-- API error information:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      256a
     **-- Global constants:
     D Days            s              5i 0
     **-- Global variables:
     D RcvVarLen       s             10i 0
     D IdxPrd          s             10u 0
     D ExpD            s               d
     D TgtD            s               d
     D MsgText         s            512    Varying

     **-- Input information
     **-- LICT0100 format information:
     D LICT0100        Ds                  Qualified
     D  ProdId                        7a   Inz('*ALL')
     D  LicTerm                       6a   Inz('*ALL')
     D  Feat                          4a   Inz('*ALL')

     **-- Output information
     **-- LICV0100 format
     D LICV0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  OfsToLicKey                  10i 0
     D  NumLstEnt                    10i 0
     D  SizLstEnt                    10i 0
     D  LICKEYRCDS                32767a

     **-- LICKEY Record information:
     D LICKEYRCD       Ds                  Qualified Based(uListPtr )
     D  ProdId                        7a
     D  LicTerm                       6a
     D  Feat                          4a
     D  SrlNbr                        8a
     D  PrcGrp                        4a
     D  Rsvd1                         3a
     D  UsgLmt                       10i 0
     D  ExpD                          7a
     D  Vendor                        8a
     D  LicKey                       18a
     D  Rsvd2                        15a

     **-- Retrieve License Key Information (QLZARTVK) API
     D RtvLicKeyInf    Pr                  ExtPgm( 'QLZARTVK' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  RcvVarFmt                     8a   Const
     D  ProdID                       17a   Const
     D  ProdIDFmt                     8a   Const
     D  SysSrlNbr                     8a   Const
     D  SysFmt                        8a   Const
     D  Error                     32767a          Options( *VarSize )

     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      512a   Const
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  CalStkE                      10a   Const Options( *VarSize )
     D  CalStkCtr                    10i 0 Const
     D  MsgKey                        4a
     D  Error                      1024a         Options( *VarSize )
     D  CalStkElen                   10i 0 Const Options( *NoPass )
     D  CalStkEq                     20a   Const Options( *NoPass )
     D  DspWait                      10i 0 Const Options( *NoPass )
     D  CalStkEtyp                   20a   Const Options( *NoPass )
     D  CcsId                        10i 0 Const Options( *NoPass )
     **-- Send message:
     D SndMsg          Pr                  ExtPgm( 'QMHSNDM' )
     D  MsgId                         7a   Const
     D  MsgFil_q                     20a   Const
     D  MsgDta                      512a   Const  Options( *VarSize )
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  MsgQue_q                   1000a   Const  Options( *VarSize )
     D  MsgQueNbr                    10i 0 Const
     D  MsgQueRpy                    20a   Const
     D  MsgKey                        4a
     D  Error                     32767a          Options( *VarSize )
     D  CcsId                        10i 0 Const  Options( *NoPass )
     **-- Run system command:
     D system          Pr            10i 0 ExtProc( 'system' )
     D  command                        *   Value  Options( *String )

     **-- Check AS400 Object exist ?
     D As400ObjFound   PR              N
     D  QlObjName                    20    Value
     D  ObjType                      10    Value
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send information message:
     D SndInfMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Send text message:
     D SndTxtMsg       Pr            10i 0
     D  PxMsgTxt                    512a   Const  Varying
     D  PxMsgQ_q                     20a   Const
     **-- Send joblog message:
     D SndLogMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D ObjNam_q        Ds
     D  ObjNam                       10a
     D  LibNam                       10a

     **-- Main:
     D CHKLICEXPD      Pr
     D  PxDays                        5i 0 Const
     D  PxMsgQ_q                           LikeDs( ObjNam_q )
     **
     D CHKLICEXPD      Pi
     D  PxDays                        5i 0 Const
     D  PxMsgQ_q                           LikeDs( ObjNam_q )

      /Free

        As400ObjFound( PxMsgQ_q : '*MSGQ' );

        Monitor;
          RcvVarLen = %Size( LICV0100 );
          RtvLicKeyInf( LICV0100
                      : RcvVarLen
                      : 'LICV0100'
                      : LICT0100
                      : 'LICT0100'
                      : '*ALL    '
                      : 'LICS0100'
                      : ERRC0100
                      );
        On-Error   *Program ;
          MsgText = Excp_MsgId + ':' + %trim(Excp_Data) + ' ' +
                  'WRKJOB JOB(' + JobNbr +'/' +
                                  %trim(JobUsr) +'/' +
                                  %trim(JobNam) + ')' +
                  ' Please see job log and dump for detail information';
          SndTxtMsg( MsgText : PxMsgQ_q );
          dump;
          return;
        EndMon;

        If  ERRC0100.BytAvl = *Zero;

          uListPtr  =  %Addr(LICV0100) + LICV0100.OfsToLicKey;
          For  IdxPrd = 1  to  LICV0100.NumLstEnt;
            MsgText         =   'Product:' +
                                LICKEYRCD.ProdId + ',' +
                                ' License:' +
                                LICKEYRCD.LicTerm + ',' +
                                ' Feature:' +
                                LICKEYRCD.Feat    + ',' +
                                ' Serial:' +
                                LICKEYRCD.SrlNbr  + ',' +
                                ' PrcGrp:' +
                                LICKEYRCD.PrcGrp;
            //                  'Exp date:'+
            //                  LICKEYRCD.ExpD ;
            // 9999999 - The license does not have an expiration date.
            // CYYMMDD
            If LICKEYRCD.ExpD <> '9999999';
               ExpD = %Date( LICKEYRCD.ExpD : *CYMD0);
               If  ( %Date() >= ExpD );
                 MsgText = %trim(MsgText) + ' expired' ;
                 SndTxtMsg( MsgText : PxMsgQ_q );
               Else ;
                 TgtD = ExpD - %Days( PxDays );
                 If ( %Date() > TgtD ) ;
                 MsgText = %trim(MsgText) + ' will be expired ' +
                         'at ' + %Char(ExpD) + '. Warning:less than ' +
                         %Char(PxDays) + ' days';
                 SndTxtMsg( MsgText : PxMsgQ_q );
                 Else;
                 MsgText = %trim(MsgText) + ' product will be expired ' +
                         'at ' + %Char(ExpD);
                 SndLogMsg( MsgText );
                 EndIf;
               EndIf;
            Else;
            SndLogMsg(MsgText);
            EndIf;

            If  IdxPrd < LICV0100.NumLstEnt;
              uListPtr  += LICV0100.SizLstEnt;
            EndIf;
          EndFor;
        Else;
          SndEscMsg( ERRC0100.MsgId
             : 'QCPFMSG'
             : %Subst(ERRC0100.MsgDta: 1:ERRC0100.BytAvl- 16 )
                    );
        EndIf;

        *InLr = *On;
        Return;

     **-- Send information message:  -----------------------------------------**
     P SndInfMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*INFO'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return  0;

        EndIf;

      /End-Free

     P SndInfMsg       E
     **-- Send completion message:  ------------------------------------------**
     P SndCmpMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*COMP'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return  0;

        EndIf;

      /End-Free

     P SndCmpMsg       E
     **-- Send text message:  ----------------------------
     P SndTxtMsg       B
     D                 Pi            10i 0
     D  PxMsgTxt                    512a   Const  Varying
     D  PxMsgQ                       20a   Const

     D MsgKey          s              4a

      /Free

         SndMsg( 'CPF9898'
               : 'QCPFMSG   *LIBL'
               : PxMsgTxt
               : %Len( PxMsgTxt )
               : '*INFO'
               : PxMsgQ_q
               : 1
               : *Blanks
               : MsgKey
               : ERRC0100
               );

         SndLogMsg( PxMsgTxt );

         If  ERRC0100.BytAvl > *Zero;
           Return -1;

         Else;
           Return 0;
         EndIf;

      /End-Free

     P SndTxtMsg       E
     **-- Send joblog message:  -------------------------
     P SndLogMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying

     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9898'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*INFO'
                 : '*EXT'
                 : *Zero
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return  0;

        EndIf;

      /End-Free

     **
     P SndLogMsg       E

     **-- Send escape message:  ---------------------------------------     --**
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a
     D MsgFQual        s             20a

      /Free

        %SubSt(MsgFQual : 1: 10) = PxMsgF;
        %SubSt(MsgFQual :11: 10) = '*LIBL';

        SndPgmMsg( PxMsgId
                 : MsgFQual
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
          Return  0;

        EndIf;

      /End-Free

     P SndEscMsg       E

      * As400ObjFound - Attempts to locate an AS/400 object
     P As400ObjFound   B

     D As400ObjFound   PI              N
     D  QlObjName                    20    Value
     D  ObjType                      10    Value

      * Local variables and prototypes

     D RtvObjDesc      PR                  ExtPgm( 'QUSROBJD' )
     D  RcvrVar                       8
     D  LenRcvrVar                   10I 0 Const
     D  FmtName                       8    Const
     D  QlObjName                    20    Const
     D  ObjType                      10    Const
     D  ApiErrInf                          Like( ApiErr )

     D ApiErr          DS
     D  AeBytesProv                  10I 0 Inz( %Size( ApiErr ) )
     D  AeBytesAvl                   10I 0
     D  AeMsgId                       7
     D                                1
     D  AeMsgDta                    256

     D Rcvr            S              8

      * Invoke the QUSROBJD API to attempt to locate the object
     C                   CallP     RtvObjDesc( Rcvr:
     C                                         %Size( Rcvr ):
     C                                         'OBJD0100':
     C                                         QlObjName:
     C                                         ObjType:
     C                                         ApiErr )

      * If the API returns any error at all, I assume we were unable to
      * locate the object.
     C                   If        AeBytesAvl > *Zero
     C                   CallP     SndEscMsg( AeMsgId
     C                                : 'QCPFMSG'
     C                                : %Subst( AeMsgDta: 1:AeBytesAvl- 16 )
     C                                       )
     C                   Return    *Off
     C                   Else
     C                   Return    *On
     C                   EndIf

     P As400ObjFound   E
