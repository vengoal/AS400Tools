/*  ===============================================================  */
/*  = Command....... ChgUsrSpcA                                   =  */
/*  = CPP........... ChgUsrSpcA CLP                               =  */
/*  = Description... Change user space attributes                 =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( ChgUsrSpcA )                               =  */
/*  =             Pgm( ChgUsrSpcA )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  ===============================================================  */
/*  = Date  : 2024/11/11                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             Cmd        Prompt('Change User Space Attributes')

             Parm       Kwd(USRSPC)                                 +
                        Type(QUAL1)                                 +
                        Min(1)                                      +
                        Prompt('User space')

             Parm       Kwd(AutoExt) +
                        Type(*Char) +
                        Len(04) +
                        Rstd(*YES) +
                        Dft(*YES) +
                        VALUES( +
                          '*YES' +
                          '*NO') +
                        PROMPT('Auto extend        ')
             Parm       Kwd(INLVALUE) +
                        Type(*HEX) +
                        Len(1) +
                        Dft(X'F0F0') +
                        Choice('Single-char *HEX') +
                        Prompt('Initial value to fill'  )

 QUAL1:      Qual       Type(*NAME)                                 +
                        Expr(*YES)
             Qual       Type(*NAME)                                 +
                        Dft(*LIBL)                                  +
                        SpcVal((*LIBL) (*CURLIB))                   +
                        Expr(*YES)                                  +
                        Prompt('Library')
