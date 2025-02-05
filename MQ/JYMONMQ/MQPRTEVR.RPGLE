      //********************************************************************-                               
      // MQ - Print Event list                                                                              
      //---------------------------------------------------------------------                               
      // BeppeCostagliola                                                                                   
      //********************************************************************-                               
                                                                                                            
     H dftactgrp(*no) actgrp('MQM')                                                                         
     H BndDir('MQM')                                                                                        
     H Copyright('beppecosta@yahoo.it - 2007')                                                              
                                                                                                            
      // MQ constants                                                                                       
     FJYMONMQC  if   e           k disk                                                                     
                                                                                                            
      // Event list                                                                                         
     FQSYSPRT   o    f  132        printer                                                                  
                                                                                                            
      //---------------------------------------------------------------------                               
      // Entry Parameters                                                                                   
      //---------------------------------------------------------------------                               
     D EntryParms      PR                  extpgm('MQPRTEVR')                                               
     D  QMQM                         26A                                                                    
     D  QMQUEUE                      26A                                                                    
     D  CLEARQ                        4A                                                                    
     D  QMINFO                      132A                                                                    
     D EntryParms      PI                                                                                   
     D  QMQM                         26A                                                                    
     D  QMQUEUE                      26A                                                                    
     D  CLEARQ                        4A                                                                    
     D  QMINFO                      132A                                                                    
                                                                                                            
      //---------------------------------------------------------------------                               
      // Commom MQ declare                                                                                  
      //---------------------------------------------------------------------                               
      // Queue manager name                                                                                 
     D QMNAME          S             48A                                                                    
      // Connection Handle                                                                                  
     D HCONN           S             10I 0                                                                  
      // Options                                                                                            
     D OPTS            S             10I 0                                                                  
      // Object handles                                                                                     
     D HOBJ            S             10I 0                                                                  
      // Completion codes                                                                                   
     D CMPCOD          S             10I 0                                                                  
      // Reason                                                                                             
     D REASON          S             10I 0                                                                  
      // BUFFER PUT/GET                                                                                     
     D BUFFER          S          64000A   based(BUFPTR)                                                    
      // BUFFER length                                                                                      
     D BUFLEN          S             10I 0                                                                  
      // BUFFER offset                                                                                      
     D BUFOFF          S             10I 0                                                                  
      // BUFFER pointers                                                                                    
     D BUFPTR          S               *                                                                    
      // Message length                                                                                     
     D MSGLEN          S             10I 0                                                                  
      // Queues                                                                                             
     D SYSQN           C                   CONST('SYSTEM.ADMIN.COMMAND.QUEUE')                              
     D REPQN           C                   CONST('SYSTEM.ADMIN.REPLYQ.JYMON')                               
      // Message marker                                                                                     
     D RQSID           S                   LIKE(MQMD.MDCID)                                                 
                                                                                                            
      //---------------------------------------------------------------------                               
      // MQI structures                                                                                     
      //---------------------------------------------------------------------                               
      // MQI named constants                                                                                
     D/COPY QMQM/QRPGLESRC,CMQG                                                                             
      // Object Descriptors - target, reply                                                                 
     D MQOD            DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQODG                                                                           
      // Message Descriptor                                                                                 
     D MQMD            DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQMDG                                                                           
      // Get message options                                                                                
     D MQGMO           DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQGMOG                                                                          
                                                                                                            
      //---------------------------------------------------------------------                               
      // PCF structures                                                                                     
      //---------------------------------------------------------------------                               
      // PCF Constants                                                                                      
     D/COPY QMQM/QRPGLESRC,CMQCFG                                                                           
      // PCF Header                                                                                         
     D MQCFH           DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQCFHG                                                                          
      // PCF String parameter                                                                               
     D MQCFST          DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQCFSTG                                                                         
     D STDTA                        128                                                                     
      // PCF Integer parameter                                                                              
     D MQCFIN          DS                  Qualified                                                        
     D/COPY QMQM/QRPGLESRC,CMQCFING                                                                         
      // PCF Response type                                                                                  
     D PCFRspType      DS                                                                                   
     D  PCFType                       9B 0                                                                  
                                                                                                            
      //---------------------------------------------------------------------                               
      // Instrumentation events (Response)                                                                  
      //---------------------------------------------------------------------                               
     D MsgFormat       S              8A                                                                    
     D MsgPutDate      S             10A                                                                    
     D MsgPutTime      S              8A                                                                    
     D CommandId       S             30A                                                                    
     D ComplCode       S             30A                                                                    
     D ReasonCode      S             30A                                                                    
     D ParameterId     S             30A                                                                    
     D ParameterDta    S             50A                                                                    
                                                                                                            
      //---------------------------------------------------------------------                               
      // Define MQ start/end procedures                                                                     
      //---------------------------------------------------------------------                               
     D StartMQ         PR              N                                                                    
     D TerminateMQ     PR                                                                                   
     D  OptPtr                         *   Options(*Omit) Const                                             
     D MQStarted       S               N                                                                    
                                                                                                            
      //---------------------------------------------------------------------                               
      // Define ILECEE Procedures                                                                           
      //---------------------------------------------------------------------                               
      // Prototype for CEERTX (Cancel handler)                                                              
     D CEERTX          PR                                                                                   
     D  AddrCnclHdlr                   *   ProcPtr Const                                                    
     D  OptionalPtr                    *   Options(*Omit) Const                                             
     D  FdBkCd                       12    Options(*Omit)                                                   
      // Prototype for CEETREC (Reclaim activation group)                                                   
     D CEETREC         PR                                                                                   
                                                                                                            
      //---------------------------------------------------------------------                               
      // Define local procedures                                                                            
      //---------------------------------------------------------------------                               
     D getMQConst      PR            30A                                                                    
     D  MQRC                          9B 0 const                                                            
     D  MQID                         10A   const                                                            
                                                                                                            
      //---------------------------------------------------------------------                               
      // Define API's                                                                                       
      //---------------------------------------------------------------------                               
     D QCMDEXC         pr                  extpgm('QCMDEXC')                                                
     D  Cmd                        3000A   options(*varsize) const                                          
     D  CmdL                         15P 5 const                                                            
     D                                3A   const options(*nopass)                                           
                                                                                                            
      //---------------------------------------------------------------------                               
      // Miscellaneous                                                                                      
      //---------------------------------------------------------------------                               
     D r               S             10I 0                                                                  
     D firstmsg        S               N                                                                    
     D lines           S            132A   inz(*all'-')                                                     
                                                                                                            
     D ProgramSDS     SDS                                                                                   
     D  JOB_NAME             244    253                                                                     
     D  JOB_USER             254    263                                                                     
     D  JOB_NUM              264    269                                                                     
                                                                                                            
      //*********************************************************************                               
      // MAIN                                                                                               
      //*********************************************************************                               
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
       //---------------------------------------------------------------------                              
       // connect and open event queues                                                                     
       //---------------------------------------------------------------------                              
                                                                                                            
       MQStarted = StartMQ;                                                                                 
       // if failed close all                                                                               
       if not MQStarted;                                                                                    
         TerminateMQ (*omit);                                                                               
         QMINFO = %trim(QMINFO) + ':' + %trim(JOB_USER) + '/' +                                             
                  %trim(JOB_NAME) + '/' +  %trim(JOB_NUM);                                                  
         except MQerror;                                                                                    
         *inlr = *on;                                                                                       
         return;                                                                                            
       endif;                                                                                               
                                                                                                            
       //---------------------------------------------------------------------                              
       // Get the event messages                                                                            
       //---------------------------------------------------------------------                              
                                                                                                            
       BUFPTR = %alloc(1);      // allocate dummy buffer                                                    
       firstmsg = *on;                                                                                      
                                                                                                            
       dow CMPCOD <> CCFAIL;                                                                                
                                                                                                            
         MQGMO.GMOPT  = GMWT;   // MQGMO_WAIT                                                               
         MQGMO.GMOPT += GMLK;   // MQGMO_LOCK                                                               
         MQGMO.GMOPT += GMATM;  // MQGMO_ACCEPT_TRUNCATED_MSG                                               
         if firstmsg;                                                                                       
           MQGMO.GMOPT += GMBRWF; // MQGMO_BROWSE_FIRST                                                     
           firstmsg = *off;                                                                                 
         else;                                                                                              
           MQGMO.GMOPT += GMBRWN; // MQGMO_BROWSE_NEXT                                                      
         endif;                                                                                             
                                                                                                            
         MQGMO.GMWI   = 2000;   // Wait 2 seconds                                                           
                                                                                                            
         MQMD.MDMID   = MINONE; // MsgId selector                                                           
         MQMD.MDCID   = CINONE; // CorrelId selector                                                        
                                                                                                            
         BUFLEN = 0;            // amount of msg to get                                                     
                                                                                                            
         // check message                                                                                   
         MQGET(HCONN: HOBJ: MQMD: MQGMO: BUFLEN: BUFPTR:                                                    
               MSGLEN: CMPCOD: REASON);                                                                     
                                                                                                            
         // report reason, if any                                                                           
         if REASON <> RCNONE;                                                                               
           select;                                                                                          
             when REASON = RC2033; // MQRC_NO_MSG_AVAILABLE                                                 
               leave;                                                                                       
             when REASON = RC2079; // MQRC_TRUNCATED_MSG_ACCEPTED                                           
           other;                  // other failures                                                        
             QMINFO = 'MQGET' + ' ' + %char(CMPCOD) + '.' + %char(REASON);                                  
             except MQerror;                                                                                
           endsl;                                                                                           
         endif;                                                                                             
                                                                                                            
         // stop if failed                                                                                  
         if CMPCOD = CCFAIL;                                                                                
           QMINFO = 'MQGET' + ' ' + %char(CMPCOD) + '.' + %char(REASON);                                    
           leave;                                                                                           
         endif;                                                                                             
                                                                                                            
         // get event date/time                                                                             
         MsgFormat  = MQMD.MDFMT;                                                                           
         MsgPutDate = %subst(MQMD.MDPD:7:2) + '/' +                                                         
                      %subst(MQMD.MDPD:5:2) + '/' +                                                         
                      %subst(MQMD.MDPD:1:4);                                                                
         MsgPutTime = %subst(MQMD.MDPT:1:2) + ':' +                                                         
                      %subst(MQMD.MDPT:3:2) + ':' +                                                         
                      %subst(MQMD.MDPT:5:4);                                                                
                                                                                                            
         // get the message                                                                                 
         MQGMO.GMOPT  = GMNWT;  // MQGMO_NO_WAIT                                                            
                                                                                                            
         // Clear Option                                                                                    
         If (CLEARQ) = '*NO';                                                                               
           MQGMO.GMOPT += GMBRWC; // MQGMO_BROWSE_MSG_UNDER_CURSOR                                          
         Else;                                                                                              
           MQGMO.GMOPT += GMMUC;  // MQGMO_MSG_UNDER_CURSOR                                                 
         EndIf;                                                                                             
                                                                                                            
         BUFLEN = MSGLEN;                  // amount of msg to get                                          
         BUFPTR = %realloc(BUFPTR:BUFLEN); // reallocate buffer                                             
                                                                                                            
         MQMD.MDMID   = MINONE; // MsgId selector                                                           
         MQMD.MDCID   = CINONE; // CorrelId selector                                                        
                                                                                                            
         MQGET(HCONN: HOBJ: MQMD: MQGMO: BUFLEN: BUFPTR:                                                    
               MSGLEN: CMPCOD: REASON);                                                                     
         if CMPCOD = CCFAIL;                                                                                
           QMINFO = 'MQGET' + ' ' + %char(CMPCOD) + '.' + %char(REASON);                                    
           leave;                                                                                           
         endif;                                                                                             
                                                                                                            
         // get the header                                                                                  
         BUFOFF = 1;                                                                                        
         MQCFH  = %subst(BUFFER:1:MSGLEN);                                                                  
                                                                                                            
         // print the event header                                                                          
         CommandId  = getMQConst (MQCFH.FHCMD: 'MQCMD');                                                    
         ComplCode  = getMQConst (MQCFH.FHCMP: 'MQCC');                                                     
         ReasonCode = getMQConst (MQCFH.FHREA: 'MQRC');                                                     
         except eventHdr;                                                                                   
                                                                                                            
         // extract the response data                                                                       
         BUFOFF += MQCFH.FHLEN;                                                                             
         for r = 1 to MQCFH.FHCNT;                                                                          
           PCFRspType = %subst(BUFFER:BUFOFF:4);                                                            
           if PCFType = CFTSTR;                                                                             
             MQCFST  = %subst(BUFFER:BUFOFF:MSGLEN-BUFOFF+1);                                               
             ParameterId = getMQConst (MQCFST.STPRM: 'MQCA');                                               
             if MQCFST.STSTL > 0;                                                                           
               ParameterDta = %subst(MQCFST.STDTA:1:MQCFST.STSTL);                                          
             else;                                                                                          
               ParameterDta = ' ';                                                                          
             endif;                                                                                         
             BUFOFF += MQCFST.STLEN;                                                                        
           elseif PCFType = CFTINT;                                                                         
             MQCFIN  = %subst(BUFFER:BUFOFF);                                                               
             ParameterId = getMQConst (MQCFIN.INPRM: 'MQCA');                                               
             ParameterDta = %char(MQCFIN.INVAL);                                                            
             BUFOFF += MQCFIN.INLEN;                                                                        
           endif;                                                                                           
           // print the event detail                                                                        
           except eventDtl;                                                                                 
         endfor;                                                                                            
                                                                                                            
       enddo;                                                                                               
                                                                                                            
       // close all                                                                                         
       TerminateMQ (*omit);      // close MQ objects                                                        
       dealloc BUFPTR;           // deallocate buffer                                                       
       QCMDEXC('RCLRSC': 6);     // reclaim resources                                                       
       CEETREC();                // reclaim activation group QMQM                                           
       *inlr = *on;              // close *all                                                              
       Return;                                                                                              
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
       //---------------------------------------------------------------------                              
       //   Event list                                                                                      
       //---------------------------------------------------------------------                              
     OQSYSPRT   e            eventHdr                                                                       
     O                       lines                                                                          
     OQSYSPRT   e            eventHdr                                                                       
     O                       MsgFormat                                                                      
     O                       MsgPutDate          +1                                                         
     O                       MsgPutTime          +1                                                         
     O                       CommandId           +1                                                         
     O                       ComplCode           +1                                                         
     O                       ReasonCode          +1                                                         
                                                                                                            
     OQSYSPRT   e            eventDtl                                                                       
     O                       ParameterId        +29                                                         
     O                       ParameterDta        +1                                                         
                                                                                                            
     OQSYSPRT   e            MQerror                                                                        
     O                       QMINFO                                                                         
                                                                                                            
       //***************************************************************                                    
       // Get MQ constants                                                                                  
       //***************************************************************                                    
     P getMQConst      B                                                                                    
     D getMQConst      PI            30                                                                     
     D  MQRC                          9B 0 const                                                            
     D  MQID                         10A   const                                                            
      /FREE                                                                                                 
       chain (MQRC:MQID) MQCONST;                                                                           
       if %found;                                                                                           
         return MQDESC;                                                                                     
       else;                                                                                                
         return '???' + %char(MQRC) + ' ' + MQID;                                                           
       endif;                                                                                               
      /END-FREE                                                                                             
     P getMQConst      E                                                                                    
                                                                                                            
       //***************************************************************                                    
       // StartMQ                                                                                           
       //***************************************************************                                    
     P StartMQ         B                                                                                    
     D StartMQ         PI              n                                                                    
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
       // Register cancel handler and activation group exit                                                 
       CEERTX(%Paddr('TERMINATEMQ'):*Omit: *Omit);                                                          
                                                                                                            
       //---------------------------------------------------------------------                              
       // Connect to the queue manager                                                                      
       //---------------------------------------------------------------------                              
                                                                                                            
       If QMQM = '*DFT';                                                                                    
         QMNAME = *blank;  // Default queue manager                                                         
       Else;                                                                                                
         QMNAME = QMQM;    // Requested queue manager                                                       
       EndIf;                                                                                               
                                                                                                            
       MQCONN(QMNAME : HCONN : CMPCOD : REASON);                                                            
       // stop if failed                                                                                    
       if CMPCOD = CCFAIL;                                                                                  
         QMINFO = 'MQCONN' +                                                                                
                  ' CC=' + %char(CMPCOD) + ' RC=' + %char(REASON);                                          
         return *off;                                                                                       
       endif;                                                                                               
                                                                                                            
       //---------------------------------------------------------------------                              
       //   Open the event queue for input                                                                  
       //---------------------------------------------------------------------                              
                                                                                                            
       if QMQUEUE = ' ';                                                                                    
         MQOD.ODON = 'SYSTEM.ADMIN.QMGR.EVENT';                                                             
       else;                                                                                                
         MQOD.ODON = QMQUEUE;                                                                               
       endif;                                                                                               
       OPTS  = OOINPQ;   // MQOO_INPUT_AS_Q_DEF                                                             
       OPTS += OOFIQ;    // MQOO_FAIL_IF_QUIESCING                                                          
       OPTS += OOBRW;    // MQOO_BROWSE                                                                     
       MQOPEN(HCONN: MQOD: OPTS: HOBJ: CMPCOD: REASON);   // Open ....                                      
       // stop if failed                                                                                    
       if REASON <> RCNONE;                                                                                 
         QMINFO = 'MQOPEN' + ' ' + %trimR(MQOD.ODON) +                                                      
                  ' CC=' + %char(CMPCOD) + ' RC=' + %char(REASON);                                          
         return *off;                                                                                       
       endif;                                                                                               
                                                                                                            
       // set MQ started indicator                                                                          
       return *on;                                                                                          
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P StartMQ         E                                                                                    
                                                                                                            
      //***************************************************************                                     
      // Terminate MQ                                                                                       
      //***************************************************************                                     
     P TerminateMQ     B                                                                                    
     D TerminateMQ     PI                                                                                   
     D  OptPtr                         *   Options(*Omit) Const                                             
                                                                                                            
      /FREE                                                                                                 
                                                                                                            
       // Close queues                                                                                      
       OPTS = CONONE;                                                                                       
       MQCLOSE(HCONN : HOBJ : OPTS : CMPCOD : REASON);                                                      
                                                                                                            
       // Disconnect from the queue manager                                                                 
       MQDISC(HCONN : CMPCOD : REASON);                                                                     
                                                                                                            
      /END-FREE                                                                                             
                                                                                                            
     P TerminateMQ     E                                                                                    
