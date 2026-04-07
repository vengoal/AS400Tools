/*  ===============================================================  */
/*  = Command....... RTVDTAARAD                                   =  */
/*  = CPP........... RTVDTAARAD CLP                               =  */
/*  =                                                             =  */
/*  = Description...                                              =  */
/*  =  Retrieve data area  description command retrieves the      =  */
/*  =  attributes of a data area                                  =  */
/*  =  the API QWCRDTAA is used.                                  =  */
/*  =                                                             =  */
/*  = CrtCmd      Cmd( RtvDtaAraD )                               =  */
/*  =             Pgm( RtvDtaAraD )                               =  */
/*  =             SrcFile( YourSourceFile )                       =  */
/*  =             Allow ( *Ipgm *Bpgm )                           =  */
/*  ===============================================================  */
/*  = Date  : 2024/11/12                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */

             Cmd        Prompt( 'Retrieve Data Area Description' )

             Parm       Kwd( DtaAra )                               +
                        Type( Qual1 )                               +
                        Min( 1 )                                    +
                        Prompt('Data area'  )

             Parm       Kwd( RtnLib )                               +
                        Type( *Char )                               +
                        Len( 10 )                                   +
                        Rtnval( *Yes )                              +
                        Prompt( 'CL var for RTNLIB       (10) .' )

/*  ===============================================================  */
/*  = Type  - Type of data queue                                  =  */
/*  =         *CHAR *DEC *LGL                                     =  */
/*  ===============================================================  */
             Parm       Kwd( Type )                                 +
                        Type( *Char )                               +
                        Len( 10 )                                   +
                        Rtnval( *Yes )                              +
                        Prompt( 'CL var for TYPE         (10) .' )

/*  ===============================================================  */
/*  = Length- Data length                                         =  */
/*  ===============================================================  */
             Parm       Kwd( Length )                               +
                        Type( *Dec )                                +
                        Len( 5 0 )                                  +
                        Rtnval( *Yes )                              +
                        Prompt( 'CL var for LENGTH      (5 0) .' )

/*  ===============================================================  */
/*  = DecPos- Decimal position                                    =  */
/*  ===============================================================  */
             Parm       Kwd( DecPos )                               +
                        Type( *Dec )                                +
                        Len( 2 0 )                                  +
                        Rtnval( *Yes )                              +
                        Prompt( 'CL var for DECPOS      (2 0) .' )

/*  ===============================================================  */
/*  = Text - Description                                          =  */
/*  ===============================================================  */
             Parm       Kwd( Text )                                 +
                        Type( *Char )                               +
                        Len( 50 )                                   +
                        Rtnval( *Yes )                              +
                        Prompt( 'CL var for TEXT         (50) .' )

/*  ===============================================================  */
/*  = Owner    -                                                  =  */
/*  ===============================================================  */
             Parm       Kwd( Owner )                                +
                        Type( *Char )                               +
                        Len( 10 )                                   +
                        Rtnval( *Yes )                              +
                        Prompt( 'CL var for OWNER        (10) .' )

 Qual1:      Qual       Type( *Name )                               +
                        Expr( *Yes )
             Qual       Type( *Name )                               +
                        Dft( *Libl )                                +
                        Spcval(( *Libl ) ( *CurLib ))               +
                        Expr( *Yes )                                +
                        Prompt( 'Library' )
