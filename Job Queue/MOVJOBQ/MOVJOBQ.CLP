/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : MOVJOBQ                                            */
/*  Description : Move jobs in jobqueue to other jobqueue            */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : November 26, 2024                                  */
/*                                                                   */
/*  Program function:  MOVJOBQ    command processing program         */
/*                                                                   */
/*  Program summary                                                  */
/*  ---------------                                                  */
/*                                                                   */
/*  Work management APIs:                                            */
/*    QUSCRTUS    Creates a user space.                              */
/*    QUSCUSAT    Changes the attributes of a user space object      */
/*    QUSRTVUS    Retrieves the contents of a user space             */
/*    QUSLJOB     List Jobs                                          */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtCLPgm   Pgm( MOVJOBQ )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/

     Pgm      ( &FromJobQ                                            +
                &ToJobQ                                              +
                &Job                                                 +
                &Status                                              +
                &Action                                              +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &FromJobQ    *Char    20
     Dcl        &ToJobQ      *Char    20
     Dcl        &Job         *Char    10
     Dcl        &Status      *Char    10
     Dcl        &Action      *Char     4

     Dcl        &FrmJobQNam  *Char    10
     Dcl        &FrmJobQLib  *Char    10
     Dcl        &ToJobQNam   *Char    10
     Dcl        &ToJobQLib   *Char    10
     Dcl        &FJobQQual   *Char    20
     Dcl        &JobQQual    *Char    20

     Dcl        &JobName     *Char    10
     Dcl        &JobUser     *Char    10
     Dcl        &JobNbr      *Char     6
     Dcl        &JobStatus   *Char    10
     Dcl        &JobType     *Char     1
     Dcl        &SubType     *Char     1
     Dcl        &OnJobqSts   *Char    10

/*--  Parameters for the QUSCRTUS  API ------------------------------*/

     Dcl        &Usp_Name    *Char    10
     Dcl        &Usp_Lib     *Char    10
     Dcl        &Usp_Qual    *Char    20
     Dcl        &Usp_Type    *Char    10
     Dcl        &Usp_Size    *Char     4
     Dcl        &Usp_Fill    *Char     1
     Dcl        &Usp_Aut     *Char    10
     Dcl        &Usp_Text    *Char    50
     Dcl        &Usp_Repl    *Char    10

/*--  Parameters for the QUSRTVUS  API ------------------------------*/

     Dcl        &StartPos    *Char    4
     Dcl        &DataLen     *Char    4
     Dcl        &Header      *Char  150

/*--  List data section ---------------------------------------------*/

     /*  offset to first data                                        */
     Dcl        &Lst_Offset  *Dec   (10 0 )
     /*  size of data                                                */
     Dcl        &Lst_Size    *Dec   (10 0 )
     /*  List data entry                                             */
     Dcl        &Lst_Data    *Char 4096
     /*  number of entries in List data section                      */
     Dcl        &Lst_Nbr     *Dec   ( 9 0 )
     /*  entry length in decimal                                     */
     Dcl        &Lst_Len     *Dec   ( 9 0 )
     /*  entry length in binary                                      */
     Dcl        &Lst_LenBin  *Char    4
     /*  position of list entry in binary                            */
     Dcl        &Lst_PosBin  *Char    4
     /*  counter                                                     */
     Dcl        &Lst_Count   *Dec   ( 9 0 ) Value( 0 )

/*--  Parameters for the QUSLJOB   API ------------------------------*/

      /*  qualified jobname                                  */
      Dcl       &API_JBQUAL  *Char   26
      /*  jobname                                            */
      Dcl       &API_JBNAM   *Char   10
      /*  user                                               */
      Dcl       &API_USER    *Char   10
      /*  Job number                                         */
      Dcl       &API_JOBNR   *Char    6
      /*  Status                                             */
      Dcl       &API_STATUS  *Char   10
      /*  Job type                                           */
      Dcl       &API_JBTYPE  *Char    1
      /*  Number of fields to return                         */
      Dcl       &API_NBRFLD  *Char    4
      /*  Key of field to return                             */
      Dcl       &API_KEY     *Char    8
      Dcl       &API_KEY1    *Char    4
      Dcl       &API_KEY2    *Char    4

/*--  Parameters for the QUSCUSAT  API ------------------------------*/
      Dcl       &USP_RTNL    *Char   10
      Dcl       &USP_CHGATR  *Char   16
      Dcl       &USP_ATRREC  *Char    4
      Dcl       &USP_ATRLEN  *Char    4
      Dcl       &USP_ATRKEY  *Char    4
      Dcl       &USP_ATRDTA  *Char    1

      Dcl       &NBR         *Dec    (7 0) VALUE(0)
      Dcl       &NBR_CHR     *Char   (7)

/*-- Global error monitoring:  --------------------------------------*/
      MonMsg      CPF0000      *N        GoTo Error

      Chgvar    &FrmJobQNam       %SST(&FromJobQ 1 10)
      Chgvar    &FrmJobQLib       %SST(&FromJobQ 11 10)
      Chgvar    &ToJobQNam        %SST(&ToJobQ 1 10)
      Chgvar    &ToJobQLib        %SST(&ToJobQ 11 10)
      ChkObj    Obj(&ToJobQLib/&ToJobQNam)                           +
                ObjType(*JOBQ)

      RtvObjD   Obj(&FRMJOBQLIB/&FRMJOBQNAM)                         +
                ObjType(*JOBQ)                                       +
                RtnLib(&FrmJobQLib)
      Chgvar    &FJobQQual      ( &FrmJobQNam *CAT &FrmJobQLib )

      /*  -------------------------------------------------  */
      /*  Create USER SPACE                                  */
      /*  -------------------------------------------------  */

      /*  Set user space name                                */
      Chgvar    &USP_NAME       ( 'MOVJOBQ' )
      /*  Set user space library                             */
      Chgvar    &USP_LIB        ( 'QTEMP' )
      /*  Set user space qualified name                      */
      Chgvar    &USP_QUAL       ( &USP_NAME *CAT &USP_LIB )
      /*  Set user space type                                */
      Chgvar    &USP_TYPE       ( 'MYTYPE' )
      /*  Set user space size                                */
      Chgvar    %BIN(&USP_SIZE)   81960
      /*  Set user space fill character                      */
      Chgvar    &USP_FILL         ' '
      /*  Set user space authority                           */
      Chgvar    &USP_AUT          '*USE'
      /*  Set user space text                                */
      Chgvar    &USP_TEXT         'my user space'
      /*  Set user space authority                           */
      Chgvar    &USP_REPL         '*YES'

      /*  Create user space                                  */
      Call      QUSCRTUS        ( &USP_QUAL                          +
                                  &USP_TYPE                          +
                                  &USP_SIZE                          +
                                  &USP_FILL                          +
                                  &USP_AUT                           +
                                  &USP_TEXT                          +
                                  &USP_REPL                          +
                                  X'00000000'                        +
                                )

      Chgvar    %BIN(&USP_ATRREC)  1
      Chgvar    %BIN(&USP_ATRKEY)  3
      Chgvar    %BIN(&USP_ATRLEN)  1
      Chgvar    &USP_ATRDTA       '1'
      Chgvar    &USP_CHGATR     (                                    +
                                  &USP_ATRREC *CAT &USP_ATRKEY *CAT  +
                                  &USP_ATRLEN *CAT &USP_ATRDTA )

      /* Set automatic extendibility */
      Call      QUSCUSAT        ( &USP_RTNL                          +
                                  &USP_QUAL                          +
                                  &USP_CHGATR                        +
                                  X'00000000'                        +
                                )

      Chgvar    &API_JBNAM        '*ALL'
      Chgvar    &API_USER         '*ALL'
      Chgvar    &API_JOBNR        '*ALL'
      /*  Set qualified jobname                              */
      Chgvar     &API_JBQUAL    ( &API_JBNAM *CAT +
                                  &API_USER *CAT &API_JOBNR)
      Chgvar     &API_JBQUAL    ( &JOB       *CAT +
                                  &API_USER *CAT &API_JOBNR)
      /*  Set Job status                                     */
      Chgvar     &API_STATUS      '*JOBQ'
      /*  Set Job type                                       */
      Chgvar     &API_JBTYPE      'B'
      /*  Set number of fields to return                     */
      Chgvar     %BIN(&API_NBRFLD) 2
      /*  Set Key                                            */
      Chgvar     %BIN(&API_KEY1)  1004
      Chgvar     %BIN(&API_KEY2)  1903
      Chgvar     &API_KEY       ( &API_KEY1 *CAT &API_KEY2 )

      CALL       QUSLJOB        ( &USP_QUAL                          +
                                  'JOBL0200'                         +
                                  &API_JBQUAL                        +
                                  &API_STATUS                        +
                                  X'0000000000000000'                +
                                  &API_JBTYPE                        +
                                  &API_NBRFLD                        +
                                  &API_KEY                           +
                                )

      /*  -------------------------------------------------  */
      /*  Retrieve user space HEADER information             */
      /*  -------------------------------------------------  */

      /*  Set start position                                 */
      Chgvar     %BIN(&STARTPOS)  1
      /*  Set data length                                    */
      Chgvar     %BIN(&DATALEN)   140

      /*  Retrieve  Header description information           */
      Call       QUSRTVUS       ( &USP_QUAL                          +
                                  &STARTPOS                          +
                                  &DATALEN                           +
                                  &HEADER                            +
                                )

      /*  Retrieve  data in List section                     */
      /*  -------------------------------------------------  */
      Chgvar     &LST_OFFSET      %BIN(&HEADER 125 4)
      Chgvar     &LST_SIZE        %BIN(&HEADER 129 4)
      Chgvar     &LST_NBR         %BIN(&HEADER 133 4)
      Chgvar     &LST_LEN         %BIN(&HEADER 137 4)

      Chgvar     %BIN(&LST_POSBIN) (&LST_OFFSET + 1)
      Chgvar     &LST_LENBIN      %SST(&HEADER 137 4)

      /*  -------------------------------------------------  */
      /*  Retrieve  List data entries                        */
      /*  -------------------------------------------------  */

      Chgvar     &LST_COUNT       0  /* initialize +
                          number of list entries counter */

 LST_LOOP:
      IF       ( &LST_COUNT *EQ &LST_NBR )   ( GOTO LST_END )

      Call       QUSRTVUS       ( &USP_QUAL                          +
                                  &LST_POSBIN                        +
                                  &LST_LENBIN                        +
                                  &LST_DATA                          +
                                )

      /*  Extract fields                                     */

      Chgvar     &JOBNAME         %SST( &LST_DATA 1 10 )
      Chgvar     &JOBUSER         %SST( &LST_DATA 11 10 )
      Chgvar     &JOBNBR          %SST( &LST_DATA 21 6 )
      Chgvar     &JobStatus       %SST( &LST_DATA 43 10 )
      Chgvar     &JOBTYPE         %SST( &LST_DATA 53 1 )
      Chgvar     &SUBTYPE         %SST( &LST_DATA 54 1 )

      Chgvar     &JOBQQUAL        %SST( &LST_DATA 81 20 )
      Chgvar     &OnJobqSts       %SST( &LST_DATA 117 10 )

      /*  -------------------------------------------------  */
      /*  Action to be performed for each list data entry    */
      /*  -------------------------------------------------  */
      If       ( &JOBQQUAL *NE &FJOBQQUAL)    ( GOTO LST_NEXT )

      If       ( &Job  *EQ '*ALL'    *OR                             +
                 &Job  *EQ &JobName      )  DO
      If       ( &Status *EQ '*ALL'  *OR                             +
                 &Status *EQ &OnJobqSts  )   Do
      If       ( &Action *EQ '*MOV' ) Do
      ChgJob     Job( &JOBNBR/&JOBUSER/&JOBNAME )                    +
                 JobQ( &TOJOBQLIB/&TOJOBQNAM )
      Monmsg     MsgID(CPF0000) EXEC( GOTO LST_NEXT )
      EndDo
      Else                                                           +
      SndPgmMsg  Msg( &JobNbr *CAT '/' *CAT &JobUser                 +
                              *TCAT '/' *CAT &JobName                +
                              *Bcat &OnJobqSts)                      +
                 MsgType(*INFO)

      Chgvar     &NBR           ( &NBR + 1 )
      EndDo
      EndDo

      /*     End action  for 1 list data entry               */

 LST_NEXT:
      Chgvar     &LST_COUNT      ( &LST_COUNT + 1 )
      Chgvar     %BIN( &LST_POSBIN ) +
                 (%BIN(&LST_POSBIN) + &LST_LEN)
      Goto       LST_LOOP

             /*  Delete User space                                  */
 LST_END:
      DltUsrSpc  &USP_LIB/&USP_NAME

      Chgvar     &NBR_CHR         &NBR
      SndPgmMsg  Msg( &NBR_CHR *BCAT 'jobs moved. ')                 +
                 MsgType( *COMP )

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
