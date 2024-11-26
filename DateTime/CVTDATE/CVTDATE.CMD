/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Command . . : CVTDATE                                            */
/*  Description : Convert Date                                       */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePaper                                        */
/*  Date  . . . : November 25, 2024                                  */
/*                                                                   */
/*                                                                   */
/*  Command processing API:                                          */
/*    CEEDAYS     Convert Date to Lilian Format                      */
/*                                                                   */
/*    CEEDATE     Formats a number representing a Lilian date        */
/*                                                                   */
/*  Programmer's notes:                                              */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( CVTDATE )                                          */
/*           Pgm( CVTDATE  )                                         */
/*           SrcMbr( CVTDATE )                                       */
/*           Allow( *IPGM *BPGM )                                    */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Convert Date' )

             PARM       KWD(DATE) +
                        TYPE(*CHAR) +
                        LEN(10) +
                        MIN(1) +
                        EXPR(*YES) +
                        VARY(*YES) +
                        PROMPT('Date to be converted')
             PARM       KWD(TOVAR) +
                        TYPE(*CHAR) +
                        LEN(10) +
                        RTNVAL(*YES) +
                        MIN(1) +
                        VARY(*YES) +
                        PROMPT('CL var for converted date')
             PARM       KWD(FROMFMT) +
                        TYPE(*INT4) +
                        RSTD(*YES) +
                        DFT(*JOB) +
                        SPCVAL( +
                          (*SYSVAL 1) +
                          (*MDY 2) +
                          (*DMY 3) +
                          (*YMD 4) +
                          (*JUL 5) +
                          (*JOB 6) +
                          (*MDYY 7) +
                          (*DMYY 8) +
                          (*YYMD 9) +
                          (*CYMD 10) +
                          (*LONGJUL 15)) +
                        EXPR(*YES) +
                        PROMPT('From date format')
             PARM       KWD(TOFMT) +
                        TYPE(*INT4) +
                        RSTD(*YES) +
                        DFT(*JOB) +
                        SPCVAL( +
                          (*SYSVAL 1) +
                          (*MDY 2) +
                          (*DMY 3) +
                          (*YMD 4) +
                          (*JUL 5) +
                          (*JOB 6) +
                          (*MDYY 7) +
                          (*DMYY 8) +
                          (*YYMD 9) +
                          (*CYMD 10) +
                          (*LONGJUL 15)) +
                        EXPR(*YES) +
                        PROMPT('To date format')
