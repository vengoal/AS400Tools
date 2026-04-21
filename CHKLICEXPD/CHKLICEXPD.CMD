/*  ===============================================================  */
/*  = Command....... ChkLicExpD                                   =  */
/*  = CPP........... ChkLicExpD                                   =  */
/*  = Description... Check License Key Expiration Date            =  */
/*  =                                                             =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( ChkLicExpD )                               =  */
/*  =             Pgm( ChkLicExpD )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  ===============================================================  */
/*  = Date  : 2024/10/23                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
             Cmd        Prompt('Check License Key Expiration')

             Parm       Kwd(DAYS)                                    +
                          Type(*INT2)                                +
                          Dft(30)                                    +
                          Prompt('Days before expiration date')

             Parm       Kwd(MSGQ)                                    +
                          Type(QUAL1)                                +
                          Min(1)                                     +
                          Prompt('Message queue')

 QUAL1:      Qual       Type(*NAME) EXPR(*YES) +
                          Dft(QSYSOPR)

             Qual       Type(*NAME)                                  +
                          Dft(*LIBL)                                 +
                          SpcVal((*LIBL) (*CURLIB))                  +
                          Expr(*YES)                                 +
                          Prompt('Library')

