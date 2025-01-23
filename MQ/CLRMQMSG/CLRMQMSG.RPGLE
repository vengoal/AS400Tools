     **
     **  Program . . : CLRMQMSG
     **  Description : Clear MQ Expired Message
     **  Author  . . : Vengoal Chang
     **  Published . : AS400ePaper
     **  Date  . . . : January 23, 2025
     **
     **
     **
     **  Programmer's notes:
     **   Exceptions signaled:  none
     **   Exceptions monitored: none
     **
     **   CLRMQMSG has 3 parameters - (1) name of the target queue
     **                               (2) name of the queue manager
     **                               (3) msessage expired seconds
     **                               (3) delete   expired message
     **
     **
     **
     **  Compile options required:
     **    Addlible    QMQM
     **    CrtRpgMod   Module( CLRMQMSG )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CLRMQMSG )
     **                Module( CLRMQMSG )
     **                BndSrvPgm( QMQM/LIBMQM )
     **                ActGrp( *NEW )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )

     FQSYSPRT   O    F  132        PRINTER
      *  Connection handle
     D HCONN           S             10I 0
      * Options
     D OPTS            S             10I 0
      * Object handle
     D HOBJ            S             10I 0
      * Completion codes
     D OCODE           S             10I 0
     D CCODE           S             10I 0
      * Reason
     D REASON          S             10I 0
      * Buffer length
     D BUFLEN          S             10I 0
      * Message length
     D MSGLEN          S             10I 0
      * Buffer
     D BUFFER          S             20
      * Buffer pointer
     D BUFPTR          S               *   INZ (%ADDR(BUFFER))
      *
      **  Declare MQI structures needed
      * MQI named constants
     D/COPY CMQG
      * Object Descriptor
     D MQOD            DS
     D/COPY CMQODG
      * Message Descriptor
     D MQMD            DS
     D/COPY CMQMDG
      * Get message options
     D MQGMO           DS
     I/COPY CMQGMOG

     D PUTDATE         S                   Like(MDPD)
     D PUTTIME         S                   Like(MDPT)
     D PUTDTC          S             26
     D PUTDT           S               Z
     D DIFFSECS        S             10S 0
     D DLTMSGID        S                   Like(MDMID)
     D SECONDS         S              5

      ** note, sample uses defaults where it can
      *
      * program parameters are: 48-character target queue name
      *                         48-character queue manager name
      *                          5-Decimal   message aged seconds
      *                          4-Delete expired message
     C     *ENTRY        PLIST
     C                   PARM                    QNAME            48
     C                   PARM                    QMNAME           48
     C                   PARM                    SECONDSN          5 0
     C                   PARM                    DLTEXPMSG         4

     C                   Move      SECONDSN      SECONDS

      ** indicate that sample program has started
     C                   MOVEL     'start'       STATUS            5
     C                   EXCEPT    SAMPLE
      *
      ****************************************************************
      *                                                              *
      *   Create object descriptor for source queue                  *
      *                                                              *
      ****************************************************************
     C                   MOVEL     QNAME         ODON             48
      *
      ****************************************************************
      *                                                              *
      *   Connect to the queue manager                               *
      *                                                              *
      ****************************************************************
     C                   CALLP     MQCONN(QMNAME : HCONN : OCODE : REASON)
      *
      * report reason and stop if it failed
     C     OCODE         IFEQ      CCFAIL
      **  "MQCONN ended with reason code ...."
     C                   MOVEL     'MQCONN'      CNAME             6
     C                   MOVE      REASON        RCODE            10
     C                   EXCEPT    MQCALL
      **  "unable to connect to MQM"
     C                   MOVE      OCODE         CCODE
     C                   EXCEPT    MESSC
     C                   SETON                                        LR
     C                   RETURN
     C                   ENDIF
      ****************************************************************
      *                                                              *
      *   Open the source message queue for browse (and fail if      *
      *   MQM is quiescing)                                          *
      *                                                              *
      *   Resulting queue handle is HOBJ                             *
      *                                                              *
      ****************************************************************
      * Open options are Browse and Fail-of-quiescing
     C     OOBRW         ADD       OOFIQ         OPTS
     C                   ADD       OOINPQ        OPTS
      * call ...
     C                   CALLP     MQOPEN(HCONN : MQOD : OPTS : HOBJ :
     C                              OCODE : REASON)
      *
      * report reason, if any; stop if failed
     C     REASON        IFNE      RCNONE
      **  "MQOPEN ended with reason code ...."
     C                   MOVEL     'MQOPEN'      CNAME             6
     C                   MOVE      REASON        RCODE            10
     C                   EXCEPT    MQCALL
     C                   ENDIF
      *
      **  If call failed, say "unable to open queue for browse"
     C     OCODE         IFEQ      CCFAIL
     C                   EXCEPT    MESS
     C                   ENDIF
      *
      ****************************************************************
      *                                                              *
      *   Get messages from message queue                            *
      *                                                              *
      ****************************************************************
      **  initial loop condition based on result of MQOPEN
     C                   MOVE      OCODE         CCODE
      **  start counting the messages
     C                   Z-ADD     0             I                10 0
      *  set buffer length available
     C                   Z-ADD     20            BUFLEN
      **  start of loop to browse all the messages . . .
     C     CCODE         DOWNE     CCFAIL
      *
      * GET options are to Browse next message, without waiting ...
     C     GMNWT         ADD       GMBRWN        GMOPT
      *      ... and Accept-truncated-message
     C                   ADD       GMATM         GMOPT
      *      ... and convert application data
     C                   ADD       GMCONV        GMOPT
      *   truncated
      **  MsgId and CorrelId are selectors that must be cleared
      **  to get messages in sequence, and they are set each MQGET
     C                   MOVEL     MINONE        MDMID
     C                   MOVEL     CINONE        MDCID
      **  clear buffer because MQGET only fills to length of message
     C                   MOVEL     *BLANKS       BUFFER
      * call ...
     C                   CALLP     MQGET(HCONN : HOBJ : MQMD : MQGMO :
     C                              BUFLEN : BUFPTR : MSGLEN : CCODE :
     C                              REASON)
      *
      ** . . .display each message received
     C     CCODE         IFNE      CCFAIL
      ** . . . (display name of resolved queue before first one
     C     I             IFEQ      0
     C**       "Messages for ----"
     C                   MOVEL     GMRQN         QNAME            48
     C                   EXCEPT    SOURCE
     C                   ENDIF
      *
     C                   ADD       1             I
     C**  count Msg     display message
     C                   eval      PUTDATE = MDPD
     C                   eval      PUTTIME = MDPT
     C                   eval      PUTDTC  = %SUBST(PUTDATE:1:4) + '-' +
     C                                       %SUBST(PUTDATE:5:2) + '-' +
     C                                       %SUBST(PUTDATE:7:2) + '-' +
     C                                       %SUBST(PUTTIME:1:2) + '.' +
     C                                       %SUBST(PUTTIME:3:2) + '.' +
     C                                       %SUBST(PUTTIME:5:2) + '.' +
     C                                       %SUBST(PUTTIME:7:2) +
     C                                       '0000'
     C                   eval      PUTDT   = %TimeStamp(PUTDTC) + %Hours(8)
     C                   eval      DIFFSECS= %DIFF(%TimeStamp() : PUTDT : *S)
     C                   If        DIFFSECS > SECONDSN
     C                   eval      DLTMSGID = MDMID
     C                   EXCEPT    TEXT
     C                   If        DltExpMsg = '*YES'
     C                   Exsr      DltMsg
     C                   EndIf
     C                   EndIf
     C                   ENDIF
      *
      ** report reason (from MQGET), if any
     C                   SELECT
     C     REASON        WHENEQ    RCNONE
      **  specific text for "no more messages"
     C     REASON        WHENEQ    RC2033
     C                   EXCEPT    NOMESS
      **  specific text for "truncated message"
     C     MSGLEN        WHENGT    BUFLEN
     C                   EXCEPT    TRUNC
      **  otherwise say "MQGET ended with reason code ...."
     C                   OTHER
     C                   MOVEL     'MQGET '      CNAME
     C                   MOVE      REASON        RCODE
     C                   EXCEPT    MQCALL
     C                   ENDSL
      *
      **  end DO-while loop; MQI failure causes loop to end
     C                   ENDDO
      *
      ****************************************************************
      *                                                              *
      *   Close the source queue (if it was opened)                  *
      *                                                              *
      ****************************************************************
      * test if queue was opened
     C     OCODE         IFNE      CCFAIL
      *   close it with no options if it was
     C                   Z-ADD     CONONE        OPTS
     C                   CALLP     MQCLOSE(HCONN : HOBJ : OPTS :
     C                              CCODE : REASON)
      *
      * report reason (from MQCLOS), if any
     C     REASON        IFNE      RCNONE
      **  "MQCLOS ended with reason code ...."
     C                   MOVEL     'MQCLOS'      CNAME
     C                   MOVE      REASON        RCODE
     C                   EXCEPT    MQCALL
     C                   ENDIF
      *
      * end if (OCODE not CCFAIL)
     C                   ENDIF
      ****************************************************************
      *                                                              *
      *   Disconnect from the queue manager                          *
      *                                                              *
      ****************************************************************
     C                   CALLP     MQDISC(HCONN : OCODE : REASON)
      *
      * report reason and stop if it failed
     C     OCODE         IFEQ      CCFAIL
      **  "MQDISC ended with reason code ...."
     C                   MOVEL     'MQDISC'      CNAME             6
     C                   MOVE      REASON        RCODE            10
     C                   EXCEPT    MQCALL
     C                   ENDIF
      *
      ** "Sample AMQ3GBR4 end"
     C                   MOVEL     'end  '       STATUS            5
     C                   EXCEPT    SAMPLE
     C                   SETON                                        LR
      ****************************************************************
     C     DLTMSG        BegSr
      * GET options are to Get message, without waiting ...
     C                   Z-ADD     GMNWT         GMOPT
      *      ... and Accept-truncated-message
     C                   ADD       GMATM         GMOPT
      *      ... and convert application data
     C                   ADD       GMCONV        GMOPT
     C
     C                   MOVEL     DLTMSGID      MDMID
     C                   MOVEL     CINONE        MDCID
      **  clear buffer because MQGET only fills to length of message
     C                   MOVEL     *BLANKS       BUFFER
      * call ...
     C                   CALLP     MQGET(HCONN : HOBJ : MQMD : MQGMO :
     C                              BUFLEN : BUFPTR : MSGLEN : CCODE :
     C                              REASON)
      *
     C                   EndSr
      ****************************************************************
     OQSYSPRT   E            SAMPLE         1
     O                                           20 '       CLRMQMSG '
     O                       STATUS              25
     O                       DLTEXPMSG           35
     O                       Seconds             45
     O          E            SOURCE         1
     O                                           20 'Messages for '
     O                       QNAME
     O          E            TEXT           1
     O                       I                   10
     O                                              ' <'
     O                       BUFFER
     O                                              '> '
     O                       PUTDATE
     O                                              ' '
     O                       PUTTIME
     O                                              ' '
     O                       PUTDT
     O                                              ' '
     O                       DIFFSECS
     O          E            MQCALL         1
     O                       CNAME               10
     O                                              ' ended with reason code'
     O                       RCODE               45
     O          E            MESSC          1
     O                                           25 'Unable to connect to'
     O                                              ' queue manager'
     O          E            MESS           1
     O                                           25 'Unable to open queue'
     O                                              ' for Browse'
     O          E            NOMESS         1
     O                                           25 'no more messages'
     O          E            TRUNC          1
     O                                           25 '  --- truncated'
