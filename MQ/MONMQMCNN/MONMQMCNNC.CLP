/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : MONMQMCNN CPP                                      */
/*  Description : Output MQ connection info to File                  */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : December 27, 2017                                  */
/*                                                                   */
/*  Program function:  Output MQ Connection info to file             */
/*                                                                   */
/*                                                                   */
/*  Program summary                                                  */
/*  ---------------                                                  */
/*                                                                   */
/*  Connection record spec as following:                             */
/*  Type CONN as following:                                          */
/*  Name          POS     LEN   NOTE                                 */
/*  ===========   ======= ===   ================================     */
/*  ConnId        001-016  16                                        */
/*  ConnInfoType  017-022   6                                        */
/*  ApplTag       023-044  28                                        */
/*  ApplType      051-056   6                                        */
/*  ChannelName   057-076  20                                        */
/*  ConnName      077-140  64                                        */
/*  UserId        141-204  64                                        */
/*  ProcessId     205-213   9                                        */
/*  ThreadId      214-217   4                                        */

/*  Type HANDLE  as following:                                       */
/*  Name          POS     LEN   NOTE                                 */
/*  ===========   ======= ===   ================================     */
/*  ConnId        001-016  16                                        */
/*  ConnInfoType  017-022   6                                        */
/*  ObjectName    201-248  48                                        */
/*  ObjectType    249-256   8                                        */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( MONMQMCNNC )                                   */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*  Exception RC:                                                    */
/*    RC2058     QMGR NAME ERROR                                     */
/*    RC2085     MQ UNKNOWN OBJECT NAME                              */
/*    RC4044     MQRCCF_CHANNEL_NAME_ERROR                           */
/*-------------------------------------------------------------------*/
     Pgm      ( &MqmName               +
                &QualOutF              +
                &RC                    +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &MqmName     *Char    48
     Dcl        &QualOutF    *Char    20
     Dcl        &RC          *CHAR     4
     Dcl        &OutFile     *Char    10
     Dcl        &OutFileLib  *Char    10
     Dcl        &CurRcd      *Dec    (10 0)
     Dcl        &CurRcdC     *Char    10


/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error

     ChgVar     &OutFile     %SST(&QualOutF  1 10)
     ChgVar     &OutFileLib  %SST(&QualOutF 11 10)
     ChkObj     Obj(&OutFileLib/&OutFile) ObjType(*FILE)
     MonMsg     CPF9801      *N        Do
     CrtPf      File(&OutFileLib/&OutFile) +
                RcdLen(512)
     EndDo

     ClrPfm     &OutFileLib/&OutFile

     Call       MonMqmCnn (&MqmName &QualOutF &RC)
     SndPgmMsg  Msg('Queue manager' *Bcat &MqmName *Bcat +
                    'output channel status RC:' *Bcat &RC *cat '.')

     RtvMbrD    File(&OutFileLib/&OutFile) NbrCurRcd(&CurRcd)
     If         (&CurRcd *GT 0) Do
     ChgVar     &CurRcdC   &CurRcd
     SndPgmMsg  Msg('Queue manager' *Bcat &MqmName *Bcat 'have' *Bcat +
                    &CurRcdC *Bcat 'current connection' *Bcat +
                    'record in file' *Bcat +
                    &OutFileLib *Tcat '/' *Cat &OutFile *Tcat '.')
     EndDo
     Else Do
     SndPgmMsg  Msg('Queue manager' *Bcat &MqmName *Bcat +
                    'have no any connection' *Bcat +
                    'status record in file' *Bcat +
                    &OutFileLib *Tcat '/' *Cat &OutFile *Tcat '.')
     EndDo

 Return:

     Return

/*-- Error handling:  -----------------------------------------------*/
 Error:
     Call      QMHMOVPM    ( '    '                                  +
                             '*DIAG'                                 +
                             x'00000001'                             +
                             '*PGMBDY'                               +
                             x'00000001'                             +
                             x'0000000800000000'                     +
                           )

     Call      QMHRSNEM    ( '    '                                  +
                             x'0000000800000000'                     +
                           )

 EndPgm:
     EndPgm
