      * ********************************************************************
      * =========================================================
      * Prototype for RcvJLMsg (Receive Job Log Message)
      * =========================================================
     d RCVJLMSG        pr
     d  iJob                         26
     d  iAction                      10
     d  iDirection                    1
     d  oMessage                   1132
     d  oReturn                      10
      /eof

      * =========================================================
      * Permissable values for  iJob
      *      '*' = current job
      *      or name (10), user (10), and number (6)
      * =========================================================
      * Permissable values for iAction
      *      '*NEW' = get first msg
      *      '*CONTINUE' = get following messages
      * =========================================================
      * Permissable values for iDirection
      *      'F' = read forward from top of job log
      *      'B' = read backward from bottom of job log
      * =========================================================

      * Format of oMessage
      *
     d   dJLMsg        ds          1132
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

