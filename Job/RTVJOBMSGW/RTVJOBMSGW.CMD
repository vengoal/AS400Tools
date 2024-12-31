/*  ===============================================================  */
/*  = Command....... RtvJobMsgw                                   =  */
/*  = CPP........... RtvJobMsgw CLP                               =  */
/*  = Description... Retrieve job waiting for job msgkey & msgq   =  */
/*  =                produced by the QMHSNDRM API.                =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( RtvJobMsgw )                               =  */
/*  =             Pgm( RtvJobMsgw )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  =             Allow( (*BPGM) (*IPGM ) )                       =  */
/*  ===============================================================  */
/*  = Date  : 2024/12/24                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             CMD        Prompt('Retrieve Job MSGW Information')

             Parm       Kwd( JOB ) +
                        Type(Q0001) +
                        Dft(*) +
                        Sngval( +
                          (* ) +
                          (*INT )) +
                        Prompt('Job' 1)

             Parm       Kwd( INTJOBID ) +
                        Type( *CHAR ) +
                        Len( 16 ) +
                        Dft( *BLANK ) +
                        Spcval( +
                          (*BLANK '                ')) +
                        Prompt( 'Internal job identifier' 2 )

             Parm       Kwd( MSGRPY )                                +
                        Type( *CHAR )                                +
                        Len(  1 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for MSGRPY       ( 1)')

             Parm       Kwd( MSGKEY )                                +
                        Type( *CHAR )                                +
                        Len(  4 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for JOB          ( 4)' )

             Parm       Kwd( MSGQ   )                                +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for MSGQ         (10)' )

             Parm       Kwd( MSGQLIB )                               +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for MSGQLIB      (10)' )

             Parm       Kwd( MSGID )                                 +
                        Type( *CHAR )                                +
                        Len(  7 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for MSGID        ( 7)' )

             Parm       Kwd( MSGTYPE )                                +
                        Type( *CHAR )                                +
                        Len(  2 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for MSGTYPE      ( 2)' )

             Parm       Kwd( MSGTXT )                                 +
                        Type( *CHAR )                                +
                        Len( 132 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for MSGTXT      (132)' )

             Parm       Kwd( SECLVL )                                 +
                        Type( *CHAR )                                +
                        Len( 256 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for SECLVL      (256)' )

             Parm       Kwd( MSGDTA )                                 +
                        Type( *CHAR )                                +
                        Len( 192 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for MSGDTA      (192)' )

             Parm       Kwd( MSGF   )                                 +
                        Type( *CHAR )                                +
                        Len(  10 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for MSGF         (10)' )

             Parm       Kwd( MSGFLIB )                                +
                        Type( *CHAR )                                +
                        Len(  10 )                                   +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for MSGFLIB      (10)' )

             Parm       Kwd( ERRPGM )                                 +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for ERRPGM       (10)' )

             Parm       Kwd( ERRPGMLIB )                             +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for ERRPGMLIB    (10)' )

             Parm       Kwd( ERRMSGID )                              +
                        Type( *CHAR )                                +
                        Len(  7 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for ERRMSGID     ( 7)' )

             Parm       Kwd( ERRPGMSTMT )                            +
                        Type( *CHAR )                                +
                        Len( 10 )                                    +
                        RtnVal( *YES )                               +
                        Prompt( 'CL var for ERRPGMSTMT   (10)' )


Q0001:       Qual       Type( *NAME ) +
                        Len( 10 )

             Qual       Type( *NAME ) +
                        Len( 10 ) +
                        Prompt( 'User' )

             Qual       Type( *CHAR ) +
                        Len( 6 ) +
                        Prompt('Number')

