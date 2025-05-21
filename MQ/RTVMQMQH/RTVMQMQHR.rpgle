     **
     **  Program . . : RTVMQMQHR
     **  Description : Retrieve MQ Queue Handle - CPP
     **  Author  . . : Vengoal Chang
     **  Published . : AS400 ePaper
     **  Date  . . . : May 21, 2025
     **
     **
     **  Programmer's notes:
     **    Dataarea DEBUG exist => mqExecute failed enable dump
     **
     **
     **  Compile options:
     **    CrtRpgMod   Module( RTVMQMQHR )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( RTVMQMQHR )
     **                Module( RTVMQMQHR )
     **                ActGrp( MQM )
     **                BNDSRVPGM( QMQM/LIBMQM )
     **

     **-- Header specifications:  --------------------------------------------**
     H DEBUG  OPTION(*SRCSTMT:*NODEBUGIO)
     H Copyright('vengoal@gmail.com - 2025')

      //---------------------------------------------------------------------
      //‚I/O Parameters
      //---------------------------------------------------------------------
     D EntryParms      PR                  extpgm('RTVMQMQHR')
VC   D  QNAME                        48A
     D  MQMNAME                      48A
     D  JobCnt                        5  0
     D  JobList                    1400
     D  MQERROR                        N
     D  CC                           10  0
     D  RC                           10  0
     D  MQINFO                      256
     D EntryParms      PI
