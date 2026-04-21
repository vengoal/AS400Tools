Pgm

   Dcl        &QName         *Char         48    'SYSTEM.DEFAULT.LOCAL.QUEUE'
   Dcl        &MQMName       *Char         48    'TEST1'
   Dcl        &JOBCNT        *Dec        (  5 0)
   Dcl        &JOBLIST       *Char       1400
   Dcl        &MQERROR       *Lgl
   Dcl        &CC            *Dec        ( 10 0)
   Dcl        &RC            *Dec        ( 10 0)
   Dcl        &MQINFO        *Char        256

   RTVMQMQH    QName(   &QName   )          +
               MQMName( &MQMName )          +
               JOBCNT(  &JOBCNT  )          +
               JOBLIST( &JOBLIST )          +
               MQERROR( &MQERROR )          +
               CC(      &CC      )          +
               RC(      &RC      )          +
               MQINFO(  &MQINFO  )

   Chgvar     &QName    'TEST1.LQ'
   RTVMQMQH    QName(   &QName   )          +
               MQMName( &MQMName )          +
               JOBCNT(  &JOBCNT  )          +
               JOBLIST( &JOBLIST )          +
               MQERROR( &MQERROR )          +
               CC(      &CC      )          +
               RC(      &RC      )          +
               MQINFO(  &MQINFO  )
   dmpclpgm
EndPgm
