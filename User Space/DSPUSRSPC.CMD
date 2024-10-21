/*  ===============================================================  */
/*  = Command....... DspUsrSpc                                    =  */
/*  = CPP........... DspUsrSpc CLP                                =  */
/*  = Description... Display user space contents                  =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( DspUsrSpc )                                =  */
/*  =             Pgm( DspUsrSpc  )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  ===============================================================  */
/*  = Date  : 2024/10/21                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             Cmd        Prompt('Display User Space')

             Parm       Kwd(USRSPC)                                 +
                        Type(QUAL1)                                 +
                        Min(1)                                      +
                        Prompt('User space')

 QUAL1:      Qual       Type(*NAME)                                 +
                        Expr(*YES)
             Qual       Type(*NAME)                                 +
                        Dft(*LIBL)                                  +
                        SpcVal((*LIBL) (*CURLIB))                   +
                        Expr(*YES)                                  +
                        Prompt('Library')