VC   D  QNAME                        48A
     D  MQMNAME                      48A
     D  JobCnt                        5  0
     D  JobList                    1400
     D  MQERROR                        N
     D  CC                           10  0
     D  RC                           10  0
     D  MQINFO                      256

     D ProgramSDS     SDS
     D  JOB_NAME             244    253
     D  JOB_USER             254    263
     D  JOB_NUM              264    269

     D QCMDEXC         PR                  extpgm('QCMDEXC')
     D  Cmd                        3000A   options(*varsize) const
     D  CmdL                         15P 5 const
     D                                3A   const options(*nopass)
     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      512a
     **-- Check object existence:
     D ChkObj          Pr            10a
     D  RaObjNam                     10a   Const
     D  RaObjLib                     10a   Const
     D  RaObjTyp                     10a   Const
     **-- Send diagnostic message:
     D SndDiagMsg      Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying

      //---------------------------------------------------------------------
      //  Declare MQI structures needed
      //---------------------------------------------------------------------
      //  MQI named constants
     D/COPY QMQM/QRPGLESRC,CMQG
      //  MQAI named constants
     D/COPY QRPGLESRC,CMQBG

      //---------------------------------------------------------------------
      //‚PCF structures
      //---------------------------------------------------------------------
      // PCF Constants
     D/COPY QMQM/QRPGLESRC,CMQCFG

      //---------------------------------------------------------------------
      //‚MQ start/end procedures
      //---------------------------------------------------------------------
     D MQconnect       PR              N
     D MQdisconnect    PR
     D  OptPtr                         *   Options(*Omit) Const
     D MQconnected     S               N

     D CheckResult     PR
     D  MsgTxt                      256    Const
     D  CC                           10I 0 Value
     D  RC                           10I 0 Value

      //---------------------------------------------------------------------
      //‚ILECEE Procedures
      //---------------------------------------------------------------------
      // Prototype for CEERTX (Cancel handler)
     D CEERTX          PR
     D  AddrCnclHdlr                   *   ProcPtr Const
     D  OptionalPtr                    *   Options(*Omit) Const
     D  FdBkCd                       12    Options(*Omit)
      // Prototype for CEETREC (Reclaim activation group)
     D CEETREC         PR

      * Handle connection
     D HCONN           S             10I 0
      * Options
     D OPTS            S             10I 0
      * Object handle
     D HOBJ            S             10I 0
      * Completion codes
     D compCode        S             10I 0
      * Reason
     D REASON          S             10I 0

     D Zjobcount       S             10I 0
     D ZJoblist        Ds
     D  ZJob                         28    dim(50)

     D WAIT_TIME       S             10I 0 Inz(5000)
     D AdminBag        S             10I 0 Inz(-1)
     D responseBag     S             10I 0 Inz(-1)
     D OptionsBag      S             10I 0 Inz(-1)
     D numberOfBags    S             10I 0
     D qAttrsBag       S             10I 0
     D errorBag        S             10I 0
     D i               S             10I 0
     D qNameLength     S             10I 0
     D qNameRtn        S             48
     D ccsidRtn        S             10I 0
     D mqExecuteCC     S             10I 0
     D mqExecuteRC     S             10I 0
     D qApplTag        S             28
     D qApplTagLength  S             10I 0
     D Debug           S               N
      *
      //*********************************************************************
      // MAIN
      //*********************************************************************

      /FREE

       // close request
       if %parms = 0;
         MQdisconnect (*omit);      // close MQ objects
       endif;

       // initialize caller return parameters
       MQINFO   = *blank;
       Zjobcount= 0;
       Zjoblist = ' ';
       MQERROR  = *off;
       Debug = ChkObj( 'DEBUG' : '*LIBL': '*DTAARA' );

       MQconnected = MQconnect;
       if not MQconnected;          // if failed close all
         MQINFO = %trim(MQINFO) + ':' + %trim(JOB_USER) + '/' +
                  %trim(JOB_NAME) + '/' +  %trim(JOB_NUM);
         MQdisconnect (*omit);
       endif;

       // Create an admin bag for the mqExecute call
       MQCRTBG(MQCBOADMINBAG: adminBag: compCode : reason);
       CheckResult('Create admin bag' : compCode : reason);

       // Create an response bag for the mqExecute call
       MQCRTBG(MQCBOADMINBAG: responseBag  : compCode : reason);
       CheckResult('Create response bag' : compCode : reason);

       // Create an options bag to set the timeout value of the mqexecute call
       if (compCode  =  CCOK);
         MQCRTBG(MQCBOUSERBAG : optionsBag  : compCode : reason);
         CheckResult('Create options bag' : compCode : reason);
         if (compCode  = CCOK and reason =  RCNONE);
         // mqAddInteger(optionsBag, MQIACF_WAIT_INTERVAL, WAIT_TIME, &compCode, &reason);
            MQADDIN(optionsBag: IAFWTI : WAIT_TIME: compCode: reason);
         endif;
         if (compCode <> CCOK);
               optionsBag = MQHB_NONE;  // default wait time 30 seconds.
               compCode   = CCOK;
               reason     = RCNONE;
         endif;
       endif;

       //Put the generic queue name into the admin bag
       //mqAddString(adminBag, MQCA_Q_NAME, MQBL_NULL_TERMINATED, queueName, &compCode, &reason);
       MQADDST(adminBag: CAQN: %Len(%Trim(QName)):
                         %addr(QName): compCode: reason);
       CheckResult('Add q name': compCode: reason);

       //Put the inquire queue status type into the admin bag
       //mqAddInteger(adminBag, MQIACF_Q_STATUS_TYPE, MQIACF_Q_HANDLE, &compCode, &reason);
       MQADDIN(adminBag: IAFQST: IAFQH: compCode: reason);
       CheckResult('Add inquire q status type': compCode: reason);

       //Add the inquire Queue status attributes to the admin bag
       //mqAddInteger(adminBag, MQIACF_Q_STATUS_ATTRS, MQIACF_ALL     , &compCode, &reason);
       MQADDIN(adminBag: IAFQSA: IAFALL: compCode: reason);
       CheckResult('Add inquire q handle attr': compCode: reason);

       // mqExecute(hConn,                   /* MQ connection handle                 *
       //           MQCMD_INQUIRE_Q_STATUS,  /* Command to be executed               *
       //           optionsBag,              /* No options bag                       *
       //           adminBag,                /* Handle to bag containing commands    *
       //           responseBag,             /* Handle to bag to receive the response*
       //           MQHO_NONE,               /* Put msg on SYSTEM.ADMIN.COMMAND.QUEUE*
       //           MQHO_NONE,               /* Create a dynamic q for the response  *
       //           &compCode,               /* Completion code from the mqexecute   *
       //           &reason);                /* Reason code from mqexecute call      *
       MQEXEC(hConn:
                 CMINQS:
                 optionsBag:
                 adminBag:
                 responseBag:
                 HONONE:
                 HONONE:
                 compCode:
                 reason);
       // Check the command server is started. If not exit.
       if (reason = RC2322);   //MQRC_CMD_SERVER_NOT_AVAILABLE
          CheckResult('Please start the command server for ' +
                   'QMGR ' + %trim(MQMName) : compCode : reason);
          MQdisconnect (*omit);
       endif;

       // Check the result from mqExecute call.
       if ( compCode =  CCOK );                     // Successful mqExecute    */
         // Count the number of system bags embedded in the response bag
         //mqCountItems(responseBag, MQHA_BAG_HANDLE, &numberOfBags, &compCode, &reason);
         MQCNTIT(responseBag: MQHA_BAG_HDL: numberOfBags: compCode: reason);
         CheckResult('Count number of bag handles': compCode: reason);

         for i=0 TO (numberOfBags-1);
          //mqInquireBag(responseBag, MQHA_BAG_HANDLE, i, &qAttrsBag, &compCode, &reason);
            MQINQBG(responseBag: MQHA_BAG_HDL: i: qAttrsBag: compCode: reason);
            CheckResult('Get the result bag handle': compCode: reason);

          // Get the queue name out of the queue attributes bag
          //mqInquireString(qAttrsBag, MQCA_Q_NAME, 0, MQ_Q_NAME_LENGTH, qName,
          //              &qNameLength, NULL, &compCode, &reason);
            MQINQST(qAttrsBag: CAQN : 0: LNQN: %addr(qNameRtn):
                          qNameLength: ccsidRtn: compCode: reason);
            CheckResult('Get queue name': compCode: reason);

          //mqInquireString(qAttrsBag, MQCACF_APPL_TAG, 0, MQ_APPL_TAG_LENGTH,
          //                qApplTag,&qApplTagLength,NULL, &compCode, &reason);
            MQINQST(qAttrsBag: CAFAPT: 0: LNAPPN: %addr(qApplTag):
                          qApplTagLength: ccsidRtn: compCode: reason);
            CheckResult('Get ApplTag   ': compCode: reason);

            ZJobcount = i+1;
            ZJob(ZJobcount) = qApplTag;
         endfor;

         JobCnt = ZJobcount;
         JobList= ZJoblist ;
         MQERROR  = *off;
         CC       = CCOK;
         RC       = RCNONE;
         MQINFO   = ' ';
       else;                                        // Failed     mqExecute    */
        CheckResult('Call to get queue attributes': compCode:reason);
        if (reason = RC3008);  // MQRCCF_COMMAND_FAILED
          //mqInquireBag(responseBag, MQHA_BAG_HANDLE, 0, &errorBag, &compCode, &reason);
           MQINQBG(responseBag: MQHA_BAG_HDL: 0:
                                errorBag: compCode: reason);
           CheckResult('Get the result bag handle': compCode: reason);

          //mqInquireInteger(errorBag, MQIASY_COMP_CODE, MQIND_NONE, &mqExecuteCC,
          //               &compCode, &reason );
           MQINQIN(errorBag: MQIASY_COMPCOD: MQIND_NONE: mqExecuteCC:
                             compCode: reason );
           CheckResult('Get the completion code from the result bag':
                       compCode: reason);
         //mqInquireInteger(errorBag, MQIASY_REASON, MQIND_NONE, &mqExecuteRC,
         //                &compCode, &reason);
           MQINQIN(errorBag: MQIASY_REASON: MQIND_NONE: mqExecuteRC:
                           compCode: reason);
           CheckResult('Get the reason code from the result bag':
                                                        compCode: reason);
           CheckResult('Error returned by the command server':
                                                mqExecuteCC: mqExecuteRC);
        endif;

        JobCnt = ZJobcount;
        JobList= ZJoblist ;
        MQERROR  = *on;
        CC       = mqExecuteCC;
        RC       = mqExecuteRC; // 4091 - MQRCCF_Q_STATUS_NOT_FOUND

        If Debug;
          dump;
        endif;

       endif;

       if (adminBag <> MQHB_UNUSBLHB );
          //mqDeleteBag(&adminBag, &compCode, &reason);
          MQDELBG(adminBag: compCode: reason);
          CheckResult('Delete the admin bag': compCode: reason);
       endif;

       if (responseBag <> MQHB_UNUSBLHB );
          //mqDeleteBag(&adminBag, &compCode, &reason);
          MQDELBG(responseBag: compCode: reason);
          CheckResult('Delete the respopnse bag': compCode: reason);
       endif;

       if (optionsBag <> MQHB_UNUSBLHB );
          //mqDeleteBag(&adminBag, &compCode, &reason);
          MQDELBG(optionsBag: compCode: reason);
          CheckResult('Delete the options bag': compCode: reason);
       endif;

       // keep connection to MQ alive
       return;

      /END-FREE

      ****************************************************************
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      //‚CheckResult
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P CheckResult     B
     D CheckResult     PI
     D  MsgTxt                      256    Const
     D  CC                           10I 0 VALUE
     D  RC                           10I 0 VALUE

     D  MsgDta         S            256    Varying

      /FREE

        if (cc <> CCOK);
          MqInfo = %trim(Msgtxt) + ' failed: Completion Code = ' +
                   %char(CC) +' : Reason = ' + %char(RC);
          MsgDta = %trim(MqInfo);
          SndDiagMsg( 'CPF9898': MsgDta );
        endif;

      /END-FREE

     P CheckResult     E

      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      //‚Connect to MQ
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P MQconnect       B
     D MQconnect       PI              n

      /FREE

       // Register cancel handler and activation group exit
       CEERTX(%Paddr(MQdisconnect):*Omit: *Omit);

       //---------------------------------------------------------------------
       // Connect to the queue manager
       //---------------------------------------------------------------------

       MQCONN(MQMNAME : HCONN : COMPCODE : REASON);
       if COMPCODE = CCFAIL;         // ... stop if failed
         MQINFO = 'MQCONN RC' + %char(REASON) + ' COMPCODE=' +%char(COMPCODE);
         MQERROR  = *on;
         CC = COMPCODE;
         RC = REASON;
         RETURN *off;
       endif;

       return *on;                 // set MQ started indicator

      /END-FREE

     P MQconnect       E

      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P MQdisconnect    B
     D MQdisconnect    PI
     D  OptPtr                         *   Options(*Omit) Const

      /FREE

       If MQconnected;
         // Disconnect from the queue manager
         MQDISC(HCONN : COMPCODE : REASON);
       Endif;

       QCMDEXC('RCLRSC': 6);     // reclaim resources
       CEETREC();                // reclaim activation group QMQM

      /END-FREE

     P MQdisconnect    E
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     **-- Check object existence:  -------------------------------------------**
     P ChkObj          B                   Export
     D                 Pi            10a
     D  RaObjNam                     10a   Const
     D  RaObjLib                     10a   Const
     D  RaObjTyp                     10a   Const
     **-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RoRcvVar                  32767a          Options( *VarSize )
     D  RoRcvVarLen                  10i 0 Const
     D  RoFmtNam                      8a   Const
     D  RoObjNamQ                    20a   Const
     D  RoObjTyp                     10a   Const
     D  RoError                   32767a          Options( *VarSize )
     **
     D OBJD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a

      /Free

         RtvObjD( OBJD0100
                : %Size( OBJD0100 )
                : 'OBJD0100'
                : RaObjNam + RaObjLib
                : RaObjTyp
                : ERRC0100
                );

         If  ERRC0100.BytAvl > *Zero;
           Return  *Off;

         Else;
           Return  *On;
         EndIf;

      /End-Free

     P ChkObj          E
     **-- Send diagnostic message:  ------------------------------------------**
     P SndDiagMsg      B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  SpMsgId                       7a   Const
     D  SpMsgFq                      20a   Const
     D  SpMsgDta                    128a   Const
     D  SpMsgDtaLen                  10i 0 Const
     D  SpMsgTyp                     10a   Const
     D  SpCalStkE                    10a   Const  Options( *VarSize )
     D  SpCalStkCtr                  10i 0 Const
     D  SpMsgKey                      4a
     D  SpError                    1024a          Options( *VarSize )
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*DIAG'
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

     P SndDiagMsg      E
