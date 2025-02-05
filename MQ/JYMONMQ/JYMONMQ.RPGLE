      //********************************************************************-                               
      // MQ - Monitor                                                                                       
      //---------------------------------------------------------------------                               
      // BeppeCostagliola - 2007                                                                            
      //********************************************************************-                               
                                                                                                            
     H Dftactgrp(*NO) Actgrp('MQM')                                                                         
     H BndDir('MQM')                                                                                        
     H Copyright('beppecosta@yahoo.it - 2007')                                                              
                                                                                                            
      //---------------------------------------------------------------------                               
      //‚I/O Parameters                                                                                     
      //---------------------------------------------------------------------                               
     D EntryParms      PR                  extpgm('JYMONMQ')                                                
     D  MQOBJNAME                    64A                                                                    
     D  MQOBJTYPE                    10A                                                                    
     D  MQSTATUS                     10A                                                                    
     D  MQINFO                      120A                                                                    
     D  MQERROR                        N                                                                    
     D EntryParms      PI                                                                                   
     D  MQOBJNAME                    64A                                                                    
     D  MQOBJTYPE                    10A                                                                    
     D  MQSTATUS                     10A                                                                    
     D  MQINFO                      120A                                                                    
     D  MQERROR                        N                                                                    
                                                                                                            
      //---------------------------------------------------------------------                               
      //‚Commom MQ parameters                                                                               
      //---------------------------------------------------------------------                               
      // Queue manager name                                                                                 
     D QMNAME          S             48A                                                                    
      // Connection Handle                                                                                  
     D HCONN           S             10I 0                                                                  
      // Options                                                                                            
     D OPTS            S             10I 0                                                                  
      // Queue handles                                                                                      
     D HSEND           S             10I 0                                                                  
     D HREPLY          S             10I 0                                                                  
      // Completion codes                                                                                   
     D CMPCOD          S             10I 0                                                                  
      // Reason                                                                                             
     D REASON          S             10I 0                                                                  
      // BUFFER PUT/GET                                                                                     
     D BUFFER          S           2000A                                                                    
      // BUFFER length                                                                                      
     D BUFLEN          S             10I 0                                                                  
      // BUFFER offset                                                                                      
     D BUFOFF          S             10I 0                                                                  
      // BUFFER pointers                                                                                    
     D BUFPTR          S               *                                                                    
      // Message length                                                                                     
     D MSGLEN          S             10I 0                                                                  
      // Queues names                                                                                       
     D QSEND           C                   CONST('SYSTEM.ADMIN.COMMAND.QUEUE')                              
     D QREPLY          C                   CONST('SYSTEM.ADMIN.REPLYQ.JYMON')                               
      // Message marker                                                                                     
     D RQSID           S                   LIKE(MQMD.MDCID)                                                 
                                                                                                            
      //---------------------------------------------------------------------                               
      //‚MQI structures                                                                                     
      //---------------------------------------------------------------------                               
      // MQI named constants                                                                                
     D/COPY QMQM/QRPGLESRC,CMQG                                                                             
      // Object Descriptors - target, reply                                                                 
     D MQOD            DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQODG                                                                           
      // Message Descriptor                                                                                 
     D MQMD            DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQMDG                                                                           
      // Put message options                                                                                
     D MQPMO           DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQPMOG                                                                          
      // Get message options                                                                                
     D MQGMO           DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQGMOG                                                                          
                                                                                                            
      //---------------------------------------------------------------------                               
      //‚PCF structures                                                                                     
      //---------------------------------------------------------------------                               
      // PCF Constants                                                                                      
     D/COPY QMQM/QRPGLESRC,CMQCFG                                                                           
      // PCF Header                                                                                         
     D MQCFH           DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQCFHG                                                                          
      // PCF String parameter                                                                               
     D MQCFST          DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQCFSTG                                                                         
     D STDTA                       1024                                                                     
      // PCF Integer parameter                                                                              
     D MQCFIN          DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQCFING                                                                         
      // PCF Integer list parameter                                                                         
     D MQCFIL          DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQCFILG                                                                         
     D ILATR                          9B 0 dim(10)                                                          
      // PCF Response type                                                                                  
     D PCFRspType      DS                                                                                   
     D  PCFType                       9B 0                                                                  
                                                                                                            
      //---------------------------------------------------------------------                               
      //‚MQ start/end procedures                                                                            
      //---------------------------------------------------------------------                               
     D MQconnect       PR              N                                                                    
     D MQdisconnect    PR                                                                                   
     D  OptPtr                         *   Options(*Omit) Const                                             
     D MQconnected     S               N                                                                    
                                                                                                            
      //---------------------------------------------------------------------                               
      //‚Local procedures                                                                                   
      //---------------------------------------------------------------------                               
     D CrtListSpace    PR                                                                                   
     D InquireMQJob    PR              N                                                                    
     D  MQJobName                    26A   Const                                                            
     D InquireQMGR     PR                                                                                   
     D InquireChlSts   PR                                                                                   
     D InquireQueue    PR                                                                                   
     D InquireEvent    PR                                                                                   
     D GetQMGR         PR                                                                                   
     D GetChlSts       PR                                                                                   
     D GetQueue        PR                                                                                   
                                                                                                            
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
                                                                                                            
      //---------------------------------------------------------------------                               
      //‚Global API's                                                                                       
      //---------------------------------------------------------------------                               
     D QUSLJOB         PR                  extpgm('QUSLJOB')                                                
     D  UserSpace                    20    const                                                            
     D  FormatName                    8    const                                                            
     D  QualJobName                  26    const                                                            
     D  Status                       10    const                                                            
     D  ApiError                     50    const options(*varsize)                                          
     D QCMDEXC         PR                  extpgm('QCMDEXC')                                                
     D  Cmd                        3000A   options(*varsize) const                                          
     D  CmdL                         15P 5 const                                                            
     D                                3A   const options(*nopass)                                           
      // User space header                                                                                  
     D Header          ds                  based(pHeader)                                                   
      * Offset List Data                                                                                    
     D qusold                125    128B 0                                                                  
      * Number List Entries                                                                                 
     D qusnbrle              133    136B 0                                                                  
      * Size Each Entry                                                                                     
     D qussee                137    140B 0                                                                  
      // Standard API error                                                                                 
     D ApiError        DS                                                                                   
     D  ErrBPrv                       9B 0 Inz(%Size(ApiError))                                             
     D  ErrBAvl                       9B 0                                                                  
     D  ErrMsgId                      7A                                                                    
     D                                1A                                                                    
     D  ErrDta                      128A                                                                    
                                                                                                            
      //---------------------------------------------------------------------                               
      //‚MQ Manager Response Data                                                                           
      //---------------------------------------------------------------------                               
                                                                                                            
      //‚Inquire Command Server (Response)                                                                  
     D MQCmdServer     S               N                                                                    
                                                                                                            
      //‚Inquire Queue Manager (Response)                                                                   
     D MQManager       S               N                                                                    
     D QMgrName        S             48A                                                                    
     D QMgrDesc        S             64A                                                                    
     D CmdInputQname   S             48A                                                                    
                                                                                                            
      //‚Inquire Channel Status (Response)                                                                  
     D ChannelName     S             20A                                                                    
     D XmitQname       S             48A                                                                    
     D ConnectionName  S            264A                                                                    
     D ChannelType     S             10A                                                                    
     D ChannelStatus   S             12A                                                                    
     D ChannelMsgs     S             10A                                                                    
     D ChannelMCASts   S             12A                                                                    
                                                                                                            
      //‚Inquire Queue (Response)                                                                           
     D QType           S             10A                                                                    
     D QDesc           S             64A                                                                    
     D Usage           S             12A                                                                    
     D MessagesOnQ     S             12A                                                                    
     D OpenInputCnt    S             12A                                                                    
     D OpenOutputCnt   S             12A                                                                    
                                                                                                            
      //---------------------------------------------------------------------                               
      // Miscellaneous                                                                                      
      //---------------------------------------------------------------------                               
     D r               S             10I 0                                                                  
                                                                                                            
     D ProgramSDS     SDS                                                                                   
     D  JOB_NAME             244    253                                                                     
     D  JOB_USER             254    263                                                                     
     D  JOB_NUM              264    269                                                                     
                                                                                                            
      //*********************************************************************                               
      // MAIN                                                                                               
      //*********************************************************************                               
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
       // close request                                                                                     
       if %parms = 0;                                                                                       
         MQdisconnect (*omit);      // close MQ objects                                                     
       endif;                                                                                               
                                                                                                            
       // initialize caller return parameters                                                               
       MQSTATUS = *blank;                                                                                   
       MQINFO   = *blank;                                                                                   
       MQERROR  = *off;                                                                                     
                                                                                                            
       // initialize list space                                                                             
       if pHeader = *null;                                                                                  
         CrtListSpace();                                                                                    
       endif;                                                                                               
                                                                                                            
       //---------------------------------------------------------------------                              
       //‚check MQ activity                                                                                 
       //---------------------------------------------------------------------                              
                                                                                                            
       if not MQManager;                                                                                    
         MQManager = InquireMQJob('AMQALMPX  QMQM      *ALL  ');                                            
         if not MQManager;                                                                                  
           MQSTATUS = '*ERROR';                                                                             
           MQINFO = 'MQ Manager Inactive';                                                                  
           MQERROR  = *on;                                                                                  
           MQdisconnect (*omit);                                                                            
         endif;                                                                                             
       endif;                                                                                               
                                                                                                            
       if not MQCmdServer;                                                                                  
         MQCmdServer = InquireMQJob('AMQPCSEA  QMQM      *ALL  ');                                          
         if not MQCmdServer;                                                                                
           MQSTATUS = '*ERROR';                                                                             
           MQINFO = 'MQ CmdSever Inactive';                                                                 
           MQERROR  = *on;                                                                                  
           MQdisconnect (*omit);                                                                            
         endif;                                                                                             
       endif;                                                                                               
                                                                                                            
       //---------------------------------------------------------------------                              
       //‚connect and open system queues                                                                    
       //---------------------------------------------------------------------                              
                                                                                                            
       MQconnected = MQconnect;                                                                             
       if not MQconnected;          // if failed close all                                                  
         MQINFO = %trim(MQINFO) + ':' + %trim(JOB_USER) + '/' +                                             
                  %trim(JOB_NAME) + '/' +  %trim(JOB_NUM);                                                  
         MQdisconnect (*omit);                                                                              
       endif;                                                                                               
                                                                                                            
       //---------------------------------------------------------------------                              
       //‚Setup common MQ parameters                                                                        
       //---------------------------------------------------------------------                              
                                                                                                            
       BUFFER  = *blanks;                                                                                   
       BUFPTR  = %addr(BUFFER);                                                                             
       BUFOFF  = 1;                                                                                         
                                                                                                            
       // MQMD - Message descriptor                                                                         
       MQMD.MDMT    = MTRQST;     // Message type MQMT_REQUEST                                              
       MQMD.MDFMT   = 'MQADMIN';  // Message format MQFMT_ADMIN                                             
       MQMD.MDREP   = ROEXCD;     // Report option MQRO_EXCEPTION_WITH_DATA                                 
       MQMD.MDRQ    = QREPLY;     // name the queue for all responses                                       
                                                                                                            
       //---------------------------------------------------------------------                              
       //‚Setup MQ request                                                                                  
       //---------------------------------------------------------------------                              
                                                                                                            
       select;                                                                                              
         when MQOBJTYPE = '*MQM';    // Queue Manager                                                       
           InquireQMGR();                                                                                   
         when MQOBJTYPE = '*CHL';    // Channel                                                             
           InquireChlSts();                                                                                 
         when MQOBJTYPE = '*Q';      // Queue                                                               
           InquireQueue();                                                                                  
         when MQOBJTYPE = '*EVNT';   // Event                                                               
           InquireEvent();                                                                                  
       endsl;                                                                                               
                                                                                                            
       //---------------------------------------------------------------------                              
       //‚Put request messages to the server queue                                                          
       //---------------------------------------------------------------------                              
                                                                                                            
       MQPUT(HCONN: HSEND: MQMD: MQPMO: BUFLEN: BUFPTR: CMPCOD: REASON);                                    
       IF REASON <> RCNONE;          // stop if failed                                                      
         MQINFO = 'MQPUT' + ' ' + %char(REASON) + %char(CMPCOD);                                            
         MQSTATUS = '*ERROR';                                                                               
         MQERROR  = *on;                                                                                    
         RETURN;                                                                                            
       ENDIF;                                                                                               
                                                                                                            
       //---------------------------------------------------------------------                              
       //‚Get the reply messages                                                                            
       //---------------------------------------------------------------------                              
                                                                                                            
       BUFLEN = %len(BUFFER);         // lenght of reply available                                          
       RQSID = MQMD.MDMID;            // set correlation id selector                                        
                                                                                                            
       //  Start loop to get reply messages                                                                 
       dow CMPCOD <> CCFAIL;                                                                                
                                                                                                            
         // initialize parameters                                                                           
         MQGMO.GMVER  = GMVER2;        // Struct Version = MQGMO_VERSION_2                                  
         MQGMO.GMWI   = 10000;         // Wait 10 seconds                                                   
         MQGMO.GMOPT  = GMWT;          // Opt MQGMO_WAIT                                                    
         MQGMO.GMOPT += GMATM;         // Opt MQGMO_ACCEPT_TRUNCATED_MSG                                    
         MQMD.MDMID   = MINONE;        // Message Identifier = MQMI_NONE                                    
         MQMD.MDCID   = RQSID;         // Correlation Identifier                                            
                                                                                                            
         // get reply from Q                                                                                
         BUFFER = *blanks;      // clear input buffer                                                       
         MQGET(HCONN: HREPLY: MQMD: MQGMO: BUFLEN: BUFPTR:                                                  
               MSGLEN: CMPCOD: REASON);                                                                     
                                                                                                            
         // report reason, if any                                                                           
         select;                                                                                            
           when REASON = RCNONE;                                                                            
             //  specific text for "no message"                                                             
           when REASON = RC2033;                                                                            
             //  specific text for "truncated message"                                                      
           when MSGLEN > BUFLEN;                                                                            
             //  otherwise say "MQGET ended with reason code ...."                                          
         other;                                                                                             
           MQINFO = 'MQGET' + ' ' + %char(REASON) + %char(CMPCOD);                                          
           MQSTATUS = '*ERROR';                                                                             
           MQERROR  = *on;                                                                                  
         endsl;                                                                                             
                                                                                                            
         // stop if failed                                                                                  
         if CMPCOD = CCFAIL;                                                                                
           leave;                                                                                           
         endif;                                                                                             
                                                                                                            
         // get the response                                                                                
         select;                                                                                            
           when MQOBJTYPE = '*MQM';                                                                         
             GetQMGR();                                                                                     
           when MQOBJTYPE = '*CHL';                                                                         
             GetChlSts();                                                                                   
           when MQOBJTYPE = '*Q';                                                                           
             GetQueue();                                                                                    
         endsl;                                                                                             
                                                                                                            
         //  end DO-while loop after last message                                                           
         if MQCFH.FHCTL = CFCLST;                                                                           
           leave;                                                                                           
         endif;                                                                                             
                                                                                                            
       enddo;                                                                                               
                                                                                                            
       // keep connection to MQ alive                                                                       
       return;                                                                                              
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
      //‚Create user space for lists                                                                        
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
     P CrtListSpace    B                                                                                    
     D CrtListSpace    PI                                                                                   
                                                                                                            
     D QUSCRTUS        PR                  extpgm('QUSCRTUS')                                               
     D  UserSpace                    20    const                                                            
     D  ExtendedAtr                  10    const                                                            
     D  InitialSize                   9B 0 const                                                            
     D  InitialValue                  1    const                                                            
     D  PublicAuth                   10    const                                                            
     D  Text                         50    const                                                            
     D  Replace                      10    const                                                            
     D  ApiError                    120    options(*varsize)                                                
     D  Domain                       10    options(*nopass)                                                 
     D QUSPTRUS        PR                  extpgm('QUSPTRUS')                                               
     D  UserSpace                    20    const                                                            
     D  UserSpacePtr                   *                                                                    
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
       // create the list space                                                                             
       QUSCRTUS ('QUSLJOB   QTEMP     ' : ' ' : 200000 : X'00' :                                            
                 '*ALL' : 'Space per QUSLJOB' : '*NO' : ApiError);                                          
       // address to the list                                                                               
       QUSPTRUS ('QUSLJOB   QTEMP     ' : pHeader);                                                         
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P CrtListSpace    E                                                                                    
                                                                                                            
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
      //‚Inquire MQ jobs                                                                                    
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
     P InquireMQJob    B                                                                                    
     D InquireMQJob    PI              N                                                                    
     D  MQJobName                    26A   Const                                                            
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
       // get the MQ job name                                                                               
       Reset ApiError;                                                                                      
       QUSLJOB ('QUSLJOB   QTEMP     ' : 'JOBL0100' :                                                       
                MQJobName : '*ACTIVE' : ApiError);                                                          
       if ErrMsgId <> *blanks or qusnbrle <= 0;                                                             
         return *off;                                                                                       
       else;                                                                                                
         return *on;                                                                                        
       endif;                                                                                               
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P InquireMQJob    E                                                                                    
                                                                                                            
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
                                                                                                            
       QMNAME = *blank;            // Default queue manager                                                 
       MQCONN(QMNAME : HCONN : CMPCOD : REASON);                                                            
       if CMPCOD = CCFAIL;         // ... stop if failed                                                    
         MQINFO = 'MQCONN' + ' ' + %char(REASON) + %char(CMPCOD);                                           
         MQSTATUS = '*ERROR';                                                                               
         MQERROR  = *on;                                                                                    
         RETURN *off;                                                                                       
       endif;                                                                                               
                                                                                                            
       //---------------------------------------------------------------------                              
       // Open the server message queue for output (and fail if                                             
       // MQM is quiescing) - Resulting queue handle is HSEND                                               
       //---------------------------------------------------------------------                              
                                                                                                            
       MQOD.ODON = QSEND;          // SYSTEM.ADMIN.COMMAND.QUEUE                                            
       OPTS = OOOUT + OOFIQ;       // Output + Fail-if-quiescing                                            
       MQOPEN(HCONN: MQOD: OPTS: HSEND: CMPCOD: REASON); // Open ....                                       
       if REASON <> RCNONE;        // ... stop if failed                                                    
         MQINFO = 'MQOPEN' + ' ' + %char(REASON) + %char(CMPCOD);                                           
         MQSTATUS = '*ERROR';                                                                               
         MQERROR  = *on;                                                                                    
         return *off;                                                                                       
       endif;                                                                                               
                                                                                                            
       //---------------------------------------------------------------------                              
       //   Open the queue to receive reply messages                                                        
       //   Resulting queue handle is HREPLY                                                                
       //---------------------------------------------------------------------                              
                                                                                                            
       MQOD.ODON = QREPLY;         // reply queue name                                                      
       OPTS = OOINPS + OOFIQ;      // Sh-Input + Fail-if-quiescing                                          
       MQOPEN(HCONN: MQOD: OPTS: HREPLY: CMPCOD: REASON);   // Open ....                                    
       if REASON <> RCNONE;        // ... stop if failed                                                    
         MQINFO = 'MQOPEN' + ' ' + %char(REASON) + %char(CMPCOD);                                           
         MQSTATUS = '*ERROR';                                                                               
         MQERROR  = *on;                                                                                    
         return *off;                                                                                       
       endif;                                                                                               
                                                                                                            
       return *on;                 // set MQ started indicator                                              
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P MQconnect       E                                                                                    
                                                                                                            
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
      //‚Inquire Queue Manager                                                                              
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
     P InquireQMGR     B                                                                                    
     D InquireQMGR     PI                                                                                   
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
       // MQCFH - PCF header                                                                                
       reset MQCFH;                                                                                         
       MQCFH.FHCMD  = CMINQM;      // Cmd identifier = MQCMD_INQUIRE_Q_MGR                                  
       MQCFH.FHCNT  = 0;           // Count of parameter structures                                         
       BUFFER  = MQCFH;            // Move MQCFH to Msg                                                     
       BUFLEN  = MQCFH.FHLEN;      // Length of Msg                                                         
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P InquireQMGR     E                                                                                    
                                                                                                            
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
      //‚Inquire Channel Status                                                                             
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
     P InquireChlSts   B                                                                                    
     D InquireChlSts   PI                                                                                   
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
       // MQCFH - PCF header                                                                                
       reset MQCFH;                                                                                         
       MQCFH.FHCMD  = CMINCS;      // Cmd = MQCMD_INQUIRE_CHANNEL_STATUS                                    
       MQCFH.FHCNT  = 3;           // Count of parameter structures                                         
       BUFFER  = MQCFH;            // Move MQCFH to Msg                                                     
       BUFLEN  = MQCFH.FHLEN;      // Length of Msg                                                         
       BUFOFF += MQCFH.FHLEN;      // BUFFER offset for next parameter                                      
                                                                                                            
       // MQCFST - PCF string - first parameter                                                             
       reset MQCFST;                                                                                        
       MQCFST.STPRM   = CAHCHN;    // Prm id = MQCACH_CHANNEL_NAME                                          
       MQCFST.STDTA   = MQOBJNAME; // String = Channel name                                                 
       MQCFST.STSTL   = LNCHN;     // Prm Lng = MQ_CHANNEL_NAME_LENGTH                                      
       MQCFST.STLEN  += MQCFST.STSTL;  // Add Lng to Structure lng                                          
       %subst(BUFFER:BUFOFF) = MQCFST; // Append Structure MQCFST to Msg                                    
       BUFLEN += MQCFST.STLEN;     // Add Lng of Structure to Buffer lng                                    
       BUFOFF += MQCFST.STLEN;     // Buffer offset for next parameter                                      
                                                                                                            
       // MQCFIN - PCF integer - second parameter                                                           
       reset MQCFIN;         // Reset PCF integer                                                           
       MQCFIN.INPRM  = IAHCIT;     // Prm id = MQIACH_CHANNEL_INSTANCE_T    YPE                             
       MQCFIN.INVAL  = OTCURC;     // Value = MQOT_CURRENT_CHANNEL                                          
       %subst(BUFFER:BUFOFF) = MQCFIN; // Append Structure MQCFIN to Msg                                    
       BUFLEN += MQCFIN.INLEN;     // Add Length of MQCFIN to Buffer Length                                 
       BUFOFF += MQCFIN.INLEN;     // Buffer offset for next parameter                                      
                                                                                                            
       // MQCFIL - PCF integer list - third parameter                                                       
       reset MQCFIL;         // Reset PCF integer list                                                      
       MQCFIL.ILPRM  = IAHCIA;     // Prm id = MQIACH_CHANNEL_INSTANCE_ATTRSYPE                             
       MQCFIL.ILCNT  = 2;          // Count of parameter values             YPE                             
       MQCFIL.ILATR(1) = IAHMCS;   // Value = MQIACH_MCA_STATUS                                             
       MQCFIL.ILATR(2) = IAHMSG;   // Value = MQIACH_MSGS                                                   
       MQCFIL.ILLEN += 8;          // Add Lng of ATR * 2                                                    
       %subst(BUFFER:BUFOFF) = MQCFIL; // Append Structure MQCFIN to Msg                                    
       BUFLEN += MQCFIL.ILLEN;     // Add Lng of MQCFIL to Buffer Length                                    
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P InquireChlSts   E                                                                                    
                                                                                                            
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
      //‚Inquire Queue                                                                                      
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
     P InquireQueue    B                                                                                    
     D InquireQueue    PI                                                                                   
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
       // MQCFH - PCF header                                                                                
       reset MQCFH;                                                                                         
       MQCFH.FHCMD  = CMINQ;       // Cmd = MQCMD_INQUIRE_Q (13)                                            
       MQCFH.FHCNT  = 2;           // Count of parameter structures                                         
       BUFFER  = MQCFH;            // Move MQCFH to Msg                                                     
       BUFLEN  = MQCFH.FHLEN;      // Length of Msg                                                         
       BUFOFF += MQCFH.FHLEN;      // BUFFER offset for next parameter                                      
                                                                                                            
       // MQCFST - PCF string - first parameter                                                             
       reset MQCFST;                                                                                        
       MQCFST.STPRM   = CAQN;      // Prm id = MQCA_Q_NAME (2016)                                           
       MQCFST.STDTA   = MQOBJNAME; // String = Queue Name                                                   
       MQCFST.STSTL   = LNQN;      // Prm Lng = MQ_Q_NAME_LENGTH (48)                                       
       MQCFST.STLEN  += MQCFST.STSTL;  // Add Lng to Structure lng                                          
       %subst(BUFFER:BUFOFF) = MQCFST; // Append Structure MQCFST to Msg                                    
       BUFLEN += MQCFST.STLEN;     // Add Lng of Structure to Buffer lng                                    
       BUFOFF += MQCFST.STLEN;     // Buffer offset for next parameter                                      
                                                                                                            
       // MQCFIL - PCF integer list - second parameter                                                      
       reset MQCFIL;         // Reset PCF integer list                                                      
       MQCFIL.ILPRM  = IAFQA;      // Prm id = MQIACF_Q_ATTRS (1002)        YPE                             
       MQCFIL.ILCNT  = 6;          // Count of parameter values             YPE                             
       MQCFIL.ILATR(1) = IAQTYP;   // Value = MQIA_Q_TYPE (20)                                              
       MQCFIL.ILATR(2) = CAQD;     // Value = MQCA_Q_DESC (2013)                                            
       MQCFIL.ILATR(3) = IADEFT;   // Value = MQIA_DEFINITION_TYPE (7)                                      
       MQCFIL.ILATR(4) = IACDEP;   // Value = MQIA_CURRENT_Q_DEPTH (3)                                      
       MQCFIL.ILATR(5) = IAOIC;    // Value = MQIA_OPEN_INPUT_COUNT (17)                                    
       MQCFIL.ILATR(6) = IAOOC;    // Value = MQIA_OPEN_OUTPUT_COUNT (18)                                   
       MQCFIL.ILLEN += 25;         // Add Lng of ATR * 5                                                    
       %subst(BUFFER:BUFOFF) = MQCFIL; // Append Structure MQCFIN to Msg                                    
       BUFLEN += MQCFIL.ILLEN;     // Add Lng of MQCFIL to Buffer Length                                    
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P InquireQueue    E                                                                                    
                                                                                                            
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
      //‚Inquire Event                                                                                      
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
     P InquireEvent    B                                                                                    
     D InquireEvent    PI                                                                                   
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P InquireEvent    E                                                                                    
                                                                                                            
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
      //‚Get Queue Manager                                                                                  
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
     P GetQMGR         B                                                                                    
     D GetQMGR         PI                                                                                   
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
         reset MQManager;                                                                                   
         reset QMgrName;                                                                                    
         reset QMgrDesc;                                                                                    
         reset CmdInputQname;                                                                               
                                                                                                            
         // extract the header                                                                              
         BUFOFF = 1;                                                                                        
         MQCFH  = BUFFER;                                                                                   
                                                                                                            
         // if Completion = OK                                                                              
         if MQCFH.FHCMP = CRC000;                                                                           
           // ... extract the response data                                                                 
           BUFOFF += MQCFH.FHLEN;                                                                           
           for r = 1 to MQCFH.FHCNT;                                                                        
             PCFRspType = %subst(BUFFER:BUFOFF:4);                                                          
             if PCFType = CFTSTR;                                                                           
               MQCFST  = %subst(BUFFER:BUFOFF);                                                             
               // select type                                                                               
               select;                                                                                      
                 // Queue manager name = MQCA_Q_MGR_NAME                                                    
                 when MQCFST.STPRM = CAQMN;                                                                 
                   QMgrName = %subst(MQCFST.STDTA:1:MQCFST.STSTL);                                          
                 // Queue manager description = MQCA_Q_MGR_DESC                                             
                 when MQCFST.STPRM = CAQMD;                                                                 
                   QMgrDesc = %subst(MQCFST.STDTA:1:MQCFST.STSTL);                                          
                 // Command Input Queue Name  = MQCA_COMMAND_INPUT_QNAME                                    
                 when MQCFST.STPRM = CACMDQ;                                                                
                   CmdInputQname = %subst(MQCFST.STDTA:1:MQCFST.STSTL);                                     
               endsl;                                                                                       
               BUFOFF += MQCFST.STLEN;                                                                      
             elseif PCFType = CFTINT;                                                                       
               MQCFIN  = %subst(BUFFER:BUFOFF);                                                             
               BUFOFF += MQCFIN.INLEN;                                                                      
             else;                                                                                          
               MQCFST  = %subst(BUFFER:BUFOFF);                                                             
               BUFOFF += MQCFST.STLEN;                                                                      
             endif;                                                                                         
           endfor;                                                                                          
                                                                                                            
           MQOBJNAME = QMgrName;                                                                            
           MQSTATUS  = '*ACTIVE';                                                                           
           MQINFO    = QMgrDesc;                                                                            
           MQERROR   = *off;                                                                                
                                                                                                            
         // if Completion = Error/Failed                                                                    
         else;                                                                                              
             MQSTATUS = '*ERROR';                                                                           
             MQINFO   = 'MQRCCF=RC' + %char(MQCFH.FHREA);                                                   
             MQERROR  = *on;                                                                                
         endif;                                                                                             
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P GetQMGR         E                                                                                    
                                                                                                            
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
      //‚Get Channel Status                                                                                 
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
     P GetChlSts       B                                                                                    
     D GetChlSts       PI                                                                                   
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
         reset ChannelName;                                                                                 
         reset XmitQname;                                                                                   
         reset ConnectionName;                                                                              
         reset ChannelType;                                                                                 
         reset ChannelStatus;                                                                               
         reset ChannelMsgs;                                                                                 
         reset ChannelMCASts;                                                                               
                                                                                                            
         // extract the header                                                                              
         BUFOFF = 1;                                                                                        
         MQCFH  = BUFFER;                                                                                   
                                                                                                            
         // if Completion = OK                                                                              
         if MQCFH.FHCMP = CRC000;                                                                           
           // ... extract the response data                                                                 
           BUFOFF += MQCFH.FHLEN;                                                                           
           for r = 1 to MQCFH.FHCNT;                                                                        
             PCFRspType = %subst(BUFFER:BUFOFF:4);                                                          
             if PCFType = CFTSTR;                                                                           
               MQCFST  = %subst(BUFFER:BUFOFF);                                                             
               // select type                                                                               
               select;                                                                                      
                 // ChannelName = MQCACH_CHANNEL_NAME (3501)                                                
                 when MQCFST.STPRM = CAHCHN;                                                                
                   ChannelName = %subst(MQCFST.STDTA:1:MQCFST.STSTL);                                       
                 // XmitQname = MQCACH_XMIT_Q_NAME (3505)                                                   
                 when MQCFST.STPRM = CAHXQN;                                                                
                   XmitQname = %subst(MQCFST.STDTA:1:MQCFST.STSTL);                                         
                 // ConnectionName = MQCACH_CONNECTION_NAME (3506)                                          
                 when MQCFST.STPRM = CAHCNN;                                                                
                   ConnectionName = %subst(MQCFST.STDTA:1:MQCFST.STSTL);                                    
               endsl;                                                                                       
               BUFOFF += MQCFST.STLEN;                                                                      
             elseif PCFType = CFTINT;                                                                       
               MQCFIN  = %subst(BUFFER:BUFOFF);                                                             
               select;                                                                                      
                 when MQCFIN.INPRM = IAHCHT; // MQIACH_CHANNEL_TYPE (1511)                                  
                   select;                                                                                  
                     when MQCFIN.INVAL = 1;      // MQCHT_SENDER        (1)                                 
                       ChannelType = 'SENDER';                                                              
                     when MQCFIN.INVAL = 2;      // MQCHT_SERVER        (2)                                 
                       ChannelType = 'SERVER';                                                              
                     when MQCFIN.INVAL = 3;      // MQCHT_RECEIVER      (3)                                 
                       ChannelType = 'RECEIVER';                                                            
                     when MQCFIN.INVAL = 4;      // MQCHT_REQUESTER     (4)                                 
                       ChannelType = 'REQUESTER';                                                           
                     when MQCFIN.INVAL = 5;      // MQCHT_ALL           (5)                                 
                       ChannelType = 'ALL';                                                                 
                     other;                                                                                 
                       ChannelType = 'OTHER';                                                               
                   endsl;                                                                                   
                 when MQCFIN.INPRM = IAHCHS; // MQIACH_CHANNEL_STATUS (1527)                                
                   select;                                                                                  
                     when MQCFIN.INVAL = CHSINA; // MQCHS_INACTIVE      (0)                                 
                       ChannelStatus = 'INACTIVE';                                                          
                     when MQCFIN.INVAL = CHSBND; // MQCHS_BINDING       (1)                                 
                       ChannelStatus = 'BINDING';                                                           
                     when MQCFIN.INVAL = CHSSTR; // MQCHS_STARTING      (2)                                 
                       ChannelStatus = 'STARTING';                                                          
                     when MQCFIN.INVAL = CHSRUN; // MQCHS_RUNNING       (3)                                 
                       ChannelStatus = 'RUNNING';                                                           
                     when MQCFIN.INVAL = CHSSTO; // MQCHS_STOPPING      (4)                                 
                       ChannelStatus = 'STOPPING';                                                          
                     when MQCFIN.INVAL = CHSRET; // MQCHS_RETRYING      (5)                                 
                       ChannelStatus = 'RETRYING';                                                          
                     when MQCFIN.INVAL = CHSSTP; // MQCHS_STOPPED       (6)                                 
                       ChannelStatus = 'STOPPED';                                                           
                     when MQCFIN.INVAL = CHSREQ; // MQCHS_REQUESTING    (7)                                 
                       ChannelStatus = 'REQUESTING';                                                        
                     when MQCFIN.INVAL = CHSPAU; // MQCHS_PAUSED        (8)                                 
                       ChannelStatus = 'PAUSED';                                                            
                     when MQCFIN.INVAL = CHSINI; // MQCHS_INITIALIZING (13)                                 
                       ChannelStatus = 'INITIALIZING';                                                      
                   endsl;                                                                                   
                 when MQCFIN.INPRM = IAHMSG; // MQIACH_MSGS (1534)                                          
                   if MQCFIN.INVAL = 0;                                                                     
                     ChannelMsgs = 'Msg(s):0';                                                              
                   else;                                                                                    
                     ChannelMsgs = 'Msg(s):' + %char(MQCFIN.INVAL);                                         
                   endif;                                                                                   
               endsl;                                                                                       
               BUFOFF += MQCFIN.INLEN;                                                                      
             else;                                                                                          
               MQCFST  = %subst(BUFFER:BUFOFF);                                                             
               BUFOFF += MQCFST.STLEN;                                                                      
             endif;                                                                                         
           endfor;                                                                                          
                                                                                                            
           MQSTATUS = ChannelStatus;                                                                        
           MQINFO   = %trim(ChannelMsgs) + ' ' +                                                            
                      %trim(ChannelType) + ' ' + ConnectionName;                                            
           MQERROR  = *off;                                                                                 
                                                                                                            
         // if Completion = Error/Failed                                                                    
         else;                                                                                              
           if MQCFH.FHSEQ = 1;                                                                              
             if MQCFH.FHREA = 3065;  // MQRCCF_CHL_STATUS_NOT_FOUND                                         
               MQSTATUS = 'INACTIVE';                                                                       
               MQINFO   = 'MQRCCF_CHL_STATUS_NOT_FOUND';                                                    
             else;                                                                                          
               MQSTATUS = '*ERROR';                                                                         
               MQINFO   = 'MQRCCF=RC' + %char(MQCFH.FHREA);                                                 
             endif;                                                                                         
             MQERROR  = *on;                                                                                
           endif;                                                                                           
         endif;                                                                                             
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P GetChlSts       E                                                                                    
                                                                                                            
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
      //‚Get Queue                                                                                          
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
     P GetQueue        B                                                                                    
     D GetQueue        PI                                                                                   
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
         reset QType;                                                                                       
         reset QDesc;                                                                                       
         reset Usage;                                                                                       
         reset OpenInputCnt;                                                                                
         reset OpenOutputCnt;                                                                               
                                                                                                            
         // extract the header                                                                              
         BUFOFF = 1;                                                                                        
         MQCFH  = BUFFER;                                                                                   
                                                                                                            
         // if Completion = OK                                                                              
         if MQCFH.FHCMP = CRC000;                                                                           
           // ... extract the response data                                                                 
           BUFOFF += MQCFH.FHLEN;                                                                           
           for r = 1 to MQCFH.FHCNT;                                                                        
             PCFRspType = %subst(BUFFER:BUFOFF:4);                                                          
             if PCFType = CFTSTR;                                                                           
               MQCFST  = %subst(BUFFER:BUFOFF);                                                             
               // select type                                                                               
               if MQCFST.STPRM = CAQD; // MQCA_Q_DESC                                                       
                 QDesc = %subst(MQCFST.STDTA:1:MQCFST.STSTL);                                               
               endif;                                                                                       
               BUFOFF += MQCFST.STLEN;                                                                      
             elseif PCFType = CFTINT;                                                                       
               MQCFIN  = %subst(BUFFER:BUFOFF);                                                             
               select;                                                                                      
                 when MQCFIN.INPRM = IADEFT; // MQIA_DEFINITION_TYPE (7)                                    
                 when MQCFIN.INPRM = IAQTYP; // MQIA_Q_TYPE (20)                                            
                   select;                                                                                  
                     when MQCFIN.INVAL = QTLOC;  // MQQT_LOCAL   (1)                                        
                       Qtype = 'LOCAL';                                                                     
                     when MQCFIN.INVAL = QTMOD;  // MQQT_MODEL   (2)                                        
                       Qtype = 'MODEL';                                                                     
                     when MQCFIN.INVAL = QTALS;  // MQQT_ALIAS   (3)                                        
                       Qtype = 'ALIAS';                                                                     
                     when MQCFIN.INVAL = QTREM;  // MQQT_REMOTE  (6)                                        
                       Qtype = 'REMOTE';                                                                    
                     when MQCFIN.INVAL = QTCLUS; // MQQT_CLUSTER (7)                                        
                       Qtype = 'CLUSTER';                                                                   
                   endsl;                                                                                   
                 when MQCFIN.INPRM = IACDEP; // MQIA_CURRENT_Q_DEPTH (3)                                    
                   if MQCFIN.INVAL = 0;                                                                     
                     MessagesOnQ = 'Cur:0';                                                                 
                   else;                                                                                    
                     MessagesOnQ = 'Cur:' + %char(MQCFIN.INVAL);                                            
                   endif;                                                                                   
                 when MQCFIN.INPRM = IAOIC;  // MQIA_OPEN_INPUT_COUNT (17)                                  
                   if MQCFIN.INVAL = 0;                                                                     
                     OpenInputCnt = 'Inp:0';                                                                
                   else;                                                                                    
                     OpenInputCnt = 'Inp:' + %char(MQCFIN.INVAL);                                           
                   endif;                                                                                   
                 when MQCFIN.INPRM = IAOOC;  // MQIA_OPEN_OUTPUT_COUNT (18)                                 
                   if MQCFIN.INVAL = 0;                                                                     
                     OpenOutputCnt = 'Out:0';                                                               
                   else;                                                                                    
                     OpenOutputCnt = 'Out:' + %char(MQCFIN.INVAL);                                          
                   endif;                                                                                   
               endsl;                                                                                       
               BUFOFF += MQCFIN.INLEN;                                                                      
             else;                                                                                          
               MQCFST  = %subst(BUFFER:BUFOFF);                                                             
               BUFOFF += MQCFST.STLEN;                                                                      
             endif;                                                                                         
           endfor;                                                                                          
                                                                                                            
           MQSTATUS  = Qtype;                                                                               
           MQINFO    = %trim(MessagesOnQ) + ' ' +                                                           
                       %trim(OpenInputCnt) + ' ' +                                                          
                       %trim(OpenOutputCnt) + ' ' + QDesc;                                                  
           MQERROR   = *off;                                                                                
                                                                                                            
         // if Completion = Error/Failed                                                                    
         else;                                                                                              
             MQSTATUS = '*ERROR';                                                                           
             MQINFO   = 'MQRCCF=RC' + %char(MQCFH.FHREA);                                                   
             MQERROR  = *on;                                                                                
         endif;                                                                                             
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P GetQueue        E                                                                                    
                                                                                                            
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
      //‚Disconnect from MQ                                                                                 
      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
     P MQdisconnect    B                                                                                    
     D MQdisconnect    PI                                                                                   
     D  OptPtr                         *   Options(*Omit) Const                                             
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
       If MQconnected;                                                                                      
         OPTS = CONONE;                                                                                     
         // Close queues                                                                                    
         MQCLOSE(HCONN : HSEND : OPTS : CMPCOD : REASON);                                                   
         MQCLOSE(HCONN : HREPLY : OPTS : CMPCOD : REASON);                                                  
         // Disconnect from the queue manager                                                               
         MQDISC(HCONN : CMPCOD : REASON);                                                                   
       Endif;                                                                                               
                                                                                                            
       QCMDEXC('RCLRSC': 6);     // reclaim resources                                                       
       CEETREC();                // reclaim activation group QMQM                                           
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P MQdisconnect    E                                                                                    
