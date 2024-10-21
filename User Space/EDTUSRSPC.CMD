/*  ===============================================================  */
/*  = Command....... EdtUsrSpc                                    =  */
/*  = CPP........... EdtUsrSpc CLP                                =  */
/*  = Description... Edit user space contents                     =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( EdtUsrSpc )                                =  */
/*  =             Pgm( EdtUsrSpc  )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  ===============================================================  */
/*  = Date  : 2024/10/21                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             Cmd        Prompt('Edit User Space')

             Parm       Kwd(USRSPC)                                 +
                        Type(QUAL1)                                 +
                        Min(1)                                      +
                        Prompt('User space')

             Parm       Kwd(ACTION)                                 +
                        Type(*CHAR)                                 +
                        Len( 4 )                                    +
                        Constant( *EDT )                            +

 QUAL1:      Qual       Type(*NAME)                                 +
                        Expr(*YES)
             Qual       Type(*NAME)                                 +
                        Dft(*LIBL)                                  +
                        SpcVal((*LIBL) (*CURLIB))                   +
                        Expr(*YES)                                  +
                        Prompt('Library')
