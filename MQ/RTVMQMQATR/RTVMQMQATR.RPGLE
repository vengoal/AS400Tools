     **
     **  Program . . : RTVMQMQATR
     **  Description : Retrieve MQ Queue Attributes  - CPP
     **  Author  . . : Vengoal Chang
     **  Published . : AS400 ePaper
     **  Date  . . . : March   11, 2025
     **
     **
     **  Compile options:
     **    CrtRpgMod   Module( RTVMQMQATR )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( RTVMQMQATR )
     **                Module( RTVMQMQATR )
     **                ActGrp( *NEW )
     **                BNDSRVPGM( QMQM/LIBMQM )
     **
     **-- Header specifications:  --------------------------------------------**
     H DEBUG  OPTION(*SRCSTMT:*NODEBUGIO)
      ****************************************************************
      *   RTVMQMQATR has 7 parameters - (1) name of the source queue *
      *                                 (2) name of the queue manager*
      *                                                              *
      ****************************************************************
      * Array of Selectors
     D SELS            S             10I 0 DIM(7)
      * Array of Integer Attributes
     D IAV             S             10I 0 DIM(7)
      *
      * Array of Character Attributes - not used in this example
     D CAV             S             20A   DIM(1)
      * Connection handle
     D HCONN           S             10I 0
      * Options
     D OPTS            S             10I 0
      * Object handles
     D HOBJ            S             10I 0
     D HINQ            S             10I 0
      * Completion codes
     D OCODE           S             10I 0
     D CCODE           S             10I 0
     D MQCODE          S             10I 0
      * Reasons
     D REASON          S             10I 0
     D CREASN          S             10I 0
     D BUFFER          S           1024
      * Buffer length
     D BUFLEN          S             10I 0
      * Message length
     D MSGLEN          S             10I 0
      * Selector count
     D SELCNT          S             10I 0
      * Integer attributes count
     D IACNT           S             10I 0
      * Character attribute length
     D CACNT           S             10I 0
      * Buffer pointer
     D BUFPTR          S               *   INZ (%ADDR(BUFFER))
     D CAVPTR          S               *   INZ (%ADDR(CAV))
      *
      **  Declare MQI structures needed - this sample uses single
      **    occurence data structures for use in PARM fields
      *
      * MQI named constants
     D/COPY CMQG
      * Object Descriptor - source, reply, inquire
     D MQOD            DS
     D/COPY CMQODG
      * Message Descriptor
     D MQMD            DS
     D/COPY CMQMDG
      * Get message options
     D MQGMO           DS
     D/COPY CMQGMOG
      * Put message options
     D MQPMO           DS
     D/COPY CMQPMOG
      ** note, sample uses defaults where it can
     D QNAME           S             48
     D QMNAME          S             48
     D InhibitGet      S             10I 0
     D InhibitPut      S             10I 0
     D NbrOfMsg        S             10I 0
     D OPNINPCNT       S             10I 0
     D OPNOUTCNT       S             10I 0
     D QType           S             10I 0
     D QUsage          S             10I 0
     D ERRAPI          S             10
     D RCODE           S             10
      **
      * program parameters are: 48-character source queue name
      *                         48-character queue manager name
     C     *ENTRY        PLIST
     C                   PARM                    QNAME
     C                   PARM                    QMNAME
     C                   PARM                    InhibitGet
     C                   PARM                    InhibitPut
     C                   PARM                    NbrOfMsg
     C                   PARM                    OPNINPCNT
     C                   PARM                    OPNOUTCNT
     C                   PARM                    QType
     C                   PARM                    QUsage
     C                   PARM                    ERRAPI
     C                   PARM                    RCODE

      * connect to queue manager and open input queue
     C                   EXSR      START
      *
      * start loop to process the messages
     C     CCODE         IFNE      CCFAIL
      * inquire attributes of queue named in the request message
     C                   EXSR      INQS
     C                   ENDIF
      *
      ** close input queue and disconnect (if connected)
     C     MQCODE        IFEQ      CCOK
     C                   EXSR      FINISH
     C                   ENDIF
      *
      ** indicate that sample program has finished
     C                   SETON                                        LR
      *
      ****************************************************************
      *                                                              *
      *   START - connect to the queue manager and open the input    *
      *                                                              *
      *     connection handle returned as HCONN; reason code is      *
      *     retained as CREASN, and there is no MQDISC if MQM        *
      *     was already connected before this call                   *
      *                                                              *
      *     input queue handle is HOBJ                               *
      *                                                              *
      ****************************************************************
     C     START         BEGSR
      * leave QMNAME blank to get the default queue manager
     C*                  MOVEL     *BLANKS       QMNAME
      * use explicit connection in this sample
     C                   CALLP     MQCONN(QMNAME : HCONN : MQCODE : CREASN)
      *
      * report reason and stop if it failed
     C     MQCODE        IFEQ      CCFAIL
      **  "MQCONN ended with reason code ...."
     C                   MOVEL     'MQCONN ERR'  ERRAPI
     C                   MOVE      CREASN        RCODE
      **  "unable to connect to MQM"
     C                   MOVE      MQCODE        CCODE
     C                   ELSE
      *
      * input queue name is taken from the trigger parameter
     C                   MOVEL     QNAME         ODON             48
      * options are Shared-input and Fail-if-quiescing
     C     OOINPS        ADD       OOFIQ         OPTS
     C                   ADD       OOINQ         OPTS
      * call for MQOPEN ...
     C                   CALLP     MQOPEN(HCONN : MQOD : OPTS : HOBJ :
     C                              OCODE : REASON)
      *
      * report reason, if any; stop if it failed
     C     REASON        IFNE      RCNONE
      **  "MQOPEN ended with reason code ...."
     C                   MOVEL     'MQOPEN ERR'  ERRAPI
     C                   MOVE      REASON        RCODE
     C                   ENDIF
      *
     C     OCODE         IFEQ      CCFAIL
      **  "unable to open queue for input"
     C                   MOVEL     'MQOPEN ERR'  ERRAPI
     C                   MOVE      REASON        RCODE
     C                   ENDIF
      *
     C                   MOVE      OCODE         CCODE
     C                   ENDIF
     C                   ENDSR
      *
      ****************************************************************
      *                                                              *
      *   INQS - inquire attributes of the queue named in request;   *
      *          result is a reply or report message prepared,       *
      *          with Feedback also set for a report                 *
      *                                                              *
      *    HOBJ is queue handle when opening for INQUIRE             *
      *                                                              *
      ****************************************************************
     C     INQS          BEGSR
      * open (local) queue named in the request message
     C                   MOVEL     QNAME         ODON             48
     C                   MOVEL     QMNAME        ODMN             48
      * if queue opened, prepare counts for INQUIRE
     C                   Z-ADD     7             SELCNT
     C                   Z-ADD     7             IACNT
     C                   Z-ADD     0             CACNT
      * define attribute selectors for Get Inhibit status, current
      *   queue , open-input count and open-output count
     C                   Z-ADD     IAIGET        SELS(1)
     C                   Z-ADD     IAIPUT        SELS(2)
     C                   Z-ADD     IACDEP        SELS(3)
     C                   Z-ADD     IAOIC         SELS(4)
     C                   Z-ADD     IAOOC         SELS(5)
     C                   Z-ADD     IAQTYP        SELS(6)
     C                   Z-ADD     IAUSAG        SELS(7)
      * call for MQINQ ...
     C                   CALLP     MQINQ(HCONN : HOBJ : SELCNT : SELS(1) :
     C                              IACNT : IAV(1) : CACNT : CAVPTR : CCODE :
     C                              REASON)
      *
      * note feedback code if INQUIRE failed
     C     CCODE         IFEQ      CCFAIL
     C                   MOVEL     'MQINQ ERR'   ERRAPI
     C                   MOVE      REASON        RCODE
     C                   ELSE
      *
      * build reply text if INQUIRE worked ...
     C                   Z-Add     IAV(1)        InhibitGet
     C                   Z-Add     IAV(2)        InhibitPut
     C                   Z-Add     IAV(3)        NbrOfMsg
     C                   Z-Add     IAV(4)        OPNINPCNT
     C                   Z-Add     IAV(5)        OPNOUTCNT
     C                   Z-Add     IAV(6)        QType
     C                   Z-Add     IAV(7)        QUsage
     C                   ENDIF
      *
     C                   ENDSR
      *
      ****************************************************************
      *                                                              *
      *   FINISH - close the iput queue (if open) and disconnect     *
      *                                                              *
      ****************************************************************
     C     FINISH        BEGSR
      *
      * if input queue was opened, close it (without options)
     C     OCODE         IFNE      CCFAIL
     C                   Z-ADD     CONONE        OPTS
     C                   CALLP     MQCLOSE(HCONN : HOBJ : OPTS :
     C                              CCODE : REASON)
      *
      * report reason, if any
     C     REASON        IFNE      RCNONE
      **  "MQCLOS ended with reason code ...."
     C                   MOVEL     'MQCLOS ERR'  ERRAPI
     C                   MOVE      REASON        RCODE
     C                   ENDIF
     C                   ENDIF
      *
      * disconnect from MQM, only if it was not previously connected
     C     CREASN        IFNE      RC2002
     C                   CALLP     MQDISC(HCONN : CCODE : REASON)
      *
      * report reason, if any
     C     REASON        IFNE      RCNONE
      **  "MQDISC ended with reason code ...."
     C                   MOVEL     'MQDISC ERR'  ERRAPI
     C                   MOVE      REASON        RCODE
     C                   ENDIF
     C                   ENDIF
     C                   ENDSR
      *
