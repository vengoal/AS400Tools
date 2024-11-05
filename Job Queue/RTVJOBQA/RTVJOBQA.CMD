/*  ===============================================================  */
/*  = Command....... RtvJobqA                                     =  */
/*  = CPP........... RtvJobqA  CLP                                =  */
/*  = Description... Retrieve job queue attributes                =  */
/*  =                produced by the QSPRJOBQ API.                =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( RtvJobqA  )                                =  */
/*  =             Pgm( RtvJobqA   )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  =             Allow( (*BPGM) (*IPGM ) )                       =  */
/*  ===============================================================  */
/*  = Date  : 2024/11/04                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             CMD        Prompt('Retrieve Job Queue Attributes')
             Parm       Kwd( JOBQ )                                  +
                        Type( QUAL1 )                                +
                        Min( 1 )                                     +
                        Prompt( 'Job queue' )

             Parm       Kwd( RTNLIB )                                +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'Actual library name       (10)' )

             Parm       Kwd( OPRCTL )                                +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'Operator control          (10)' )

             Parm       Kwd( AUTCHK )                                +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'Authority check           (10)' )

             Parm       Kwd( NBRJOBS )                               +
                        Type( *Dec  )                                +
                        Len( 9 0 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'Number of jobs           (9 0)' )

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

             Parm       Kwd( SEQNBR )                                +
                        Type( *Dec  )                                +
                        Len( 9 0 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'SBSD jobq entry seq nbr  (9 0)' )

             Parm       Kwd( MAXACT )                                +
                        Type( *Dec  )                                +
                        Len( 9 0 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'Maximum active jobs      (9 0)' )

             Parm       Kwd( CURACT )                                +
                        Type( *Dec  )                                +
                        Len( 9 0 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'Current active jobs      (9 0)' )

             Parm       Kwd( TEXT )                                  +
                        Type( *Char )                                +
                        Len( 50 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'Text description          (50)' )

 QUAL1:      Qual       Type( *NAME )                                +
                        Len( 10 )                                    +
                        Min( 1 )                                     +
                        Expr( *YES )

             Qual       Type(*NAME)                                  +
                        Len( 10 )                                    +
                        Dft( *LIBL )                                 +
                        SpcVal( (*LIBL) ) EXPR( *YES )               +
                        Prompt( 'Library name' )
