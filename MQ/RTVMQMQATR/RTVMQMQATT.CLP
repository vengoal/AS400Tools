Pgm

   Dcl        &QName         *Char         48    'SYSTEM.DEFAULT.LOCAL.QUEUE'
   Dcl        &Qmgr          *Char         48    'TEST1'

/* D* INHIBIT GET VALUES                                       */
/* D QAGETI          C                   CONST(1)  ALLOWED     */
/* D QAGETA          C                   CONST(0)  NOT ALLOWED */
/* D* INHIBIT PUT VALUES                                       */
/* D QAPUTI          C                   CONST(1)  ALLOWED     */
/* D QAPUTA          C                   CONST(0)  NOT ALLOWED */
   Dcl        &InhibitGet    *Int
   Dcl        &InhibitPut    *Int

   Dcl        &NbrOfMsg      *Int

   Dcl        &OPNINPCNT     *Int
   Dcl        &OPNOUTCNT     *Int

/* D* QUEUE TYPES                                              */
/* D QTLOC           C                   CONST(1)  LOCAL       */
/* D QTMOD           C                   CONST(2)  MODEL       */
/* D QTALS           C                   CONST(3)  ALIAS       */
/* D QTREM           C                   CONST(6)  REMOTE      */
/* D QTCLUS          C                   CONST(7)  CLUSTER     */
   Dcl        &QType         *Int

/* D* QUEUE USAGES                                              */
/* D USNORM          C                   CONST(0)  NORMAL       */
/* D USTRAN          C                   CONST(1)  TRANSMISSION */
   Dcl        &QUsage        *Int

   Dcl        &ERRAPI        *Char         10
   Dcl        &REASON        *Char         10

   RTVMQMQATR                &QName              +
                             &Qmgr               +
                             &InhibitGet         +
                             &InhibitPut         +
                             &NbrOfMsg           +
                             &OPNINPCNT          +
                             &OPNOUTCNT          +
                             &QType              +
                             &QUsage             +
                             &ERRAPI             +
                             &REASON             +

   DmpClPgm
EndPgm
