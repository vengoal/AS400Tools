     PGM

     ENDWCH SSNID(WCHCPA070X)
     MONMSG CPF0000
     ENDWCH SSNID(WCHRNQ01XX)
     MONMSG CPF0000
     ENDWCH SSNID(WCHRNQ08XX)
     MONMSG CPF0000
     ENDWCH SSNID(WCHRNQ11XX)
     MONMSG CPF0000
     ENDWCH SSNID(WCHRPG01XX)
     MONMSG CPF0000
     ENDWCH SSNID(WCHRPG02XX)
     MONMSG CPF0000
     ENDWCH SSNID(WCHRPG08XX)
     MONMSG CPF0000
     ENDWCH SSNID(WCHRPG11XX)
     MONMSG CPF0000

     STRWCH SSNID(WCHCPA070X)                                        +
            WCHPGM(QGPL/WCHCPA070X)                                  +
            WCHMSG((CPA070*))                                        +
            WCHMSGQ((*SYSOPR))
     STRWCH SSNID(WCHRNQ01XX)                                        +
            WCHPGM(QGPL/WCHRNQ01XX)                                  +
            WCHMSG((RNQ01*) (RNQ02*) (RNQ03*) (RNQ04*) (RNQ05*))     +
            WCHMSGQ((*SYSOPR))
     STRWCH SSNID(WCHRNQ08XX)                                        +
            WCHPGM(QGPL/WCHRNQ08XX)                                  +
            WCHMSG((RNQ08*) (RNQ09*) (RNQ10*))                       +
            WCHMSGQ((*SYSOPR))
     STRWCH SSNID(WCHRNQ11XX)                                        +
            WCHPGM(QGPL/WCHRNQ11XX)                                  +
            WCHMSG((RNQ11*) (RNQ12*) (RNQ13*))                       +
            WCHMSGQ((*SYSOPR))

     STRWCH SSNID(WCHRPG01XX)                                        +
            WCHPGM(QGPL/WCHRPG01XX)                                  +
            WCHMSG( (RPG01*) )                                       +
            WCHMSGQ((*SYSOPR))

     STRWCH SSNID(WCHRPG02XX)                                        +
            WCHPGM(QGPL/WCHRPG02XX)                                  +
            WCHMSG( (RPG02*) (RPG03*) (RPG04*) (RPG05*) )            +
            WCHMSGQ((*SYSOPR))
     STRWCH SSNID(WCHRPG08XX)                                        +
            WCHPGM(QGPL/WCHRPG08XX)                                  +
            WCHMSG((RPG08*) (RPG09*) (RPG10*))                       +
            WCHMSGQ((*SYSOPR))
     STRWCH SSNID(WCHRPG11XX)                                        +
            WCHPGM(QGPL/WCHRPG11XX)                                  +
            WCHMSG((RPG11*) (RPG12*) (RPG13*) (RPG19*))              +
            WCHMSGQ((*SYSOPR))

     ENDPGM
