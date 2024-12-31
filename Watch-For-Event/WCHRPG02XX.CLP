/* ================================================================ */
/*                                                                  */
/* Program    : WCHRPG02XX                                          */
/*                                                                  */
/* Description: Watch RPG   PGM ERROR                               */
/*                                               CALLED             */
/*                          PGM STMT PGMLIB      PGM                */
/*              RPG01XX     &1  &2   &3                             */
/*              RPG0120     &1       &3                             */

/*              RPG02XX     &1  &2   &3                             */
/*              RPG03XX     &1  &2   &3                             */
/*              RPG04XX     &1  &2   &3                             */
/*              RPG04XX     &1  &2   &3                             */
/*              RPG05XX     &1  &2   &3                             */
/*              RPG0299                                             */

/*                                                                  */
/* Date       : 2024/12/31                                          */
/*                                                                  */
/* Author     : Vengoal Chang                                       */
/* ================================================================ */
/*                                                                  */
/*                                                                  */
/* CRTCLPGM PGM(WCHRPG02XX)                                         */
/*                                                                  */
/*                                                                  */
/* STRWCH SSNID(WCHRPG02XX)                                         */
/*        WCHPGM(QGPL/WCHRPG02XX)                                   */
/*        WCHMSG( (RPG02*) (RPG03*) (RPG04*) (RPG05*) )             */
/*        WCHMSGQ((*SYSOPR))                                        */
/*                                                                  */
/* ================================================================ */

     Pgm        Parm(&Type &Session &Error &Data)
     Dcl        Var(&Type)      Type(*Char) Len(10)
     Dcl        Var(&Session)   Type(*Char) Len(10)
     Dcl        Var(&Error)     Type(*Char) Len(10)
     Dcl        Var(&Data)      Type(*Char) Len(2000)

     Dcl        Var(&LenEvtDta) Type(*Int)  Len(4) +
                     Stg(*Defined) DefVar(&Data   1)
     Dcl        Var(&Job)       Type(*Char) Len(10) +
                     Stg(*Defined) DefVar(&Data 33)
     Dcl        Var(&User)      Type(*Char) Len(10) +
                     Stg(*Defined) DefVar(&Data 43)
     Dcl        Var(&Nbr )      Type(*Char) Len( 6) +
                     Stg(*Defined) DefVar(&Data 53)
     Dcl        Var(&MsgID)     Type(*Char) Len(7) +
                     Stg(*Defined) DefVar(&Data 5)
     Dcl        Var(&MsgKey)    Type(*Char) Len( 4) +
                     Stg(*Defined) DefVar(&Data 387)
     Dcl        Var(&MsgF)      Type(*Char) Len(10) +
                     Stg(*Defined) DefVar(&Data 391)
     Dcl        Var(&MsgFLib)   Type(*Char) Len(10) +
                     Stg(*Defined) DefVar(&Data 401)
     Dcl        Var(&OffRplDta) Type(*Int)  Len(4) +
                     Stg(*Defined) DefVar(&Data 441)
     Dcl        Var(&LenRplDta) Type(*Int)  Len(4) +
                     Stg(*Defined) DefVar(&Data 445)
     Dcl        Var(&OrgLenRpl) Type(*Int)  Len(4) +
                     Stg(*Defined) DefVar(&Data 59)

     Dcl        Var(&MsgDtaPtr) Type(*Ptr)
     Dcl        Var(&MsgDta)    Type(*Char) Len(1010) +
                     Stg(*Based)   BasPtr(&MsgDtaPtr)

     Dcl        Var(&QualMsgf)   Type(*Char) Len(20)
     Dcl        Var(&MsgTxt )    Type(*Char) Len(1024)
     Dcl        Var(&SecLvl )    Type(*Char) Len(1024)
     Dcl        Var(&RplDta )    Type(*Char) Len(1024)

     Dcl        &ErrPgm     *Char 10
     Dcl        &ErrPgmLib  *Char 10
     Dcl        &ErrMsgID   *Char  7
     Dcl        &ErrPgmStmt *Char 10
     Dcl        &Reply      *Char  1

/* Check to make sure this is a *MSGID watch                         */
    If          Cond(&Type = '*MSGID') Then(Do)

    ChgVar      &MsgDtaPtr  Value(%Addr(&Data))
    Chgvar      %Offset(&MsgDtaPtr)  +
                    Value(%Offset(&MsgDtaPtr) + &OffRplDta)

    ChgVar      &RplDta       %sst(&MsgDta 1 &LenRplDta)
    ChgVar      &QualMsgf     (&MsgF *Cat &MsgFLib)

    RtvMsg      MsgID( &MsgID )                          +
                MsgF( &MsgFLib/&MsgF )                   +
                MsgDta( &RplDta )                        +
                Msg( &MsgTxt )                           +
                Seclvl( &SecLvl )

    ChgVar      &MsgTxt      ( &MsgID           *BCAT    +
                               &Msgtxt          *BCAT    +
                               '&N WRKJOB JOB('    *CAT     +
                               &Nbr  *CAT  '/'  *CAT     +
                               &User *TCAT '/'  *CAT     +
                               &Job  *TCAT ')'  *BCAT    +
                               'see job dump.' *BCAT    +
                               &SecLvl )

    Select
    When      ( &MsgID *NE 'RPG0299' )                Do
    ChgVar      &ErrPgm       %sst(&MsgDta  1 10 )
    ChgVar      &ErrPgmLib    %sst(&MsgDta 21 10 )
    Chgvar      &ErrPgmStmt   %sst(&MsgDta 11 10 )
    Chgvar      &Reply        'D'
    EndDo

    When      ( &MsgID *EQ 'RPG0299' )                Do
    Chgvar      &Reply        'S'
    EndDo

    EndSelect

    SndPgmMsg   MsgId(CPF9898)                           +
                Msgf(QCPFMSG)                            +
                MsgDta(&MsgTxt)                          +
                ToMsgq(QGPL/JOBDUMP)

    SndRpy      MsgKey( &MSGKEY )                        +
                Msgq( QSYS/QSYSOPR )                     +
                Rpy( &REPLY )                            +
                Rmv( *NO )
    Monmsg      CPF2422

    EndDo /* End If &Type = *MSGID */

    ChgVar       Var(&Error) Value('          ')
    EndPgm
