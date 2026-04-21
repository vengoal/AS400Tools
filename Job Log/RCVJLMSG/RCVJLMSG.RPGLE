      *===============================================================
      * Module ID     -   RCVJLMSG
      * Module Name   -   Receive Job Log Messages
      * Programmer    -   Vadim Rozen
      * Updated       -   Vengoal Chang
      *===============================================================
      * This program receives messages from a job log.
      *===============================================================
      * To compile:
      *
      *      CRTRPGMOD  MODULE(XXX/RCVJLMSG) SRCFILE(XXX/QRPGLESRC)
      *
      *===============================================================

     h  Debug
      * ********************************************************************
      * Main Procedure prototype
      * *Entry Parameter List
      * ********************************************************************
      * =========================================================
      * Prototype for RcvJLMsg (Receive Job Log Message)
      * =========================================================
      /copy qrpglesrc,rcvjlmsgp
      *
     d RCVJLMSG        pi
     d  iJob                         26
     d  iAction                      10
     d  iDirection                    1
     d  oMessage                   1132
     d  oReturn                      10

      * ********************************************************************
      * Work fields
      * ********************************************************************
     d UsrSpc          s             20
     d USText          s             50
     d USpSize         s             10i 0 inz(8196)
     d ExtAttr         s             10    inz('FFINFO')
     d IntValue        s              1
     d Authority       s             10    inz('*ALL')
     d Replace         s             10    inz('*YES')
     d Offset          s             10i 0
     d Size            s             10i 0
     d Exit            s              1n
     d Error           s              1n
     d CurMsg          s              2  0
     d SavMsgKey       s              4
      * Format name
     d Format1         s              8    inz('LJOB0100')
      * Message selection information
     d dRcvInfo        ds
     d  dMaxMsgReq                   10i 0 inz(11)
     d  dListDir                     10    inz('*NEXT')
     d  dJob                         26    inz
     d   dJobName                    10    overlay(dJob:1)
     d   dUserName                   10    overlay(dJob:11)
     d   dJobNum                      6    overlay(dJob:21)
     d  dIntJobId                    16    inz
     d  dStrMsgKey                    4    inz(X'00000000')
     d  dMaxMsgL                     10i 0 inz(1024)
     d  dMaxMHlpL                    10i 0 inz(0)
     d  dOffset                      10i 0 inz(84)
     d  dNumFldRtn                   10i 0 inz(1)
     d  dOfsMsgQNm                   10i 0 inz(88)
     d  dLngMsgQNm                   10i 0 inz(1)
     d  dIndRtn                      10i 0 inz(302)
     d  dMsgQuName                   10    inz('*')
      * Size of Message selection information
     d MSLng           s             10i 0 inz(%size(dRcvInfo))
      * Format of message selection information
     d Format2         s              8    inz('JSLT0100')
      * Error data structure
     D dError          ds
     D  dBytPrv                      10i 0 inz(116)
     D  dBytAva                      10i 0
     D  dErrMId                       7
     D  dErr##                        1
     D  dErrDta                     100
      *
      *  -------------------------------------------------------------------
      *  -  User space attributes data structure                           -
      *  -------------------------------------------------------------------

     D QUSAttr         DS
     D  QUSNumRec                    10I 0 Inz( 1 )
     D  QUSKey                       10I 0 Inz( 3 )
     D  QUSRecLen                    10I 0 Inz( 1 )
     D  QUSRecData                    1A   Inz( '1' )

      * User Space Header offset, length and data structure
     d Position        s             10i 0 inz(125)
     d Length          s             10i 0 inz(%size(dHeader))
      *
      *----------------------------------------------------------------
      * Get user space list info from header section.
      *----------------------------------------------------------------
      * List Header
     D dHeader         ds                  based(uHeadPtr)
     D uOffSetToList         125    128i 0
     D uNumOfEntrys          133    136i 0
     D uSizeOfEntry          137    140i 0
      *
      * Job Log Message
     d dJLMsg          ds                  Based(uListPtr )
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

      * these fields repeat for each key selected.
     D uListEntry2     ds                  Based(uListPtr2)
     d  dOfsNFldR                    10i 0
     d  dLngFldRt                    10i 0
     d  dIdnFld                      10i 0
     d  dDataType                     1
     d  dDataSts                      1
     d  dReserve2                    14
     d  dDataLng                     10i 0
     d  dData                      1024
      * ************************************************************************
      * Prototypes
      * ********************************************************************
      *
      * Create User Space
     d CrtUsrSpc       pr                  ExtPgm('QUSCRTUS')
     d                               20
     d                               10
     d                               10i 0
     d                                1
     d                               10
     d                               50
     d                               10
     db                                    like(dError)
      *
      * Receive List of Job Log Messages
     d JobLogMsg       pr                  ExtPgm('QMHLJOBL')
     d                               20
     d                                8
     d                               80
     d                               10i 0
     d                                8
     db                                    like(dError)
      *
      * Get User space Header
     d GetUsSpc        pr                  extpgm('QUSRTVUS')
     d                               20
     d                               10i 0
     d                               10i 0
     d                               16
     db                                    like(dError)
      *  -------------------------------------------------------------------
      *  -  Qusptrus      - Get user space pointer       API               -
      *  -                                                                 -
      *  -  Usage      Length   Type         Parameter Description         -
      *  -                                                                 -
      *  -  Input          20   Character    Qualified user space name     -
      *  -  Output          *   Pointer      UserSpace Pointer             -
      *  -  Output                           Error Code                    -
      *  - -----------------------------------------------------------------
     D qusptrus        PR                  ExtPgm('QUSPTRUS')                   retrieve pointer
     D                               20                                         Space Name
     D                                 *                                        pointer
     Db                                    like(dError)                         error parm
      *  -------------------------------------------------------------------
      *  -  Quscusat      - Change User Space Attributes API               -
      *  -                                                                 -
      *  -  Usage      Length   Type         Parameter Description         -
      *  -                                                                 -
      *  -  Output         10   Character    Returned library              -
      *  -  Input          20   Character    Qualified user space name     -
      *  -  Input          13   Character    Attribute structure           -
      *  -  Output                           Error code                    -
      *  -------------------------------------------------------------------
     D quscusat        PR                  ExtPgm( 'QUSCUSAT' )
     D                               10A   Const
     D                               20A   Const
     D                               13A   Const
     Db                                    like(dError)
      * ********************************************************************
      * Constants
      * ********************************************************************
      * User space name and text
     d C#UsrSpc        S             20    Inz('JOBLOGMSG QTEMP     ')
     d C#USpText       c                   const('Job Log Messages')
     d C#Max           c                   const(5)
      * ************************************************************************
      * Main Line
      * ************************************************************************
      *
     c                   If        Error = *Off
     c                   ExSr      Sb1000
     c                   EndIf
      *
      * End of program
     c                   ExSr      Sb9999
      *
     c                   Return
      * ************************************************************************
      * Main Process
      * ************************************************************************
     c     Sb1000        BegSr
      *
     c                   Eval      Exit = *Off
     c                   Eval      Error = *Off
     c                   Eval      dJob = iJob
     c                   Eval      oReturn = *Blank
      *
      * Receive C#Max messages into User Space
     c                   DoW       not Exit and not Error
     c                   If        iAction = '*NEW' or
     c                             CurMsg = C#Max
     c                   ExSr      Sb1100
      *
      * Receive User Space Header
     c                   If        not Error
     c                   ExSr      Sb1200
     c                   EndIf
     c                   EndIf
      *
      * Receive message details
     c                   If        not Error
     c                   ExSr      Sb1300
     c                   EndIf
     c                   EndDo
      *
     c                   EndSr
      * ************************************************************************
      * Receive 11 messages into User Space
      * ************************************************************************
     c     Sb1100        BegSr
      *
      * Receive Last Message First.
     c                   If        iAction = '*NEW' and iDirection = 'B'
     c                   Eval      dListDir  = '*PRV'
     c                   Eval      dStrMsgKey = *Blank
     c                   EndIf
      *
     c                   Eval      UsrSpc = c#UsrSpc
     c                   Callp     JobLogMsg(UsrSpc:Format1:dRcvInfo:
     c                                       MSLng:Format2:dError )
      * Go to error handling routine
     c                   If        dErrMId <> *Blank
     c                   Eval      oMessage = dErrMID + dErrDta
     c                   Eval      oReturn = '*ERROR'
     c                   Eval      Error = *On
     c                   Else
     c                   Eval      SavMsgKey = *Blank
     c                   EndIf
      *
     c                   EndSr
      * ************************************************************************
      * Receive User Space Header
      * ************************************************************************
     c     Sb1200        BegSr
      *
     C                   eval      uListPtr  = uHeadPtr + uOffSetToList
      *
      * Receive 1st Message from User Space
     c                   Eval      CurMsg = 0
      *
     c                   EndSr
      * ************************************************************************
      * Receive message details
      * ************************************************************************
     c     Sb1300        BegSr
      *
     c                   Do
     c                   Eval      CurMsg = CurMsg + 1
     C                   eval      uListPtr2 = uHeadPtr + dOfsFrtn
      *
      * Last Message have been processed
     c                   If        CurMsg = C#Max
     c                   Leave
     c                   EndIf
      *
      * If message key is repeated - no more messages exist in job log
     c                   If        SavMsgKey = dMsgKey
     c                   Eval      Exit = *On
     c                   Eval      oReturn = '*ENDOFJLOG'
     c                   Eval      *InLr = *On
     c                   Leave
     c                   EndIf
      *
     c                   Eval      SavMsgKey = dMsgKey
     c                   Eval      dStrMsgKey = dMsgKey
      *
      * Exit, if required message types has been received.
     c                   Eval      Exit = *On
     c                   If        dDataLng > %Size(dData)
     c                   Eval      dDataLng = %Size(dData)
     c                   Eval      oReturn = '*OVERFLOW'
     c                   EndIf

     c                   Eval      oMessage = dJLMsg + uListEntry2
      *
      * No more messages in user space
     c                   If        dOfsNext = 0
     c                   Leave
     c                   EndIf
      *
      *
      * Get next offset position
     C                   eval      uListPtr  = uHeadPtr  + dOfsNext
     c                   EndDo
      *
     c                   EndSr
      * ************************************************************************
      * End of program
      * ************************************************************************
     c     Sb9999        BegSr
      *
     c                   If        Error or
     c                             oReturn = 'ENDOFJLOG'
     c                   Eval      *InLr = *On
     c                   EndIf
      *
     c                   EndSr
      * ************************************************************************
      * Initialize variables
      * ************************************************************************
     c     *InzSr        BegSr
      *
     c                   Eval      UsrSpc = c#UsrSpc
     c                   Eval      USText = C#USpText
      *
      * Create User space
     c                   Callp     CrtUsrSpc(UsrSpc:ExtAttr:USpSize:IntValue
     c                                     :Authority:USText:Replace:dError)
      *
      * set UserSpace to autoextended
     C                   CallP     QUSCUSAT( 'QTEMP'    :
     C                                       UsrSpc     :
     C                                       QUSAttr    :
     C                                       dError     )
      *
      * Get pointer to user space
     C                   callp     QUSPTRUS(
     C                             UsrSpc    :
     C                             uHeadPtr:
     C                             dError   )
      *
     c                   EndSr
