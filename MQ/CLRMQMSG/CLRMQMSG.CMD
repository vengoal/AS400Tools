/*  ===============================================================  */
/*  = Command....... CLRMQMSG                                     =  */
/*  = CPP........... CLRMQMSG RPGLE                               =  */
/*  = Description... Clear MQ Expired Message                     =  */
/*  =                                                             =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( CLRMQMSG   )                               =  */
/*  =             Pgm( CLRMQMSG   )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  ===============================================================  */
/*  = Date  : 2025/01/23                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  =                                                             =  */
/*  ===============================================================  */
/*  =                                                             =  */
/*  = Notes:                                                      =  */
/*  =                                                             =  */
/*  = 1.                                                          =  */
/*  =   ADDLIBLE QMQM                                             =  */
/*  =                                                             =  */
/*  = 2.STRPDM OPTION 15 CRTMOD with member CLRMQMSG              =  */
/*  =   CRTPGM PGM(CLRMQMSG) BNDSRVPGM((QMQM/LIBMQM))             =  */
/*  =                                                             =  */
/*  = 3.CRTCMD CMD(CLRMQMSG) PGM(CLRMQMSG) ALLOW(*ALL)            =  */
/*  ===============================================================  */

             Cmd        Prompt('Clear MQ expired message')

             Parm       Kwd(MQMQ) Type(*NAME)                +
                        Len(48)                              +
                        Min(1)                               +
                        Prompt('MQ Queue name')

             Parm       Kwd(QMNAME) Type(*NAME)              +
                        Len(48)                              +
                        Min(1)                               +
                        Prompt('Queue manager name')

             Parm       Kwd(EXPSEC) Type(*DEC )              +
                        Len(5 0)                             +
                        Range( 1        99999 )              +
                        Min(1)                               +
                        Prompt('Expired seconds')

             Parm       Kwd(DLTEXPMSG) Type(*CHAR)           +
                        Len(4)                               +
                        Rstd(*YES)                           +
                        Dft(*NO)                             +
                        Values(*YES *NO)                     +
                        Prompt('Delete expired message')
