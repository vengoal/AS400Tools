      *
      * Usage:
      *  Enable
      *  ADDEXITPGM EXITPNT(QIBM_QSO_ACCEPT)
      *             FORMAT(LSTN0100) PGMNBR(10)
      *             PGM(QGPL/SKTEXITLSN)
      *  Disable
      *  RMVEXITPGM EXITPNT(QIBM_QSO_ACCEPT)
      *             FORMAT(LSTN0100)
      *             PGMNBR(10)
      *
     H DEBUG OPTION(*SRCSTMT:*NODEBUGIO) DFTACTGRP(*NO) ACTGRP(*CALLER)

     FSktExitLogO  A E           K Disk

      * PGM SDS sample
     D                SDS
     D JobNam                244    253
     D JobUsr                254    263
     D JobNbr                264    269
     D CurUsr                358    367

     D in_addr         DS                  QUALIFIED
     D   s_addr                      10U 0

     D u6_addr         DS                  QUALIFIED
     D   u6_addr32                   10U 0 DIM(4) OVERLAY(u6_addr)
     D   u6_addr16                    5U 0 DIM(8) OVERLAY(u6_addr)
     D   u6_addr8                    16A   OVERLAY(u6_addr)

     D in6_addr        DS                  QUALIFIED
     D  u6_addr                            LIKEDS(u6_addr)

     D sockaddr_in     DS                  QUALIFIED
     D   sin_family                   5U 0
     D   sin_port                     5U 0
     D   sin_addr                    10U 0
     D*  reserved - must be *allx'00'
     D   sin_zero                     8A

     D sockaddr_in6    DS                  QUALIFIED
     D   sin6_family                  5U 0
     D   sin6_port                    5U 0
     D   sin6_flowinfo...
     D                               10U 0
     D   sin6_addr                         LIKEDS(in6_addr)
     D   sin6_scope_id...
     D                               10U 0

      * sockaddr_afinet  structure for AF_INET and AF_INET6 addresses
     D sockaddrafinet  DS                  QUALIFIED
     D   sinstruct                         LIKEDS(sockaddr_in)
     D                                     OVERLAY(sockaddrafinet)
     D   sin6struct                        LIKEDS(sockaddr_in6)
     D                                     OVERLAY(sockaddrafinet)

     D LSTN0100        DS                  QUALIFIED
     D   BackLog                     10I 0
     D   LclBndAdrLen                10I 0
     D   LclBndAdr                         LIKEDS(sockaddrafinet)

     D Inet_ntoa       PR              *   EXTPROC('inet_ntoa')
     D  internet_addr                10U 0 VALUE

     C
     C     *ENTRY        PLIST
     C                   Parm                    Lstn0100
     C                   Parm                    RtnCode           1

     C                   Eval      *InLr = *On

     C                   Eval      SRVTYPE = 'LISTEN'
     C                   Eval      RtnCode = '0'

     C                   Eval      sockaddr_in.sin_addr =
     C                             Lstn0100.LclBndAdr.sinstruct.SIN_ADDR
     C                   Eval      sockaddr_in.sin_port =
     C                             Lstn0100.LclBndAdr.sinstruct.SIN_PORT
     C                   Eval      LclBndIP    =
     C                                 %STR(INET_NTOA(sockaddr_in.sin_addr))
     C                   Eval      LcLBndPort  =%Char(sockaddr_in.sin_port)
      *
     C                   Eval      WRTTIME = %TimeStamp
     C
     C                   Write     SktExitR
