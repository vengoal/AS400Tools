      *===============================================================
      * Test RTVJLMSG module
      *===============================================================
      * To compile:
      *
      *      CRTRPGMOD  MODULE(XXX/RCVJLMSGT) SRCFILE(XXX/QRPGLESRC)
      *
      *      CRTPGM     PGM(XXX/RCVJLMSGT)           +
      *                 MODULE(RCVJLMSGT RCVJLMSG)   +
      *                 ACTGRP(*NEW)
      *
      *===============================================================
     H Debug
     Fqsysprt   o    f  132        printer    oflind(*in88)

      /copy qrpglesrc,rcvjlmsgp

     d  Job            s             26
     d  Direction      s              1
     d  Action         s             10

      * Job Log Message
     d Message         ds          1132
     d  dOfsNext                     10i 0
     d  dOfsFrtn                     10i 0
     d  dNumRtn                      10i 0
     d  dMsgSvty                     10i 0
     d  dMsgId                        7
     d  dMsgType                      2
     d  dMsgKey                       4
     d  dMsgFile                     10
     d  dMsgLib                      10
     d  dDateSnt                      7
     d  dTimeSnt                      6
     d  dTimeMili                     6
     d  dThread                       8
     d  dOfsNFldR                    10i 0
     d  dLngFldRt                    10i 0
     d  dIdnFld                      10i 0
     d  dDataType                     1
     d  dDataSts                      1
     d  dReserve2                    14
     d  dDataLng                     10i 0
     d  dData                      1024

     d  Return         s             10
     D  Count          s              3p 0
     d  Data           s            105
     d  DataLng        s             10i 0

     d iMessage        s           1132

      ** Parameters:
      **    Job A(26): enter '*' for current job or name (10), user (10),
      **                 and number (6)
      **    Direction A(1): Enter 'F' to start reading forward from top of
      **                 job log or 'B' to start reading backward from bottom

     C     *entry        plist
     C                   parm                    Job
     C                   parm                    Direction
     C
     C                   eval      Action = '*NEW'
     C                   exsr      GetMsg
     C                   dow       Return = *blanks
     C                   eval      Action = '*CONTINUE'
     C                   exsr      GetMsg
     C                   enddo
     C                   eval      *inlr = *on

     C***
     C     GetMsg        begsr
     C
     C                   eval      iMessage = *Blanks
     C                   callp     RcvJlMsg (Job: Action: Direction:
     C                                            iMessage: Return)
     C                   eval      Message = iMessage
     C                   eval      count = count + 1
     C                   if        return = '*ERROR'
     C                   eval      Data = Message
     C                   Else
     C                   if        dDataLng <= 132
     C                   eval      Data = %subst(dData:1:dDataLng)
     C                   else
     C                   eval      Data = %subst(dData:1:132)
     C                   endif
     C                   endif
     C                   except    Dtl
     C
     C                   endsr
     C*
     Oqsysprt   e            dtl            1
     O                       count         4
     O                       return           +   1
     O                       dMsgID           +   1
     O                       dMsgType         +   1
     O                       Data             +   1
