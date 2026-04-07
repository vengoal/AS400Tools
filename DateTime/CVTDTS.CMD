/*  ===============================================================  */
/*  = Command....... CVTDTS                                       =  */
/*  = CPP........... CVTDTS     CLP                               =  */
/*  = Description... Convert DTS to date/time                     =  */
/*  =                                                             =  */
/*  = Compile options:                                            =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( CVTDTS )                                   =  */
/*  =             Pgm( CVTDTS )                                   =  */
/*  =             SrcMbr( CVTDTS  )                               =  */
/*  =             Allow(                                          =  */
/*  =                   *IREXX                                    =  */
/*  =                   *BREXX                                    =  */
/*  =                   *BPGM                                     =  */
/*  =                   *IPGM                                     =  */
/*  =                  )                                          =  */
/*  ===============================================================  */
/*  = Date  : 2011/07/14                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             Cmd        Prompt( 'Convert DTS to Date/Time'   )

             Parm       DTS         *Char         8        +
                        Min( 1 )                           +
                        Expr( *YES )                       +
                        Prompt( 'DTS' )

             Parm       RTNDATE     *Char         8        +
                        RTNVAL(*YES)                       +
                        Prompt( 'Return date format YYYYMMDD(8)')

             Parm       RTNTIME     *Char         6        +
                        RTNVAL(*YES)                       +
                        Prompt( 'Return time format HHMMSS  (6)')

             Parm       RTNMILLSEC  *Char         3        +
                        RTNVAL(*YES)                       +
                        Prompt( 'Return millsec format sss  (3)')

