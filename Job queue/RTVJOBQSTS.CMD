/*  ===============================================================  */
/*  = Command....... RtvJobqSts                                   =  */
/*  = CPP........... RtvJobqSts RPGLE                             =  */
/*  = Description... Retrieve job queue status                    =  */
/*  =                produced by the QSPOLJBQ and QGYOLJOB API    =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( RtvJobqSts )                               =  */
/*  =             Pgm( RtvJobqSts )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  =             Allow( (*BPGM) (*IPGM ) )                       =  */
/*  ===============================================================  */
/*  = Date  : 2024/11/05                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             CMD        Prompt('Retrieve Job Queue Status')
             Parm       Kwd( JOBQ )                                  +
                        Type( QUAL1 )                                +
                        Min( 1 )                                     +
                        Prompt( 'Job queue' )

             Parm       Kwd( RTNLIB )                                +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'Actual library name       (10)' )

             Parm       Kwd( QSTATUS )                               +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'Job queue status          (10)' )

             Parm       Kwd( SBSNAM )                                +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'Subsystem name            (10)' )

             Parm       Kwd( SBSLIB )                                +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'Subsystem library         (10)' )

             Parm       Kwd( CURACT )                                +
                        Type( *Dec  )                                +
                        Len( 9 0 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'Current active jobs      (9 0)' )

             Parm       Kwd( SCDJOB )                                +
                        Type( *Dec  )                                +
                        Len( 9 0 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'Scheduled jobs in jobq   (9 0)' )

             Parm       Kwd( HLDJOB )                                +
                        Type( *Dec  )                                +
                        Len( 9 0 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'Held     jobs in jobq    (9 0)' )

             Parm       Kwd( RLSJOB )                                +
                        Type( *Dec  )                                +
                        Len( 9 0 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'Released jobs in jobq    (9 0)' )


 QUAL1:      Qual       Type( *NAME )                                +
                        Len( 10 )                                    +
                        Min( 1 )                                     +
                        Expr( *YES )

             Qual       Type(*NAME)                                  +
                        Len( 10 )                                    +
                        Dft( *LIBL )                                 +
                        SpcVal( (*LIBL) ) EXPR( *YES )               +
                        Prompt( 'Library name' )
