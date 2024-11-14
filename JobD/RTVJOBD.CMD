/*  ===============================================================  */
/*  = Command....... RtvJobD                                      =  */
/*  = CPP........... RtvJobD   CLP                                =  */
/*  = Description... Retrieve job Description Information         =  */
/*  =                produced by the QWDRJOBD API.                =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( RtvJobD   )                                =  */
/*  =             Pgm( RtvJobD    )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  =             Allow( (*BPGM) (*IPGM ) )                       =  */
/*  ===============================================================  */
/*  = Date  : 2024/11/13                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             CMD        PROMPT('Retrieve job description')
             Parm       Kwd( JOBD )                                  +
                        Type( QUAL1 )                                +
                        Min( 1 )                                     +
                        Prompt( 'Job description' )

             Parm       Kwd( RTNLIB )                                +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for RTNLIB       (10)')

             Parm       Kwd( USER )                                  +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for USER         (10)')

             Parm       Kwd( JOBQ )                                  +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for JOBQ         (10)')

             PARM       Kwd( JOBQLIB )                               +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for JOBQLIB      (10)')

             Parm       Kwd( JOBPTY )                                +
                        Type( *CHAR )                                +
                        Len(  2 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for JOBPTY        (2)')

             Parm       Kwd( PRTDEV )                                +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for PRTDEV       (10)')

             Parm       Kwd( LOGCLPGM )                              +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for LOGCLPGM     (10)')

             Parm       Kwd( INQMSGRPY )                             +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for INQMSGRPY    (10)')

             Parm       Kwd( ACGCDE )                                +
                        Type( *Char )                                +
                        Len( 15 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for ACGCDE       (15)')

             Parm       Kwd( PRTTXT )                                +
                        Type( *CHAR )                                +
                        Len( 30 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for PRTTXT       (30)')

             Parm       Kwd( RTGDTA )                                +
                        Type( *Char )                                +
                        Len( 80 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for RTGDTA       (80)')

             Parm       Kwd( RQSDTA )                                +
                        Type( *Char )                                +
                        Len( 260 )                                   +
                        RtnVal( *YES )                               +
                        Prompt('CL var for RQSDTA      (260)')

             Parm       Kwd( SYNTAX )                                +
                        Type( *DEC  )                                +
                        Len(  2 0 )                                  +
                        RtnVal( *YES )                               +
                        Prompt('CL var for SYNTAX      (2 0)')

             Parm       Kwd( INLLIBL )                               +
                        Type( *Char )                                +
                        Len( 2750 )                                  +
                        RtnVal( *YES )                               +
                        Prompt('CL var for INLLIBL    (2750)')

             Parm       Kwd( ENDSEV )                                +
                        Type( *DEC  )                                +
                        Len(  2 0 )                                  +
                        RtnVal( *YES )                               +
                        Prompt('CL var for ENDSEV      (2 0)')

             Parm       Kwd( LOGSEV )                                +
                        Type( *DEC  )                                +
                        Len(  2 0 )                                  +
                        RtnVal( *YES )                               +
                        Prompt('CL var for LOGSEV      (2 0)')

             Parm       Kwd( LOGLVL )                                +
                        Type( *Char )                                +
                        Len(  1 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for LOGLVL        (1)')

             Parm       Kwd( LOGTXT )                                +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for LOGTXT       (10)')

             Parm       Kwd( OUTQ )                                  +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for OUTQ         (10)')

             Parm       Kwd( OUTQLIB )                               +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        PROMPT('CL var for OUTQLIB      (10)')

             Parm       Kwd( OUTPTY )                                +
                        Type( *CHAR )                                +
                        Len(  2 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for OUTPTY        (2)')

             Parm       Kwd( HOLD )                                  +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for HOLD         (10)')

             Parm       Kwd( DATE )                                  +
                        Type( *CHAR )                                +
                        Len(  8 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for DATE          (8)')

             PARM       Kwd( SWS )                                   +
                        Type( *CHAR )                                +
                        Len(  8 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for SWS           (8)')

             Parm       Kwd( DEVRCYACN )                             +
                        Type( *Char )                                +
                        Len( 13 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for DEVRCYACN    (13)')

             Parm       Kwd( TSEPOOL )                               +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for TSEPOOL      (10)')

             Parm       Kwd( JOBMSGQMAX )                            +
                        Type( *DEC  )                                +
                        Len(  3 0 )                                  +
                        RtnVal( *YES )                               +
                        Prompt('CL var for JOBMSGQMAX ( 3 0)')

             Parm       Kwd( JOBMSGQFUL )                            +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for JOBMSGQFUL   (10)')

             Parm       Kwd( ALWMLTTHD )                             +
                        Type( *Char )                                +
                        Len(  10 )                                   +
                        RtnVal( *YES )                               +
                        Prompt('CL var for ALWMLTTHD    (10)')

             Parm       Kwd( SplfAcn   )                             +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for SPLFACN      (10)')

             Parm       Kwd( InlAspGrp )                             +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for INLASPGRP    (10')

             Parm       Kwd( DdmCnv )                                +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for DDMCNV       (10)')

             Parm       Kwd( LogOutput )                             +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for LOGOUTPUT    (10)')

             Parm       Kwd( TEXT )                                  +
                        Type( *Char )                                +
                        Len( 50 )                                    +
                        RtnVal( *YES )                               +
                        Prompt('CL var for TEXT         (50)')

 QUAL1:      Qual       Type( *NAME )                                +
                        Len( 10 )                                    +
                        Min( 1 )                                     +
                        Expr( *YES )

             Qual       Type(*NAME)                                  +
                        Len( 10 )                                    +
                        Dft( *LIBL )                                 +
                        SpcVal( (*LIBL) ) EXPR( *YES )               +
                        Prompt( 'Library name' )

