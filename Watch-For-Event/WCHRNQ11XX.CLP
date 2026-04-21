/* ================================================================ */
/*                                                                  */
/* Program    : WCHRNQ11XX                                          */
/*                                                                  */
/* Description: Watch RPGLE PGM ERROR                               */
/*              RNQ11XX                                             */
/*              RNQ12XX                                             */
/*              RNQ13XX                                             */
/*                                                                  */
/* Date       : 2024/12/24                                          */
/*                                                                  */
/* Author     : Vengoal Chang                                       */
/* ================================================================ */
/*                                                                  */
/*                                                                  */
/* CRTCLPGM PGM(WCHRNQ11XX)                                         */
/*                                                                  */
/*                                                                  */
/* STRWCH SSNID(WCHRNQ11XX)                                         */
/*        WCHPGM(QGPL/WCHRNQ11XX)                                   */
/*        WCHMSG((RNQ11*) (RNQ12*) (RNQ13*))                        */
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

/* Check to make sure this is a *MSGID watch                         */
    If          Cond(&Type = '*MSGID') Then(Do)

/* Check to make sure this is for CPA0701 CPA0702                    */

    ChgVar      &MsgDtaPtr  Value(%Addr(&Data))
    Chgvar      %Offset(&MsgDtaPtr)  +
                    Value(%Offset(&MsgDtaPtr) + &OffRplDta)

    ChgVar      &RplDta       %sst(&MsgDta 1 &LenRplDta)
    ChgVar      &QualMsgf     (&MsgF *Cat &MsgFLib)

    ChgVar      &ErrPgm       %sst(&MsgDta  1 10 )
    ChgVar      &ErrPgmLib    %sst(&MsgDta 11 10 )
    ChgVar      &ErrMsgId     %sst(&MsgDta 21  7 )
    Chgvar      &ErrPgmStmt   %sst(&MsgDta 28 10 )

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

    SndPgmMsg   MsgId(CPF9898)                           +
                Msgf(QCPFMSG)                            +
                MsgDta(&MsgTxt)                          +
                ToMsgq(QGPL/JOBDUMP)

    SndRpy      MsgKey( &MSGKEY )                        +
                Msgq( QSYS/QSYSOPR )                     +
                Rpy( D )                                 +
                Rmv( *NO )
    Monmsg      CPF2422

    EndDo /* End If &Type = *MSGID */

    ChgVar       Var(&Error) Value('          ')
    EndPgm
