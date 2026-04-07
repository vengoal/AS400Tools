    Pgm

/*-- Global variables:  ---------------------------------------------*/
    Dcl   &QualJob    *Char    26
    Dcl   &IntJobIdp  *Char    16
    Dcl   &RtnMsgRpy  *Char     1
    Dcl   &RtnMsgKey  *Char     4
    Dcl   &RtnMsgq    *Char    10
    Dcl   &RtnMsgqLib *Char    10
    Dcl   &RtnMsgId   *Char     7
    Dcl   &RtnMsgType *Char     2
    Dcl   &RtnMsgTxt  *Char   132
    Dcl   &RtnSecLvl  *Char   256
    Dcl   &RtnMsgDta  *Char   192
    Dcl   &RtnMsgF    *Char    10
    Dcl   &RtnMsgFLib *Char    10
    Dcl   &ErrMsgId   *Char     7
    Dcl   &ErrPgm     *Char    10
    Dcl   &ErrPgmLib  *Char    10
    Dcl   &ErrPgmStmt *Char    10

/*-- Global error monitoring:  --------------------------------------*/
    MonMsg     CPF0000     *N       GoTo Error

    RTVJOBMSGW JOB(433363/VENGOAL/TESTERR)            +
               MSGRPY(&RTNMSGRPY)                     +
               MSGKEY(&RTNMSGKEY)                     +
               MSGQ(&RTNMSGQ  )                       +
               MSGQLIB(&RTNMSGQLIB  )                 +
               MSGID(&RTNMSGID  )                     +
               MSGTYPE(&RTNMSGTYPE  )                 +
               MSGTXT(&RTNMSGTXT  )                   +
               SECLVL(&RTNSECLVL   )                  +
               MSGDTA(&RTNMSGDTA )                    +
               MSGF(&RTNMSGF   )                      +
               MSGFLIB(&RTNMSGFLIB )                  +
               ERRPGM(&ERRPGM      )                  +
               ERRPGMLIB(&ERRPGMLIB)                  +
               ERRPGMSTMT(&ERRPGMSTMT)                +
               ERRMSGID(&ERRMSGID)                    +

    IF       ( &RTNMSGRPY *EQ '1' )       DO
    DMPCLPGM
    SELECT
    WHEN     ( &RTNMSGID  *EQ 'CPA0701'  *OR          +
               &RTNMSGID  *EQ 'CPA0702' ) DO
    SNDRPY     MSGKEY(&RTNMSGKEY)                     +
               MSGQ(&RTNMSGQLIB/&RTNMSGQ)             +
               RPY(D)                                 +
               RMV(*NO)
    ENDDO
    WHEN     ( &RTNMSGID  *EQ 'RNQ0102' ) DO
    SNDRPY     MSGKEY(&RTNMSGKEY)                     +
               MSGQ(&RTNMSGQLIB/&RTNMSGQ)             +
               RPY(D)                                 +
               RMV(*NO)
    ENDDO
    OTHERWISE                             DO
    ENDDO
    ENDSELECT

    ENDDO    /* END &RTNMSGRPY */

 Return:
     Return

/*-- Error processor ------------------------------------------------*/
 Error:
    Call       QMHMOVPM    ( '    '                             +
                             '*DIAG'                            +
                             x'00000001'                        +
                             '*PGMBDY   '                       +
                             x'00000001'                        +
                             x'0000000800000000'                +
                           )

     Call      QMHRSNEM    ( '    '                             +
                             x'0000000800000000'                +
                           )


 EndPgm:
     EndPgm
